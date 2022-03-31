module Schedule
(
Schedule, -- a "Schedule" ADT, with two public operations
emptySchedule,
addEntry -- no error checking: allows duplicate and
-- contradictory entries
)
where
emptySchedule :: Schedule
emptySchedule = Sched []
addEntry :: String -> Int -> Schedule -> Schedule
addEntry str val (Sched lst) = Sched ((str,val):lst)
data Schedule = Sched [(String,Int)]
    deriving (Show)