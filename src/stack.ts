type StackNode = {
    value: number
    highest: number
    below?: StackNode
}

type Stack = {
    head?: StackNode
}

function print(val: any) {
    console.log(val)
}

// O(1)
function push(stack: Stack, value: number) {
    if (!stack.head) {
        stack.head = {
            value: value,
            highest: value
        }
    }
    else {
        let node = {
            value: value, 
            below: stack.head,
            highest: (value > stack.head.highest) ? value : stack.head.highest
        }
        stack.head = node 
    }
}

// O(1)
function pop(stack: Stack): number {
    if (!stack.head) {
        throw "stack is empty"
    }

    let val = stack.head.value
    stack.head = stack.head.below
    return val 
}

// O(1)
function highest(stack: Stack): number|undefined {
    return stack.head?.highest
}

// O(1)
function peek(stack: Stack): number|undefined {
    return stack.head?.value
}

it ("stack", () => {
    let stack: Stack = {}
    push(stack, 1)
    push(stack, 7)
    push(stack, 2)

    expect(highest(stack)).toBe(7)
    expect(peek(stack)).toBe(2)
    expect(pop(stack)).toBe(2)

    expect(highest(stack)).toBe(7)
    expect(peek(stack)).toBe(7)
    expect(pop(stack)).toBe(7)

    expect(highest(stack)).toBe(1)
    expect(peek(stack)).toBe(1)
    expect(pop(stack)).toBe(1)
})
