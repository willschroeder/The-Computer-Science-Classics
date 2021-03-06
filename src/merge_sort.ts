export {}

// O (n)
function merge(left: Array<number>, right: Array<number>): Array<number> {
    let li = 0
    let ri = 0
    let a = []

    while (li < left.length && ri < right.length) { // n
        let leftValue = left[li]
        let rightValue = right[ri]
        
        if (leftValue < rightValue) {
            a.push(leftValue)
            li += 1
        }
        else {
            a.push(rightValue)
            ri += 1
        }
    } 
    
    while (li < left.length) { // n
        a.push(left[li])
        li += 1
    }

    while (ri < right.length) { // n
        a.push(right[ri])
        ri += 1
    }

    return a
}

// O (n * log n)
function mergeSort(a: Array<number>): Array<number> {
    if (a.length == 1) {
        return a
    }

    let middleIndex = Math.floor(a.length/2)
    let left = mergeSort(a.slice(0,middleIndex)) // log n 
    let right = mergeSort(a.slice(middleIndex)) // log n 
    return merge(left, right) // n 
}

it ("merge", () => {
	expect(merge([1,3,5,7], [2,4,6,8,9,10])).toStrictEqual([1,2,3,4,5,6,7,8,9,10])
})

it ("mergeSort", () => {
	expect(mergeSort([8, 2, 10, 9, 11, 7, 4, 3, 23, 5, 86, 23, 9, 1, 86])).toStrictEqual([1,2,3,4,5,7,8,9,9,10,11,23,23,86,86])
})
