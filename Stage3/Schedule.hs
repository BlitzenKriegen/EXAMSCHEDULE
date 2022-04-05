module Schedule
(
Schedule, -- a "Schedule" ADT, with two public operations
emptySchedule,
addEntry,
isEmptySched
-- no error checking: allows duplicate and
-- contradictory entries
)
where
emptySchedule :: Schedule
emptySchedule = Sched []

addEntry :: String -> Int -> Schedule -> Schedule
addEntry str val (Sched lst) = Sched ((str,val):lst)

isEmptySched :: Schedule -> Bool
isEmptySched (Sched lst) = lst == [] 

printResults :: String -> IO()
printResults str = putStr str

toString :: Schedule -> String
toString (Sched []) = []
toString (Sched ((str,val):rest)) = (str ++ " " ++ show (val)) 
                                    ++ "\n" ++ toString (Sched rest)

data Schedule = Sched [(String,Int)]
    deriving (Show)
