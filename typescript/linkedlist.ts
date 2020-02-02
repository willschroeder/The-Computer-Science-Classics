class LLNode {
    value: number 
    next?: LLNode
}

function print(val: any) {
    console.log(val)
}

function toArr(node: LLNode) {
    let arr = []
    while (node) {
        arr.push(node.value)
        node = node.next
    }
    return arr
}

function add(node: LLNode, value: number) {
    while (node) {
        if (!node.next) {
            node.next = {value: value}
            return 
        }
        node = node.next
    }
}

function removeWithOnePointer(start: LLNode, index: number): LLNode|null {
    if (index == 0) {
        return start.next
    }

    let i = index 
    let node = start 

    while (true) {
        if (!node) {
            throw "Linked list too short"
        }

        if (i == 0) {
            if (!node.next) {
                throw "Can't remove from last node in list"
            }

            node.value = node.next.value
            node.next = node.next.next
            break 
        }

        i -= 1
        node = node.next
    }

    return start 
}

function remove(start: LLNode, index: number): LLNode|null {
    if (index == 0) {
        return start.next
    }

    if (index == 1) {
        if (start.next) {
            start.next = start.next.next 
        }
        else {
            start.next = null
        }
        return start
    }

    let one = start 
    let two = start.next 

    let i = index 
    while (i > 0) {
        one = one.next 
        two = two.next

        if (!two) {
            throw `no item at index ${i}`
        }

        i -= 1
    }
    
    one.next = two.next 

    return start
}

function xNodesFromEnd(start: LLNode, x: number): number {
    let i = x 
    let lag = start 
    let runner = start 

    while(runner) {
        if (i == 0) {
            lag = lag.next 
        }
        else {
            i -= 1 
        }

        runner = runner.next
    }

    if (i > 0) {
        throw "list shorter than x"
    }

    return lag.value 
}

function reverse(oldHead: LLNode): LLNode {
    if (!oldHead.next) {
        return oldHead 
    }

    let newHead: LLNode

    while (oldHead) {
        let swap = oldHead
        oldHead = oldHead.next 

        swap.next = newHead
        newHead = swap 
    } 

    return newHead
}


let start: LLNode = {value: 1}
add(start, 2)
add(start, 3)
add(start, 4)
add(start, 5)

start = remove(start, 2)
print(toArr((start)))

print(xNodesFromEnd(start, 3))

print(toArr(reverse(start)))