import java.util.Objects;
import java.util.ArrayList;

public class Vertex {
	
	  private String className;
	  private ArrayList < Vertex > adj;
	  private int numberOfStudents;

	    public Vertex(String name, int numStudents) {
	        this.className = name;
	        this.numberOfStudents = numStudents;
	        adj = new ArrayList<> ();
	    }
	    
	    public int getNumStudents() {
	    	return this.numberOfStudents;
	    }
	    

	    public String getName() {
	        return className;
	    }

	    public ArrayList < Vertex > getAdjacentVertices() {
	        return adj;
	    }
	    
	    @Override
		public String toString() {
			
			String cool = className;
			
			return cool;
		}
}

