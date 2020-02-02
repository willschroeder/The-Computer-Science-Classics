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

function pop(stack: Stack): number {
    if (!stack.head) {
        throw "stack is empty"
    }

    let val = stack.head.value
    stack.head = stack.head.below
    return val 
}

function highest(stack: Stack): number {
    return stack.head?.highest
}

function peek(stack: Stack): number {
    return stack.head?.value
}

let stack: Stack = {}
push(stack, 1)
push(stack, 7)
push(stack, 3)
push(stack, 2)

print(`Highest: ${highest(stack)} Value: ${peek(stack)}`)
print(pop(stack))
print(`Highest: ${highest(stack)} Value: ${peek(stack)}`)
print(pop(stack))
print(`Highest: ${highest(stack)} Value: ${peek(stack)}`)
print(pop(stack))
print(`Highest: ${highest(stack)} Value: ${peek(stack)}`)
print(pop(stack))