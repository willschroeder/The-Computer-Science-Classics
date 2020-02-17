export {}

type QueueNode = {
    value: number
    next?: QueueNode
}

/*

removeFrom          addTo
|                   |
1 -> 2 -> 3 -> 4 -> 5

*/

type Queue = {
    addTo?: QueueNode
    removeFrom?: QueueNode
}

// O(1)
function push(queue: Queue, value: number) {
    if (!queue.addTo) {
        queue.addTo = {value: value}
        queue.removeFrom = queue.addTo
    }
    else {
        queue.addTo.next = {
            value: value
        }
        queue.addTo = queue.addTo.next
    }
}

// O(1)
function pop(queue: Queue): number {
    if (!queue.removeFrom) {
        throw "empty queue"
    }
    
    let val = queue.removeFrom.value
    queue.removeFrom = queue.removeFrom.next
    
    if (!queue.removeFrom) {
        queue.addTo = undefined
    }

    return val
}

// O(n)
function toArr(queue: Queue) {
    let arr = []
    let node = queue.removeFrom

    while(node) {
        arr.push(node.value)
        node = node.next
    }

    return arr 
}

it ("queue", () => {
    let queue: Queue = {}
    push(queue, 1)
    push(queue, 2)
    push(queue, 3)

    expect(toArr(queue)).toStrictEqual([1,2,3])
    expect(pop(queue)).toBe(1)
    expect(pop(queue)).toBe(2)
    expect(pop(queue)).toBe(3)

    push(queue, 1)
    expect(toArr(queue)).toStrictEqual([1])
})


