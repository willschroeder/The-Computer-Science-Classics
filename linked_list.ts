export {}

type LLNode = {
    value: number 
    next?: LLNode
}

// O(n)
function toArr(node: LLNode) {
    let arr: Array<number> = []
    let runner: LLNode|undefined = node
    while (runner) {
        arr.push(runner.value)
        runner = runner.next
    }
    return arr
}

// O(n)
function add(node: LLNode, value: number) {
    while (node) {
        if (!node.next) {
            node.next = {value: value}
            return 
        }
        node = node.next
    }
}

// O(n)
function removeWithOnePointer(start: LLNode, index: number): LLNode|undefined {
    if (index == 0) {
        return start.next
    }

    let i = index 
    let node: LLNode|undefined = start 

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
        else {
            i -= 1
            node = node.next
        }
    }

    return start 
}

// O(n)
function remove(start: LLNode, index: number): LLNode|undefined {
    if (index == 0) {
        return start.next
    }

    if (index == 1) {
        if (start.next) {
            start.next = start.next.next 
        }
        else {
            start.next = undefined
        }
        return start
    }

    let one: LLNode|undefined = start 
    let two: LLNode|undefined = start.next 

    let i = index 
    while (i > 1) {
        one = one?.next 
        two = two?.next

        if (!two) {
            throw `no item at index ${i}`
        }

        i -= 1
    }
    
    one!.next = two!.next 

    return start
}

// O(n)
function xNodesFromEnd(start: LLNode, x: number): number {
    let i = x 
    let lag: LLNode|undefined = start 
    let runner: LLNode|undefined = start 

    while(runner) {
        if (i == 0) {
            lag = lag!.next 
        }
        else {
            i -= 1 
        }

        runner = runner.next
    }

    if (i > 0) {
        throw "list shorter than x"
    }

    return lag!.value 
}

// O(n)
function reverse(node: LLNode): LLNode|undefined {
    let oldHead: LLNode|undefined = node
    if (!oldHead.next) {
        return oldHead 
    }

    let newHead: LLNode|undefined

    while (oldHead) {
        let swap = oldHead
        oldHead = oldHead.next 

        swap.next = newHead
        newHead = swap 
    } 

    return newHead
}




function buildLinkedList(): LLNode {
    let start: LLNode = {value: 0}
    add(start, 1)
    add(start, 2)
    add(start, 3)
    add(start, 4)
    return start 
}
it ("toArr", () => {
	expect(toArr(buildLinkedList())).toStrictEqual([0,1,2,3,4])
})

it ("remove", () => {
    let start = remove(buildLinkedList(), 2)
    expect(toArr(start!)).toStrictEqual([0,1,3,4])
    expect(toArr(start!)).toStrictEqual(toArr(removeWithOnePointer(buildLinkedList(),2)!))
})

it ("xNodesFromEnd", () => {
	expect(xNodesFromEnd(buildLinkedList(), 3)).toBe(2)
})

it ("reverse", () => {
	expect(toArr(reverse(buildLinkedList())!)).toStrictEqual([4,3,2,1,0])
})
