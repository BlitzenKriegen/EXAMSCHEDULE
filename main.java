import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.io.IOException;
import java.util.Scanner;

/**
 *  Comp project with the funny graphs.
 * @author add names here
 *  Class: Comp 3649
 *  Project: Timeslot calculator
 */

public class main {
    static String classFile = "courses8.txt";
    static String roomFile = "rooms3.txt";
    /**
     * testing.
     * @param args placeholder.
     */
    public static void main(String[] args){
    	int timeSlots;
    	
        ClassInfo allClasses[] = new ClassInfo[0];
        Room roomInfo[] = new Room[0];
        
        Scanner in = new Scanner(System.in); 
        System.out.println("Enter amount of time slots:");
        timeSlots = in.nextInt();
        
        allClasses = classFileRead(allClasses);
        roomInfo = roomFileRead(roomInfo);
        
        Graph test = new Graph();
        fillGraph(test, allClasses);
        
        //array corresponding to time slots, index of array = index of corresponding vertex in Graph, 
        //contents of array specify the timeSlot from 1 - number of time slots input by the user
        int[] timeColor = new int[test.getGraph().size()];
        /*An array of availableRoom objects
         *	- the array index corresponds to the time slot - 1 (if the array index is 0, 
         *	  the corresponding time slot is 1)
         * 	- used to keep track of the room capacity in each time slot
         */
        availableRoom[] examRooms = new availableRoom[timeSlots];    
        /*String of arrays which contain the corresponding exam room
         * for each class
         */
        String[] classExamRooms = new String[test.getGraph().size()];
        
        fillExamRooms(examRooms, roomInfo, timeSlots);
        
        if (graphColoring(timeSlots, timeColor, examRooms,classExamRooms, test, 0)) {
    	   for(int i = 1; i <= timeSlots; i++) {
    		   System.out.println("Timeslot " + i);
    		   for(int j = 0; j < timeColor.length; j ++) {
    			   if(timeColor[j] == i) {
    				   System.out.println(test.getGraph().get(j).getName() + " " + classExamRooms[j]);
    			   }
    		   }
    		   System.out.println();
    	   }
       }
       else {
    	   System.out.println("Could not make schedule");
       }
      
        return;
    }
    
    /**
     * fills availableRoom Objects array with information from
     * the room array
     * @param avRoom
     * @param roomInfo
     * @param timeSlots
     */
    
    static void fillExamRooms(availableRoom[] avRoom, Room[] roomInfo, int timeSlots) {
    	for(int i = 0; i< timeSlots; i++) {
    		avRoom[i] = new availableRoom();
           	for(int j = 0; j < roomInfo.length; j++) {
           		avRoom[i].addRoom(roomInfo[j].getCourseName(),
           				roomInfo[j].getRoomCapacity(),roomInfo[j].getRoomCapacity());
           		}
    	    }
    }
    
    /**
     * Colors the graph and fills given timeSlotArr and classExamRoom arrays
     * @param numOfTimeSlots
     * @param timeSlotArr: filled with working time lots for each class
     * @param examRooms
     * @param classExamRoom: filled with working exam room for each class
     * @param g
     * @param startingVertex
     * @return
     */
    static boolean graphColoring(int numOfTimeSlots,int[] timeSlotArr, availableRoom[] examRooms, String[] classExamRoom, Graph g, int startingVertex) {
    	int size = g.getGraph().size();
    	boolean success = false;
    	
    	if(startingVertex == size) {
    		success = true;
    	}
    	else {
    		for(int c = 1; c <= numOfTimeSlots && !success; c++) {
    			if(isSafe(timeSlotArr,examRooms, classExamRoom, g,startingVertex,c)) {
    				timeSlotArr[startingVertex] = c;	
    				success = graphColoring(numOfTimeSlots, timeSlotArr,examRooms,classExamRoom, g, startingVertex+1);
    				
    			}
    		}
    	}
    	return success;
    }
    
    /**
     * Checks if a vertex is safe to be colored
     * Two conditions: 
     * 1)if adjacent nodes of vertex have different timeSlots
     * from timeSlot trying to be entered
     * 2)if there is a room in that time slot to accommodate
     * the class
     * @param timeSlotArr
     * @param examRooms
     * @param classExamRoom
     * @param g: graph
     * @param k: vertex index
     * @param timeSlot
     * @return boolean
     */
    static boolean isSafe(int[] timeSlotArr, availableRoom[] examRooms,String[] classExamRoom, Graph g, int k, int timeSlot) {
    	int size = g.getGraph().get(k).getAdjacentVertices().size();
    	   	
    	for(int i = 0; i < size; i++) {
    		if(timeSlot == timeSlotArr[g.getGraph().indexOf(g.getGraph().get(k).getAdjacentVertices().get(i))]) {     //checks if all adjacent nodes of k are different color from c
    			return false;
    		}
    	}
    	for(int j = 0; j < examRooms.length; j++) {																	  //checks if there are any available rooms in that time slot. If there is,
    		for(int l = 0; l < examRooms[0].getRooms().size(); l++) {												  //update the current capacity of that room
    			if(g.getGraph().get(k).getNumStudents() <= examRooms[timeSlot-1].getRooms().get(l).getCurrentRoomCapacity()) {
    				examRooms[timeSlot-1].getRooms().get(l)
    				.setCurrentRoomCapacity(examRooms[timeSlot-1].getRooms().get(l).getCurrentRoomCapacity() - 
    				g.getGraph().get(k).getNumStudents()) ;
    				
    				classExamRoom[k] = examRooms[timeSlot-1].getRooms().get(l).getCourseName();
    			
    				return true;
    				}	
    			}
    		}
    	
    	return false;
    }
    /**
     * Fills the graph given an array of ClassInfo objects
     * @param g: graph to be filled
     * @param allClasses
     */
    private static void fillGraph(Graph g, ClassInfo[] allClasses) {
    	int size = allClasses.length;
    	
    	for(int i = 0; i < size; i++) {
    		g.addVertex(new Vertex(allClasses[i].getClassName(), allClasses[i].getNumberOfStudents()));
    		
    	}
    	
    	for(int j = 0; j<size; j++) {
    		for(int k = j+1; k<size; k++) {
    			if(!(isUnionEmpty(allClasses[j].getStudents(), allClasses[k].getStudents()))){
    				g.addEdge(allClasses[j].getClassName(), allClasses[k].getClassName());
    			}	
    		}
    	}
    }
    
