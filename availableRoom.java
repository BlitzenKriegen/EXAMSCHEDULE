import java.util.ArrayList;

public class availableRoom {
	
	private ArrayList<Room> rooms;
	
	public availableRoom() {
		rooms = new ArrayList<> ();
	}
	
	public ArrayList<Room> getRooms() {
		
		return rooms;
	}
	
	public void addRoom(String courseName, int capacity, int currCapacity) {
		rooms.add(new Room(courseName, capacity, currCapacity));
	}
	
	

}
