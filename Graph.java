import java.util.ArrayList;
import java.util.HashMap;

public class Graph {
     private HashMap<Vertex , ArrayList<Vertex> > classGraph = null;
     
     public Graph() {
    	 classGraph = new HashMap<>();
     }
     
     public void addVertex(String className) {
    	 classGraph.putIfAbsent(new Vertex(className), new ArrayList<>());
     }
     
     public HashMap<Vertex, ArrayList<Vertex>> getGraph() {
    	 return this.classGraph;
     }
	
     public void addEdge(String class1, String class2){
    	 Vertex v1 = new Vertex(class1);
    	 Vertex v2 = new Vertex(class2);
    	 classGraph.get(v1).add(v2);
    	 classGraph.get(v2).add(v1);
     }

     //missing: delete edge and vertex
     //don't think we need it
     
}
