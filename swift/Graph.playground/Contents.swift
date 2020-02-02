import Foundation


/*

 Graph
 
 Q: When to use Adjacency, and when to use Matrix
 
*/


//A vertex is a node in a graph, there is no order
//The index is a unique identifer the class needs to look up the node, 
//its an optimization, otherwise you would need to look up the node by comparing data to find its index every time
struct Vertex {
    let index: Int
    var value: Int
}

//Vertexs are connected by edges, which can have a weight
//Weight represents the difficulty/resistance to get from one vertex to another used to find efficent routes
struct Edge {
    let from: Vertex
    let to: Vertex
    let weight: Double?
}

//This method holds an edge list for every vertex, that edge list has all the possible connections a vertex has
class AdjacencyListGraph {
    
    //Each vertex can have many edges from other nodes
    class EdgeListItem {
        var vertex: Vertex
        var edges: [Edge] = []
        
        init(vertex: Vertex) {
            self.vertex = vertex
        }
        
        func addEdge(_ edge: Edge) {
            edges.append(edge)
        }
    }
    
    var adjacencyList = [EdgeListItem]()
    
    func createVertex(_ value: Int) -> Vertex {
        //Check for existing vertex, the data must be unique
        for list in adjacencyList {
            if list.vertex.value == value {
                return list.vertex
            }
        }
        
        //It was not found, so create a new one
        let vertex = Vertex(index: adjacencyList.count, value: value)
        adjacencyList.append(EdgeListItem(vertex: vertex))
        return vertex
    }
    
    //A one way connection
    func addDirectedEdge(_ from: Vertex, to: Vertex, weight: Double) {
        let edge = Edge(from: from, to: to, weight: weight)
        let edgeList = adjacencyList[from.index]
        
        //Does not check to see if edge to vertex already exists, adds anyway
        edgeList.addEdge(edge)
    }
    
    //You make a two way connection by making two one ways
    func addUndirectedEdge(_ from: Vertex, to: Vertex, weight: Double) {
        self.addDirectedEdge(from, to: to, weight: weight)
        self.addDirectedEdge(to, to: from, weight: weight)
    }
    
    func weightFrom(_ from: Vertex, to: Vertex) -> Double? {
        let edgeList = adjacencyList[from.index].edges
        
        for edge in edgeList {
            if edge.to.value == to.value {
                return edge.weight
            }
        }
        
        return nil
    }
    
    func getConnections(_ from: Vertex) -> [Edge] {
        return adjacencyList[from.index].edges
    }
}

/*
 
 Using a 2D Array, the following structure is made
 
    0 1 2 3
  __________
0 | - X - -
1 | - - - X
2 | - X X -
3 | - - - -
 
 # = A node, represented in both row and column
 X = A connection between nodes, the X would be a double showing the weight in this instance
 - = No connection between the nodes
 
*/

class AdjacencyMatrixGraph {
    var adjacencyMatrix: [[Double?]] = []
    var vertexes: [Vertex] = []
    
    func createVertex(_ value: Int) -> Vertex {
        //Check for existing vertex
        for vertex in vertexes {
            if vertex.value == value {
                return vertex
            }
        }
        
        //Make a new vertex
        let vertex = Vertex(index: value, value: adjacencyMatrix.count)
        vertexes.append(vertex)
        
        //Add a new column
        let newColumn = [Double?](repeating: nil, count: adjacencyMatrix.count)
        adjacencyMatrix.append(newColumn)
        
        //Add a row to each column
        for i in 0 ..< adjacencyMatrix.count {
            adjacencyMatrix[i].append(nil)
        }
        
        return vertex
    }
    
    func addDirectedEdge(_ from: Vertex, to: Vertex, weight: Double) {
        adjacencyMatrix[from.index-1][to.index-1] = weight
    }
    
    func addUndirectedEdge(_ from: Vertex, to: Vertex, weight: Double) {
        self.addDirectedEdge(from, to: to, weight: weight)
        self.addDirectedEdge(to, to: from, weight: weight)
    }
    
