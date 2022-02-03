public class Vertex {
	private String className;
	//todo: add int number of students

	public Vertex(String label) {
		this.className = label;
	}
	
	public void setVertex(String newName) {
		this.className = newName;
	}
	
	public String getVertex() {
		return this.className;
	}
	
	//Overrides hashcode()
	@Override
	public int hashCode() {
		return className.hashCode();
	}
	
	//Overrides equals
	@Override 
	public boolean equals(Object o){
		if (this == o) return true;
		if (!(o instanceof Vertex)) {
			return false;
		}
		 Vertex vert = (Vertex) o;
	        return className == vert.className;               
	}
}
