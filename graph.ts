export {}

type Vertex = {
    value : any 
    index: number 
}

type Edge = {
    to: Vertex
    from: Vertex
}

type Graph = {
    verts: Array<Vertex>
    edges: Array<Array<Edge>>
}

// O(1)
function addVertex(graph: Graph, value: any): Vertex {
    let index = graph.verts.length
    let vert = {value: value, index: index}
    graph.verts.push({value: value, index: index})
    graph.edges[index] = []
    return vert 
}

// O(1)
function addDirectedEdge(graph: Graph, from: Vertex, to: Vertex) {
    graph.edges[from.index].push({to: to, from: from})
}

// O(n)
function breadthFirstSearch(graph: Graph, value: any): boolean {
    let toSearch: Array<Vertex> = [graph.verts[0]]
    let serached: Array<boolean> = [] // standing in for a queue, which is more efficent 

    while (toSearch.length > 0) {
        let vert = toSearch.shift()!
        if (vert.value == value) {
            return true 
        }

        serached[vert.index] = true 

        graph.edges[vert.index].forEach((edge) => {
            if(!serached[edge.to.index]) {
                toSearch.push(edge.to)
            }
        })
    }

    return false 
}

// This is an example of backtracking, assuming there are no circular references
// O(vertex + edges)
function findPath(graph: Graph, vert: Vertex, value: number|string, pathSoFar: Array<number>): Array<number>|undefined {
    let pathToNode = pathSoFar.concat(vert.index) // O(vertex) each visited once, assuming no loops, or marked at visited 

    if (vert.value == value) {
        return pathToNode
    }
    
    let edges = graph.edges[vert.index]
    for (let i = 0; i < edges.length; i++) { // O(edges)
        let edge = edges[i]
        let pathUsingEdge = findPath(graph, edge.to, value, pathToNode) 
        if (pathUsingEdge) {
            return pathUsingEdge
        }
    }

}

// Based on https://www.geeksforgeeks.org/topological-sorting/
// O(n), O(vertex + edges)
// This could be made simpler if not checking for cycles, but would get caught in loop if there was 
function topologicalSort(graph: Graph): Array<Vertex> {
    enum Status {
        Unprocessed,
        Processing,
        Processed
    }

    let visited: Array<Status> = new Array(graph.verts.length).fill(Status.Unprocessed)
    let order: Array<Vertex> = []
    
    for(let i = 0; i < graph.verts.length; i++) { // O(verts)
        if (visited[i] == Status.Processed) {
            continue 
        }

        let toProcess: Array<Vertex> = [graph.verts[i]] // continuing verts usage
        let processed: Array<Vertex> = []
        while(toProcess.length > 0) {
            let vert = toProcess.shift()!
            visited[vert.index] = Status.Processing 
            processed.push(vert)

            graph.edges[vert.index].forEach((edge) => { // O(edges), each edge will only be accessed once, so this isnt going to square the O
                let vertToVisit = edge.to 
                switch(visited[vertToVisit.index]) {
                    case Status.Unprocessed:
                        toProcess.push(vertToVisit)
                        break 
                    case Status.Processing:
                        throw `cycle detected ${edge.from.index} -> ${edge.to.index}, edge lookup`
                    case Status.Processed:
                        break 
                }
            })
        }

        order = order.concat(processed)

        processed.forEach((vert) => {
            visited[vert.index] = Status.Processed
        })
    }

    return order 
}

/*
0 -> 1 -> 2 -> 3 -> 6 -> 7 
          |         |
          4         8
          |
          5
*/

const graph: Graph = {verts: [], edges: []}

let numberList = [0, 1, 2, 3, 4, 5, 6, 7, 8]
let v = numberList.map((i) => {
    return addVertex(graph, i)
})

addDirectedEdge(graph, v[0], v[1])
addDirectedEdge(graph, v[1], v[2])
addDirectedEdge(graph, v[2], v[3])
addDirectedEdge(graph, v[3], v[6])
addDirectedEdge(graph, v[6], v[7])

addDirectedEdge(graph, v[2], v[4])
addDirectedEdge(graph, v[4], v[5])

addDirectedEdge(graph, v[6], v[8])

it ("breadthFirstSearch", () => {
    expect(breadthFirstSearch(graph, 5)).toBeTruthy()
    expect(breadthFirstSearch(graph, 22)).toBeFalsy()
})

it ("findPath", () => {
    expect(findPath(graph, v[0], 5, [])).toStrictEqual([0, 1, 2, 4, 5])
    expect(findPath(graph, v[0], 55, [])).not.toBeDefined()
})

it ("topologicalSort", () => {
	expect(topologicalSort(graph).map((i) => { return i.value })).toStrictEqual([0,1,2,3,4,6,5,7,8])
})

const dag: Graph = {verts: [], edges: []}

//                 0   1   2   3   4   5
let letterList = ['a','b','c','d','e','f']
let v2 = letterList.map((i) => {
    return addVertex(dag, i)
})

addDirectedEdge(dag, v2[0], v2[3])
addDirectedEdge(dag, v2[5], v2[1])
addDirectedEdge(dag, v2[1], v2[3])
addDirectedEdge(dag, v2[5], v2[0])
addDirectedEdge(dag, v2[3], v2[2])
// addDirectedEdge(dag, v2[2], v2[3]) // Uncomment to cause edge exception

it ("topologicalSort 2", () => {
	expect(topologicalSort(dag).map((i) => { return i.value })).toStrictEqual(['a','d','c','b','e','f'])
})