    func weightFrom(_ from: Vertex, to: Vertex) -> Double? {
        return adjacencyMatrix[from.index-1][to.index-1]
    }
    
    func getConnections(_ from: Vertex) -> [Double] {
        return adjacencyMatrix[from.index-1].flatMap { $0 }
    }
    
}

let adjacencyListGraph = AdjacencyListGraph()
let adjacencyMatrixGraph = AdjacencyMatrixGraph()

let graph = adjacencyMatrixGraph

let v1 = graph.createVertex(1)
let v2 = graph.createVertex(2)
let v3 = graph.createVertex(3)
let v4 = graph.createVertex(4)
let v5 = graph.createVertex(5)

graph.addUndirectedEdge(v1, to: v2, weight: 1.0)
graph.addUndirectedEdge(v2, to: v3, weight: 1.0)
graph.addUndirectedEdge(v3, to: v4, weight: 4.5)
graph.addDirectedEdge(v4, to: v1, weight: 2.8)
graph.addDirectedEdge(v2, to: v5, weight: 3.2)

graph.weightFrom(v1, to: v2)
graph.weightFrom(v4, to: v3)
graph.weightFrom(v1, to: v5)
graph.weightFrom(v2, to: v5)
graph.weightFrom(v5, to: v2)

/*

 Breadth First Search

 Starting with a node, queue up connecting to see if they are the target node.
 If not target node, get their connections, and add the current node to a list of previously searched nodes.
 If target node, return the searched nodes. This isn't a direct path back, only that a connection exists and how many nodes it had to check to get there.
 
 If you wanted to hold onto a path back, each node would need to remember which node it was found though. 
 This means you will have a node multiple times on the searched queue, and should only be skipped if the index and the from index are the same. 
 Then once you reached the target, you could walk it back. 
 
*/

extension AdjacencyListGraph {
    func breadthFirstSearch(start: Vertex, target: Vertex) -> [Int] {
        var queue = [Vertex]()
        queue.append(start)
        
        var exploredIndexes = [Int]()
        
        while true {
            let current = queue.removeFirst()
            exploredIndexes.append(current.index)
            
            if current.index == target.index {
                return exploredIndexes
            }
            
            let connections = getConnections(current)
            for connection in connections {
                let index = connection.to.index
                if !exploredIndexes.contains(index) {
                    queue.append(connection.to)
                }
            }
            
            if queue.count == 0 {
                return []
            }
        }
    }
}

let dfsGraph = AdjacencyListGraph()

let nodeA = dfsGraph.createVertex(1)
let nodeB = dfsGraph.createVertex(2)
let nodeC = dfsGraph.createVertex(3)
let nodeD = dfsGraph.createVertex(4)
let nodeE = dfsGraph.createVertex(5)
let nodeF = dfsGraph.createVertex(6)
let nodeG = dfsGraph.createVertex(7)
let nodeH = dfsGraph.createVertex(8)

// The weight is not used in the shortest path calculation
dfsGraph.addUndirectedEdge(nodeA, to: nodeB, weight: 1.0)
dfsGraph.addUndirectedEdge(nodeA, to: nodeC, weight: 1.0)
dfsGraph.addUndirectedEdge(nodeB, to: nodeD, weight: 1.0)
dfsGraph.addUndirectedEdge(nodeB, to: nodeE, weight: 1.0)
dfsGraph.addDirectedEdge(nodeC, to: nodeF, weight: 1.0)
dfsGraph.addDirectedEdge(nodeC, to: nodeG, weight: 1.0)
dfsGraph.addDirectedEdge(nodeE, to: nodeH, weight: 1.0)
dfsGraph.addDirectedEdge(nodeE, to: nodeF, weight: 1.0)
dfsGraph.addDirectedEdge(nodeF, to: nodeG, weight: 1.0)

dfsGraph.breadthFirstSearch(start: nodeA, target: nodeG)

dfsGraph.addDirectedEdge(nodeA, to: nodeG, weight: 1.0)

dfsGraph.breadthFirstSearch(start: nodeA, target: nodeG)