    /**
     * isUnionEmpty returns a true if the union set of the two arrays are empty
     * @param arr1
     * @param arr2
     * @return boolean
     */
    private static boolean isUnionEmpty(int[] arr1, int[] arr2) {
    	int size1 = arr1.length;
    	int size2 = arr2.length;
    	boolean ans = true;
    	
    	for(int i = 0; i < size1 && ans == true; i++) {
    		for(int j = 0; j < size2 && ans == true; j++) {
    			if(arr1[i] == arr2[j]) {
    				ans = false;
    			}
    			
    		}
    	}
    	return ans;
    }

    private static Room[] roomFileRead(Room[] roomInfo) {
        try {
            FileInputStream roomRead = new FileInputStream(roomFile);
            Scanner fileRead = new Scanner(roomRead);
            int fillLevel = 0;
            String input = null;
            while (fileRead.hasNext()) {
                input = fileRead.nextLine();
                roomInfo = expandList(roomInfo);
                roomInfo[fillLevel] = new Room();
                roomInfo[fillLevel].parseLine(input);
                fillLevel++;
            }
            fileRead.close();
            roomRead.close();
        } catch (IOException noFile) {
            System.out.print("No File found");
            noFile.printStackTrace();
        }

        return roomInfo;

    }

    private static Room[] expandList(Room[] old) {
        Room[] newList = new Room[old.length + 1];
        if (!(old.length == 0)) {
            newList = new Room[old.length + 1];
            for (int i = 0; i < old.length; i++) {
                newList[i] = old[i];
            }
        }
        return newList;
    }

    /**
     * classFileRead inputs the contents of "class.txt" into the object
     * ClassInfo, to contain the class name and the students in the class.
     * @param allClasses Array containing every "class" and its students
     * @return the parsed file
     */
    public static ClassInfo[] classFileRead(ClassInfo[] allClasses) {
        try {
            FileInputStream classRead = new FileInputStream(classFile);
            Scanner fileRead = new Scanner(classRead);
            int fillLevel = 0;
            String input = null;
            while (fileRead.hasNext()) {
                input = fileRead.nextLine();
                allClasses = expandList(allClasses);
                allClasses[fillLevel] = new ClassInfo();
                allClasses[fillLevel].setClassName(input);
                addtoStntList(fileRead,allClasses, input,fillLevel);
                fillLevel++;
            }
            fileRead.close();
            classRead.close();
        } catch (IOException noFile) {
            System.out.print("No File found");
            noFile.printStackTrace();
        }
        return allClasses;
    }

    /**
     *addToStntList takes an input file and writes the student numbers of a "class"
     *to the ClassInfo student array. The function assumes that the classes are separated
     *by an empty line pending error checking.
     * @param fileRead File that was input into the system
     * @param allClasses Class object containing the int array being filled.
     * @param input used to grab a line from the file.
     * @param fillLevel contains the number which dictates which "class" element to fill.
     */
    public static void addtoStntList(Scanner fileRead, ClassInfo[] allClasses, String input, int fillLevel) {
        while (fileRead.hasNextLine() && !input.equals("")) {
            input = fileRead.nextLine();
            if (input != "") {
                input = skipWhitespace(input);
                int studentID = Integer.parseInt(input);
                allClasses[fillLevel].setStudent(studentID);
            }
        }
        return;
    }

    /**
     * skipWhitespace clears an input string of spaces and tabs,
     * mostly to be used to then convert into an integer.
     * @param input The string to be cleansed of whitespace
     */
    public static String skipWhitespace(String input) {
        input = input.replace("\t", "");
        input = input.replace(" ", "");
        return input;
    }

    /**
     * Deep copy subroutine.
     * @param old old list
     * @return new list with an additional space
     */
    public static ClassInfo[] expandList(ClassInfo[] old) {
        ClassInfo[] newList = new ClassInfo[old.length + 1];
        if (!(old.length == 0)) {
            newList = new ClassInfo[old.length + 1];
            for (int i = 0; i < old.length; i++) {
                newList[i] = old[i];
            }
        }

        return newList;
    }
    
}
