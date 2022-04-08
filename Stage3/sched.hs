import Schedule
import Scheduler
import Course
import CourseData
import Data.Char
import RoomData

{-oldSched :: CourseData -> Int -> IO()
oldSched info timeslot = putStr(toString(stripMaybe(schedule info timeslot)))
-}
sched :: FilePath -> FilePath-> Int -> IO()
sched course room val = readFile(course) >>= \str -> readFile(room) >>= \rm
           -> putStr(toString(stripMaybe(schedule (processFile(words str)) (grabRooms(words rm)) val)))

processFile :: [String] -> CourseData
processFile [] = []
processFile x = createClass x:processFile(drop (getLen (createClass x)) x)

getLen :: (String,[Int]) -> Int
getLen (_,b) = 1 + length b

createClass :: [String] -> (String,[Int])
createClass (x:xs) = if (grabStudents xs) == []
                        then error "Class is Empty!"
                     else
                        (x,grabStudents xs)

grabStudents :: [String] -> [Int]
grabStudents [] = []
grabStudents (x:xs) = if stringIsInt x
                         then (read x :: Int):grabStudents(xs)
                      else
                         []

grabRooms :: [String] -> RoomData
grabRooms [] = []
grabRooms (x) = if odd (length x) 
                   then error "Rooms is missing data!"
                else
                   popRoom x:grabRooms(drop 2 x)

popRoom :: [String] -> (String,Int)
popRoom (x:y:zs) = if stringIsInt y
                       then (x,read y :: Int)
                   else
                       error "Room formatted wrong!"

stringIsInt :: String -> Bool
stringIsInt [] = True
stringIsInt (x:xs) = isDigit(x) && stringIsInt(xs)

stripMaybe :: Maybe Schedule -> Schedule
stripMaybe (Just (x)) = x
stripMaybe Nothing = error "Classes could not be resolved into a schedule"