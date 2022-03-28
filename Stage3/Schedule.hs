module Schedule
(
Schedule, -- a "Schedule" ADT, with two public operations
emptySchedule,
addEntry -- no error checking: allows duplicate and
-- contradictory entries
)
where
emptySchedule :: Schedule
emptySchedule = Sched [("",0)]
addEntry :: String -> Int -> Schedule -> Schedule
addEntry str val schedule = Sched [(str,val)]
data Schedule = Sched [(String,Int)]
    deriving (Show)