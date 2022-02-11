import java.io.FileInputStream;
import java.io.IOException;
import java.util.Scanner;

/**
 *  Comp project with the funny graphs.
 * @author add names here
 *  Class: Comp 3649
 *  Project: Timeslot calculator
 */

public class main {
    static String classFile = "class.txt";
    static String roomFile = "room.txt";

    /**
     * testing.
     * @param args placeholder.
     */
    public static void main(String[] args) {
        int timeSlots;

        ClassInfo allClasses[] = new ClassInfo[0];

        Scanner in = new Scanner(System.in);
        System.out.println("Enter amount of time slots:");
        timeSlots = in.nextInt();

        Graph test = new Graph();
        Room roomInfo[] = new Room[0];
        allClasses = classFileRead(allClasses);
        roomInfo = roomFileRead(roomInfo);

        fillGraph(test, allClasses);

        int[] timeColor = new int[test.getGraph().size()]; /*int array corresponding to timeslots, index of array =
                                                            index of correspongind vertex in Graph*/
        in.close();
        graphColoring(timeSlots, timeColor, test, 0);

        System.out.println(allClasses.length);

        return;
    }

    static void graphColoring(int numOfTimeSlots, int[] color, Graph graph, int startingVertex) {
        int size = graph.getGraph().size();
        System.out.println(size);
        for (int c = 1; c <= numOfTimeSlots; c++) {
            if (isSafe(color,graph,startingVertex,c)) {
                color[startingVertex] = c;
                if (startingVertex + 1 < size) {
                    graphColoring(numOfTimeSlots, color, graph, startingVertex + 1);
                    //else {
                    //System.out.println(Arrays.toString(color));
                    //return;
                    //}
                }
            }
        }
        return;
    }

    static boolean isSafe(int[] color, Graph graph, int startingVertex, int timeSlot) {
        int size = graph.getGraph().get(startingVertex).getAdjacentVertices().size();

        for (int i = 0; i < size; i++) {
            if (timeSlot == color[graph.getGraph().indexOf(graph.getGraph()
                .get(startingVertex).getAdjacentVertices().get(i))]) {
                return false;
            }
        }
        return true;
    }

    private static void fillGraph(Graph graph, ClassInfo[] allClasses) {
        int size = allClasses.length;

        for (int i = 0; i < size; i++) {
            graph.addVertex(new Vertex(allClasses[i].getClassName()));
        }

        for (int j = 0; j < size; j++) {
            for (int k = j + 1 ; k < size; k++) {
                if (!(isUnionEmpty(allClasses[j].getStudents(), allClasses[k].getStudents()))) {
                    graph.addEdge(allClasses[j].getClassName(), allClasses[k].getClassName());
                }
            }
        }
    }

    /**
     * isUnionEmpty returns a true if the union set of the two arrays are empty.
     * @param arr1 First array
     * @param arr2 Second array
     * @return boolean
     */
    private static boolean isUnionEmpty(int[] arr1, int[] arr2) {
        int size1 = arr1.length;
        int size2 = arr2.length;
        boolean ans = true;

        for (int i = 0; i < size1 && ans == true; i++) {
            for (int j = 0; j < size2 && ans == true; j++) {
                if (arr1[i] == arr2[j]) {
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
