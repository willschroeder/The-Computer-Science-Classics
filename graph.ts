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

function print(val: any) {
    console.log(val)
}

function addVertex(graph: Graph, value: any): Vertex {
    let index = graph.verts.length
    let vert = {value: value, index: index}
    graph.verts.push({value: value, index: index})
    graph.edges[index] = []
    return vert 
}

function addDirectedEdge(graph: Graph, from: Vertex, to: Vertex) {
    graph.edges[from.index].push({to: to, from: from})
}

function breadthFirstSearch(graph: Graph, value: any): boolean {
    let toSearch: Array<Vertex> = [graph.verts[0]]
    let serached = {}

    while (toSearch.length > 0) {
        let vert = toSearch.shift()
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

function findPath(graph: Graph, vert: Vertex, value: any, pathSoFar: Array<number>): Array<number>|null {
    let pathToNode = pathSoFar.concat(vert.index)

    if (vert.value == value) {
        return pathToNode
    }
    
    let edges = graph.edges[vert.index]
    for (let i = 0; i < edges.length; i++) {
        let edge = edges[i]
        let pathUsingEdge = findPath(graph, edge.to, value, pathToNode)
        if (pathUsingEdge) {
            return pathUsingEdge
        }
    }

    return null 
}

// Based on https://www.geeksforgeeks.org/topological-sorting/
function topologicalSort(graph: Graph): Array<Vertex> {
    enum Status {
        Unprocessed,
        Processing,
        Processed
    }

    let visited: Array<Status> = new Array(graph.verts.length).fill(Status.Unprocessed)
    let order: Array<Vertex> = []
    
    for(let i = 0; i < graph.verts.length; i++) {
        if (visited[i] == Status.Processed) {
            continue 
        }

        let toProcess: Array<Vertex> = [graph.verts[i]]
        let processed: Array<Vertex> = []
        while(toProcess.length > 0) {
            let vert = toProcess.shift()
            visited[vert.index] = Status.Processing 
            processed.push(vert)

            graph.edges[vert.index].forEach((edge) => {
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

print(graph)

print(breadthFirstSearch(graph, 5))
print(breadthFirstSearch(graph, 22))

print(findPath(graph, v[0], 5, []))
print(findPath(graph, v[0], 55, []))

print(topologicalSort(graph).map((i) => { return i.value }))


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

print(topologicalSort(dag).map((i) => { return i.value }))
