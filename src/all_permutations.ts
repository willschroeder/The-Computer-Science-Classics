export {}

// O(1)
function swap(a: Array<number>, i: number, j: number) {
    let temp = a[i]
    a[i] = a[j]
    a[j] = temp 
}

// O(n!)
// 5 * 4 * 3 * 2 * 1 is the amount of permutations to make at each step, because thats how many letters are left to swap 
function allPermutations(left: Array<number>, right: Array<number>, found: Array<Array<number>>) {
    if (right.length == 0) {
        found.push(left)
    }
    else {
        for(let i = 0; i < right.length; i++) {
            swap(right, 0, i)
            let char = right[0]
            let newLeft = left.concat([char])
            let newRight = right.slice(1)
            allPermutations(newLeft, newRight, found)
            swap(right, 0, i)
        }
    }
}

it("allPermutations", () => {
    let found: Array<Array<number>> = []
    allPermutations([], [1,2,3,4], found)
    expect(found.length).toBe(24)
})