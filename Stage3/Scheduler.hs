module Scheduler
(
    schedule,
)
where
import Course
import CourseData
import Schedule
import Room
import TimeSlot
import RoomData

schedule :: CourseData -> RoomData -> Int -> Maybe Schedule 
schedule courseData roomData timeSlots
    | isEmptySched (head (schedule' completeCourseList timeSlotList)) = Nothing
    | otherwise = Just (head (schedule' completeCourseList timeSlotList))
    where completeCourseList = buildSchedule courseData timeSlots
          timeSlotList = buildTimeSlotList roomData timeSlots

schedule' :: [Course] -> [TimeSlot] -> [Schedule]
schedule' [] _  = [emptySchedule]
schedule' (course : restOfCourses) timeslotlist = 
    [ addEntry (getName course) timeSlot (getRoomName room) schedule  |  timeSlot <- getSlots course, room <- toListRooms(timeslotlist !! timeSlot),
    schedule <- schedule' (claim (getAdjacent course) restOfCourses timeSlot) 
    (changeRoomCapacityInList timeslotlist timeSlot 0 (getRoomName room) (getNewCapacity room course)),
    (getRoomCapacity room) >= (getNumStuds course) ]

claim :: [String] -> [Course] -> Int -> [Course]
claim courseNames [] timeSlot = []
claim courseNames (course : restOfCourses) timeSlot
    | (elem (getName course) courseNames) = (ruleOutSlot timeSlot course) : (claim courseNames restOfCourses timeSlot)
    | otherwise = copyCourse course : (claim courseNames restOfCourses timeSlot)

{-
Builds a single timeslot out of room data
-}
buildTimeSlot :: RoomData -> TimeSlot
buildTimeSlot [] = emptyTimeSlot
buildTimeSlot (roomData : rest) = addRoom (newRoom (fst roomData) (snd roomData)) (buildTimeSlot rest)

{-
Builds a list of timeslots out of room data and a number of timeslots
-}
buildTimeSlotList :: RoomData -> Int -> [TimeSlot]
buildTimeSlotList roomData 0 = []
buildTimeSlotList roomData timeslots = let newSlots = timeslots - 1 
    in buildTimeSlot roomData : buildTimeSlotList roomData newSlots


{-
 Notes: use with counter set to 0

 Given a list of timeslots, an Index, the room name to be changed and the new capacity,
 returns an identical list of timeslots with that room in the specific index changed with
 the new capacity
-}
changeRoomCapacityInList :: [TimeSlot] -> Int -> Int -> String -> Int -> [TimeSlot]
changeRoomCapacityInList [] index counter roomName newCapacity = []
changeRoomCapacityInList (timeSlotList:rest) index counter roomName newCapacity 
    | index == counter = changeRoomCapacity timeSlotList roomName newCapacity : changeRoomCapacityInList rest index (counter+1) roomName newCapacity
    | otherwise = copyTimeSlot timeSlotList : changeRoomCapacityInList rest index (counter+1) roomName newCapacity 


getNewCapacity :: Room -> Course -> Int 
getNewCapacity room course = (getRoomCapacity room) - (getNumStuds course) 


--Builds complete course list given courseData
buildSchedule :: CourseData -> Int -> [Course]
buildSchedule [] _ = []
buildSchedule courseData timeSlots =     
    let courseList = [ newCourse name ids timeSlots | (name,ids) <- courseData ]
    in buildCourseList courseList courseList

--Adds adjacency list to a list of Courses resulting in a complete course list
buildCourseList :: [Course] -> [Course] -> [Course]
buildCourseList _ [] = []
buildCourseList courseList (course : restOfCourses) = setAdjacent courseList course : buildCourseList courseList restOfCourses


