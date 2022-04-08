
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
addEntry :: String -> Int -> String -> Schedule -> Schedule
addEntry str val str2 (Sched lst) = Sched ((str,val,str2):lst)
isEmptySched :: Schedule -> Bool
isEmptySched (Sched lst) = lst == [] 

printResults :: String -> IO()
printResults str = putStr str

toString :: Schedule -> String
toString (Sched []) = []
toString (Sched ((str,val,str2):rest)) = (str ++ " " ++ show (val) ++ " " ++ str2) 
                                    ++ "\n" ++ toString (Sched rest)

data Schedule = Sched [(String,Int,String)]
    deriving (Show)

