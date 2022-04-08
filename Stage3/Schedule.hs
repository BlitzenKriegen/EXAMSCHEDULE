{- ADT created by Marc Schroeder
   Implementation created by Kiril and Johann -}
module Schedule
(
Schedule, -- a "Schedule" ADT, with two public operations
emptySchedule,
addEntry,
isEmptySched,
toString, -- no error checking: allows duplicate and
-- contradictory entries
)
where
emptySchedule :: Schedule
emptySchedule = Sched []

{- Appends a schedule structure by adding a new entry at the
head of the list. -}
addEntry :: String -> Int -> String -> Schedule -> Schedule
addEntry str val str2 (Sched lst) = Sched ((str,val,str2):lst)

{- Checks if the Schedule passes in is empty or not -}
isEmptySched :: Schedule -> Bool
isEmptySched (Sched lst) = lst == [] 

{- Helper function -}
printResults :: String -> IO()
printResults str = putStr str

{- Converts a schedule structure into a string formatted to go
through putStr(). The string created has the form "Course Timeslot Room \n" -}
toString :: Schedule -> String
toString (Sched []) = []
toString (Sched ((str,val,str2):rest)) = (str ++ " " ++ show (val) ++ " " ++ str2) 
                                    ++ "\n" ++ toString (Sched rest)

data Schedule = Sched [(String,Int,String)]
    deriving (Show)

