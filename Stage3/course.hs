module Course
(
    Course,
    newCourse,
    getName,
    setAdjacent,
    getAdjacent,
    getSlots,
    ruleOutSlot,
    copyCourse

)
where

import Data.IntSet
import CourseData

newCourse :: String -> [Int] -> Int -> Course
copyCourse :: Course -> Course
getName :: Course -> String
getAdjacent :: Course -> [String]
getIdSet :: Course -> IntSet
getTimeSlots :: Course -> IntSet
getSlots :: Course -> [Int]
setAdjacent :: [Course] -> Course -> Course
createAdjacentList :: [Course] -> Course -> [String]
ruleOutSlot :: Int -> Course -> Course


data Course = Cr { course_name :: String, id_set :: IntSet, adj_courses :: [String], time_slots :: IntSet}
    deriving (Show)

newCourse name list timeslots = Cr {course_name = name, id_set = fromList list,adj_courses = [ ],time_slots = fromList [1..timeslots]}

copyCourse course = Cr {course_name = getName course, id_set = getIdSet course, adj_courses = getAdjacent course,time_slots = getTimeSlots course}

getName Cr {course_name = course} = course

getAdjacent Cr {adj_courses = adj} = adj

getIdSet Cr {id_set = studentlist} = studentlist

getTimeSlots Cr {time_slots = timeslots} = timeslots

getSlots Cr {time_slots = timeslots} = toList timeslots

setAdjacent courseList course = let adjlist = createAdjacentList courseList course
    in Cr {course_name = getName course, id_set = getIdSet course,adj_courses = adjlist,time_slots = getTimeSlots course}

createAdjacentList [] course = getAdjacent course
createAdjacentList (x:xs) course 
    | (getName x == getName course) || (disjoint (getIdSet x) (getIdSet course)) = createAdjacentList xs course
    |otherwise = getName x:createAdjacentList xs course
    

ruleOutSlot slotNum course = let newTimeSlot = (delete slotNum (getTimeSlots course))
    in Cr {course_name = getName course, id_set = getIdSet course, adj_courses = getAdjacent course,time_slots = newTimeSlot}




