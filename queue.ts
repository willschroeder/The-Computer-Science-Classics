type QueueNode = {
    value: number
    next?: QueueNode
}

type Queue = {
    addTo?: QueueNode
    removeFrom?: QueueNode
}

function print(val: any) {
    console.log(val)
}

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

function pop(queue: Queue): number {
    if (!queue.removeFrom) {
        throw "empty queue"
    }
    
    let val = queue.removeFrom.value
    queue.removeFrom = queue.removeFrom.next
    
    if (!queue.removeFrom) {
        queue.addTo = null
    }

    return val
}

function toArr(queue: Queue) {
    let arr = []
    let node = queue.removeFrom

    while(node) {
        arr.push(node.value)
        node = node.next
    }

    return arr 
}

let queue: Queue = {}
push(queue, 1)
push(queue, 2)
push(queue, 3)
print(toArr(queue))
print(pop(queue))
print(pop(queue))
print(pop(queue))
push(queue, 1)
print(pop(queue))
