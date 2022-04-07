import Schedule
import Scheduler
import Course
import CourseData
import Data.Char

oldSched :: CourseData -> Int -> IO()
oldSched info timeslot = putStr(toString(stripMaybe(schedule info timeslot)))

sched :: FilePath -> Int -> IO()
sched file val = readFile(file) >>= \str 
                           -> putStr(toString(stripMaybe(schedule (processFile(words str)) val)))

processFile :: [String] -> CourseData
processFile [] = []
processFile x = createClass x:processFile(drop (getLen (createClass x)) x)

getLen :: (String,[Int]) -> Int
getLen (_,b) = 1 + length b

createClass :: [String] -> (String,[Int])
createClass (x:xs) = (x,grabStudents xs)

grabStudents :: [String] -> [Int]
grabStudents [] = []
grabStudents (x:xs) = if stringIsInt x
                         then (read x :: Int):grabStudents(xs)
                      else
                         []


stringIsInt :: String -> Bool
stringIsInt [] = True
stringIsInt (x:xs) = isDigit(x) && stringIsInt(xs)

stripMaybe :: Maybe Schedule -> Schedule
stripMaybe (Just (x)) = x
stripMaybe Nothing = emptySchedule