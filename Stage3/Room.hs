module Room
(
Room,
newRoom,
changeCapacity,
getRoomName,
getRoomCapacity,
copyRoom, 

)
where

newRoom :: String -> Int -> Room
newRoom roomName capacity = RoomData (roomName, capacity)

copyRoom :: Room -> Room
copyRoom (RoomData (name,capacity)) = newRoom name capacity

changeCapacity :: Room -> Int -> Room
changeCapacity (RoomData (name,capacity)) newCapacity = newRoom name newCapacity

getRoomName :: Room -> String
getRoomName (RoomData (name,_)) = name

getRoomCapacity :: Room -> Int
getRoomCapacity (RoomData (_, capacity)) = capacity

data Room = RoomData (String,Int)
    deriving (Show)
