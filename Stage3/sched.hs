import Schedule
import Scheduler
import Course
import CourseData

sched :: CourseData -> Int -> IO()
sched info timeslot = putStr(toString(stripMaybe(schedule info timeslot)))

stripMaybe :: Maybe Schedule -> Schedule
stripMaybe (Just (x)) = x
stripMaybe Nothing = emptySchedule