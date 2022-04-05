module Scheduler
(
    --schedule,
)
where
import Course
import CourseData
import Schedule

type Placement = (Int,Int)       -- a Placement is a col/row (x,y) coordinate pair
type Solution  = [Placement]

numQueens = 8
range     = [1..numQueens]

schedule :: CourseData -> Int -> [Course]
claim :: [String] -> [Course] -> Int -> [Course]
schedule' :: [Course] -> [Schedule]

schedule [] _ = []
schedule courseData timeSlots = let courseList = [ newCourse name ids timeSlots | (name,ids) <- courseData ]
    in buildCourseList courseList courseList


schedule' []  = [emptySchedule]
schedule' (course : restOfCourses) = [ schedule  |  timeSlot <- getSlots course, let restOfCoursesClaimed = claim (getAdjacent course) restOfCourses timeSlot, let schedule = addEntry (getName course) timeSlot emptySchedule]

claim courseNames [] timeSlot = []
claim courseNames (course : restOfCourses) timeSlot 
    | (elem (getName course) courseNames) = (ruleOutSlot timeSlot course) : (claim courseNames restOfCourses timeSlot)
    | otherwise = copyCourse course : (claim courseNames restOfCourses timeSlot)

buildCourseList _ [] = []
buildCourseList courseList (course : restOfCourses) = setAdjacent courseList course : buildCourseList courseList restOfCourses



solveForColumns :: [Int] -> [Solution]

solveForColumns []         = [ [] ]     -- one solution to no columns: an empty list of placements!

solveForColumns (col:rest) = [ placement:solRest | solRest <- solveForColumns rest,  row <- range, let placement = (col,row), noAttack placement solRest]



noAttack :: Placement -> Solution -> Bool     -- determinplacement is conflict-free with the given list of placements

noAttack (x,y) = and . map noIndividualAttack

     where noIndividualAttack (x2,y2) = y /= y2 && abs (y-y2) /= abs (x-x2)     -- not in same row && not in same column








{- 
*use with index set to 0
- if return value is negative, course name not found in course list
given a course name string and a list of courses, gives index for the course list element     that matches the course name
-}

--findCourse courseName [] index = -9999
--findCourse courseName (course : restOfCourses) index 
--   | courseName == getName course = index
--    | otherwise                    = findCourse courseName restOfCourses index+1


