module Course
(
    Course,
    newCourse,
    getName,
    setAdjacent,
    getAdjacent,
    getSlots,
    ruleOutSlot,
    copyCourse,
    getNumStuds,

)
where

import Data.IntSet
import CourseData

data Course = Cr { course_name :: String, id_set :: IntSet, adj_courses :: [String], time_slots :: IntSet}
    deriving (Show)

newCourse :: String -> [Int] -> Int -> Course
newCourse name list timeslots = Cr {course_name = name, id_set = fromList list,adj_courses = [ ],time_slots = fromList [0..(timeslots-1)]}

copyCourse :: Course -> Course
copyCourse course = Cr {course_name = getName course, id_set = getIdSet course, adj_courses = getAdjacent course,time_slots = getTimeSlots course}

getName :: Course -> String
getName Cr {course_name = course} = course

getAdjacent :: Course -> [String]
getAdjacent Cr {adj_courses = adj} = adj

getIdSet :: Course -> IntSet
getIdSet Cr {id_set = studentlist} = studentlist

getNumStuds :: Course -> Int
getNumStuds Cr {id_set = studentlist} = size studentlist

getTimeSlots :: Course -> IntSet
getTimeSlots Cr {time_slots = timeslots} = timeslots

getSlots :: Course -> [Int]
getSlots Cr {time_slots = timeslots} = toList timeslots

setAdjacent :: [Course] -> Course -> Course
setAdjacent courseList course = let adjlist = createAdjacentList courseList course
    in Cr {course_name = getName course, id_set = getIdSet course,adj_courses = adjlist,time_slots = getTimeSlots course}

createAdjacentList :: [Course] -> Course -> [String]
createAdjacentList [] course = getAdjacent course
createAdjacentList (x:xs) course 
    | (getName x == getName course) || (disjoint (getIdSet x) (getIdSet course)) = createAdjacentList xs course
    |otherwise = getName x:createAdjacentList xs course
    
ruleOutSlot :: Int -> Course -> Course
ruleOutSlot slotNum course = let newTimeSlot = (delete slotNum (getTimeSlots course))
    in Cr {course_name = getName course, id_set = getIdSet course, adj_courses = getAdjacent course,time_slots = newTimeSlot}




