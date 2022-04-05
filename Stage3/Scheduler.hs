module Scheduler
(
    schedule,
)
where
import Course
import CourseData
import Schedule

schedule :: CourseData -> Int -> Maybe Schedule 
claim :: [String] -> [Course] -> Int -> [Course]
schedule' :: [Course] -> [Schedule]
buildCourseList :: [Course] -> [Course] -> [Course]
buildSchedule :: [Course] -> Int -> [Course]


schedule courseData timeSlots 
    | isEmptySched (head (schedule' completeCourseList)) = Nothing
    | otherwise = Just (head (schedule' completeCourseList))
    where completeCourseList = buildSchedule courseData timeSlots


schedule' []  = [emptySchedule]
schedule' (course : restOfCourses) = [ addEntry (getName course) timeSlot schedule  |  timeSlot <- getSlots course, schedule <- schedule' (claim (getAdjacent course) restOfCourses timeSlot)]

claim courseNames [] timeSlot = []
claim courseNames (course : restOfCourses) timeSlot 
    | (elem (getName course) courseNames) = (ruleOutSlot timeSlot course) : (claim courseNames restOfCourses timeSlot)
    | otherwise = copyCourse course : (claim courseNames restOfCourses timeSlot)

--Builds complete course list given courseData
buildSchedule [] _ = []
buildSchedule courseData timeSlots =     
    let courseList = [ newCourse name ids timeSlots | (name,ids) <- courseData ]
    in buildCourseList courseList courseList

--Adds adjacency list to a list of Courses resulting in a complete course list
buildCourseList _ [] = []
buildCourseList courseList (course : restOfCourses) = setAdjacent courseList course : buildCourseList courseList restOfCourses



