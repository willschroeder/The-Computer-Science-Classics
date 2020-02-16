export {}

function parentIndex(i: number) {
    return Math.floor((i-1)/2)
}

function leftIndex(i: number) {
    return i * 2 + 1
}

function rightIndex(i: number) {
    return i * 2 + 2 
}

function swap(a: Array<number>, i: number, j: number) {
    let temp = a[i]
    a[i] = a[j]
    a[j] = temp 
}

function push(a: Array<number>, value: number) {
    a.push(value)
    // if value is smaller than its parent, swap places until its not or you are at root 
}

function pop(a: Array<number>): number|undefined {
    const value = a[0]
    
    // move the right most value to the first slot, then swap with the larger child until value is smaller than both children

    return value 
}

it ("index lookup", () => {
    expect(parentIndex(1)).toBe(0)
    expect(parentIndex(2)).toBe(0)
    expect(leftIndex(0)).toBe(1)
    expect(rightIndex(0)).toBe(2)
})

it ("heap", () => {
    let heap: Array<number> = []
    push(heap, 10)
    push(heap, 14)
    push(heap, 33)
    push(heap, 81)
    push(heap, 82)
    push(heap, 99)
    push(heap, 1)

    // expect(pop(heap)).toBe(1)
})