/**
 *  Comp project with the funny graphs.
 * @author Kiril Sikov
 *  Class: Comp 3649
 *  Project: Timeslot calculator
 */
public class Room {
    private String courseName;
    private int roomCapacity;
    private int currentRoomCapacity;

    /**
     * placeholder.
     */
    public Room() {
        this.setCourseName(null);
        this.setRoomCapacity(0);
        this.setCurrentRoomCapacity(0);
    }
    
    public Room(String courseName, int roomCapacity, int currRoomCapacity) {
        this.setCourseName(courseName);
        this.setRoomCapacity(roomCapacity);
        this.setCurrentRoomCapacity(currRoomCapacity);
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public int getRoomCapacity() {
        return roomCapacity;
    }
    public int getCurrentRoomCapacity() {
        return currentRoomCapacity;
    }

    public void setCurrentRoomCapacity(int roomCapacity) {
        this.currentRoomCapacity = roomCapacity;
    }
    public void setRoomCapacity(int roomCapacity) {
        this.roomCapacity = roomCapacity;
    }

    /**
     * parses an input line in the rooms file and then splits it
     * into two parts: first is the room name and the second is its
     * occupancy capacity. Then, the routine puts this information
     * into the object
     * @param input the line grabbed from the file
     */
    public void parseLine (String input) {
        char chr = 0;
        int whitespacePoint = 0;
        int occupantcy = 0;
        String roomName = "";
        

        for (int i = 0; (i < input.length()) && chr != '\t';i++) {
            chr = input.charAt(i);
            whitespacePoint++;
            if (!(chr == '\t')) {
                roomName = roomName + chr;
            }
        }
        
        for (int i = whitespacePoint; i < input.length(); i++) {
            chr = input.charAt(i);           
            occupantcy = (occupantcy * 10) + Character.getNumericValue(chr);
        }
       
        this.setCourseName(roomName);
        this.setRoomCapacity(occupantcy);
        this.setCurrentRoomCapacity(occupantcy);
    }
}