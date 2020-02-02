type Vertex = {
    value : number 
    index: number 
}

type Edge = {
    to: Vertex
    from: Vertex
    weight: number
}

type Graph = {
    verts: Array<Vertex>
    edges: Array<Array<Edge>>
}

function print(val: any) {
    console.log(val)
}

function addVertex(graph: Graph, value: number): Vertex {
    let index = graph.verts.length
    let vert = {value: value, index: index}
    graph.verts.push({value: value, index: index})
    graph.edges[index] = []
    return vert 
}

function addDirectedEdge(graph: Graph, from: Vertex, to: Vertex, weight = 5) {
    graph.edges[from.index].push({to: to, from: from, weight: weight})
}

function breadthFirstSearch(graph: Graph, value: number): boolean {
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

function findPath() {

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


