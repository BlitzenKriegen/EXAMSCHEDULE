module Course
(
Course,
newCourse,
getName,
setAdjacent,
getAdjacent,
getSlots,
ruleOutSlot
)
where
import Data.IntSet
newCourse :: String -> [Int] -> Int -> Course
getName :: Course -> String
setAdjacent :: [Course] -> Course -> Course
getAdjacent :: Course -> [String]
getSlots :: Course -> [Int]
ruleOutSlot :: Int -> Course -> Course
data Course = Cr (String,IntSet,[String],IntSet)
deriving (Show)