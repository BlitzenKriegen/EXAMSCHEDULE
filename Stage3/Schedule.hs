module Schedule
(
Schedule, -- a "Schedule" ADT, with two public operations
emptySchedule,
addEntry -- no error checking: allows duplicate and
-- contradictory entries
)
where
emptySchedule :: Schedule
emptySchedule = [([],0)]
addEntry :: String -> Int -> Schedule -> Schedule
addEntry str val = [(str,val)]
data Schedule = Sched [(String,Int)]
	deriving (Show)