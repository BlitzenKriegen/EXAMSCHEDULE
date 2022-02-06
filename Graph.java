import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public class Graph {
	
	private ArrayList<Vertex> g;

    public Graph() {
        g = new ArrayList<> ();
    }

    public void addEdge(String v1, String v2) {
    	int size = g.size();
    	
    	for (int i = 0; i<size; i++) {
    		if(g.get(i).getName() == v1) {
    			for (int j = 0; j<size; j++) {
    				if(g.get(j).getName() == v2) {
    					g.get(i).getAdjacentVertices().add(g.get(j));
    					g.get(j).getAdjacentVertices().add(g.get(i));
    				
    				}
    			}
    		}
    	}
    	return;
    }
    
    public void addVertex(Vertex v) {
        g.add(v);
        return;
    }
    
    public ArrayList<Vertex> getGraph() {
        return this.g;
    }

}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
