import java.util.Objects;

/*
 *  Comp project with the funny graphs.
 * @author Kiril Sikov
 *  Class: Comp 3649
 *  Project: Timeslot calculator
 */
public class ClassInfo {
    private String className = null;
    private int[] students = null;

    /*
     * lol.
     */
    public ClassInfo() {
        this.setClassName(null);
        this.setStudents(null);
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public int[] getStudents() {
        return students;
    }
    
    public int getNumberOfStudents() {
    	if(this.students != null) {
    		return students.length;
    	}
    	else {
    		return 0;
    	}
    }

    public void setStudents(int[] students) {
        this.students = students;
    }

    public void setStudent(int newStudent) {
        if (this.getStudents() != null) {
            int size = this.getStudents().length + 1;
            int newList[] = new int[size];
            for (int i = 0; i < this.students.length;i++) {
                newList[i] = this.students[i];
            }
            newList[size - 1] = newStudent;
            this.setStudents(newList);
        }
        else {
            this.students = new int [1];
            this.students[0] = newStudent;
        }
        return;
    }
   
}