import java.util.ArrayList;

/**
 * class that defines the graph used in the program.
 * @author Comp Sci Group
 *
 */
public class Graph {

    private ArrayList<Vertex> graph;

    /**
     * Initializes a graph object.
     */
    public Graph() {
        graph = new ArrayList<> ();
    }

    /**
     * Adds an edge to the graph.
     * @param v1 input 1.
     * @param v2 input 2.
     */
    public void addEdge(String v1, String v2) {
        int size = graph.size();

        for  (int i = 0; i < size; i++) {
            if (graph.get(i).getName() == v1) {
                for  (int j = 0; j < size; j++) {
                    if (graph.get(j).getName() == v2) {
                        graph.get(i).getAdjacentVertices().add(graph.get(j));
                        graph.get(j).getAdjacentVertices().add(graph.get(i));
                    }
                }
            }
        }
        return;
    }

    /**
     * Adds a vertex to the graph.
     * @param vert vertex to be added.
     */
    public void addVertex(Vertex vert) {
        graph.add(vert);
        return;
    }

    public ArrayList<Vertex> getGraph() {
        return this.graph;
    }

    /**
     * Prints the graph.
     */
    public void printGraph() {
        for (int i = 0; i < this.getGraph().size(); i++) {
            System.out.println(this.getGraph().get(i) + " : " + this.getGraph().get(i)
                               .getAdjacentVertices().toString());
        }
    }
}