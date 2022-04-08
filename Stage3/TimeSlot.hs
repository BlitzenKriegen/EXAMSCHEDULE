module TimeSlot
(
TimeSlot,
emptyTimeSlot,
addRoom,
changeRoomCapacity,
copyTimeSlot,
toListRooms,

)
where
import Room

emptyTimeSlot :: TimeSlot
emptyTimeSlot = Slot []

addRoom :: Room -> TimeSlot -> TimeSlot
addRoom room (Slot list) = Slot (room:list)

copyTimeSlot :: TimeSlot -> TimeSlot
copyTimeSlot (Slot []) = emptyTimeSlot
copyTimeSlot (Slot (room : otherRooms)) = addRoom room (copyTimeSlot (Slot otherRooms))

toListRooms :: TimeSlot -> [Room]
toListRooms (Slot list) = list

-- Given a TimeSlot, room name and a new capacity for the room, 
-- returns a timeslot with the rooms new capacity
changeRoomCapacity :: TimeSlot -> String -> Int -> TimeSlot
changeRoomCapacity (Slot []) _ _ = emptyTimeSlot
changeRoomCapacity (Slot (room : restOfRooms))  roomName newRoomCapacity 
    | roomName == getRoomName room = addRoom (newRoom roomName newRoomCapacity) (changeRoomCapacity (Slot restOfRooms) roomName newRoomCapacity)
    | otherwise = addRoom (copyRoom room) (changeRoomCapacity (Slot restOfRooms) roomName newRoomCapacity)

data TimeSlot = Slot [Room]
    deriving (Show)