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
buildSchedule :: CourseData -> Int -> [Course]


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





{- 
*use with index set to 0
- if return value is negative, course name not found in course list
given a course name string and a list of courses, gives index for the course list element     that matches the course name
-}

--findCourse courseName [] index = -9999
--findCourse courseName (course : restOfCourses) index 
--   | courseName == getName course = index
--    | otherwise                    = findCourse courseName restOfCourses index+1


