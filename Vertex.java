import java.util.Objects;
import java.util.ArrayList;

public class Vertex {
	
	  private String className;
	  private ArrayList < Vertex > adj;

	    public Vertex(String name) {
	        this.className = name;
	        adj = new ArrayList<> ();
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

