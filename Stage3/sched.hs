import Schedule
import Scheduler
import Course
import CourseData
import Data.Char
import RoomData

{- Project Leads: Kiril and Johann -}

{-Functionally the main program of the entire program.
After passing in two filepaths, the function reads the files
into the system and processes them into an array of Strings, where
elements are defined by the whitespace between them. These string
arrays get processed into a course structure and a room structure respectively,
before then being grouped together with the user defined timeslot to
create a schedule. The result of this gets processed into a string and output
to console.-}
sched :: FilePath -> FilePath-> Int -> IO()
sched course room val = readFile(course) >>= \str -> readFile(room) >>= \rm
           -> putStr(toString(stripMaybe(schedule (processFile(words str)) (grabRooms(words rm)) val)))

{-processFile takes in an array of strings
and recursively creates a course data structure of
form [(String,[Int])], where the string is the class name
and the array of integers are the student ID's-}
processFile :: [String] -> CourseData
processFile [] = []
processFile x = createClass x:processFile(drop (getLen (createClass x)) x)

{-getLen is a custom function to find the length of
the courseData structure by the length of the integer
array plus the String (taking the form of a +1)-}
getLen :: (String,[Int]) -> Int
getLen (_,b) = 1 + length b

{-Create class takes in an Array of strings and
processes them into the form (String,[Int]). Error
checking determins if the Student array is empty (no
students) or if the name of the course is simply a number
(wrong course formatting).-}
createClass :: [String] -> (String,[Int])
createClass (x:xs) = if (grabStudents xs) == []
                        then error "Class is Empty!"
                     else
                        if (not (stringIsInt x))
                            then (x,grabStudents xs)
                        else
                            error "Class name is a number!"

{-grabStudents processes a passed in string and
creates a list of integers until it encounters a non-numeric
string-}
grabStudents :: [String] -> [Int]
grabStudents [] = []
grabStudents (x:xs) = if stringIsInt x
                         then (read x :: Int):grabStudents(xs)
                      else
                         []

{-grabRooms is the equivalent of processFile for
RoomData. It takes in an array of Strings and processes
it to return an array of form [(String,Int)], where the
string is the room name and the int is its capacity. The
Error checking relies on the fact that in order for the Room
file to work properly, it must contain an even number of terms.-}
grabRooms :: [String] -> RoomData
grabRooms [] = []
grabRooms (x) = if odd (length x) 
                   then error "Rooms is missing data!"
                else
                   popRoom x:grabRooms(drop 2 x)

{-popRoom processes the top two elements of a String
array and turns it into the form (String,Int)-}
popRoom :: [String] -> (String,Int)
popRoom (x:y:zs) = if stringIsInt y && not (stringIsInt x)
                       then (x,read y :: Int)
                   else
                       error "Room formatted wrong!"

{-this function goes through a string character by character
to determine if the entire string is numeric or not.-}
stringIsInt :: String -> Bool
stringIsInt [] = True
stringIsInt (x:xs) = isDigit(x) && stringIsInt(xs)

{-This function is going to get us to lose marks, but its
purpose is to strip Maybe from Schedule. If it's Nothing,
an error is thrown-}
stripMaybe :: Maybe Schedule -> Schedule
stripMaybe (Just (x)) = x
stripMaybe Nothing = error "Classes could not be resolved into a schedule"