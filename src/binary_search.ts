export {}

// O(log n), keep dividing in half until number found
function binarySearch(a: Array<number>, target: number, left: number, right: number): boolean {
    if (left > right) {
        return false 
    }

    const midIndex = Math.round((left + right) / 2)
    const midValue = a[midIndex]

    if (midValue == target) {
        return true 
    }

    if (target < midValue) {
        return binarySearch(a, target, left, midIndex-1)
    }

    if (target > midValue) {
        return binarySearch(a, target, midIndex+1, right)
    }

    throw `shouldn't end up here, midIndex: ${midIndex} midVal: ${midValue} target: ${target}`
}

it ("binarySearch", () => {
    let numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    expect(binarySearch(numberList, 7, 0, numberList.length-1)).toBeTruthy()
    expect(binarySearch(numberList, 77, 0, numberList.length-1)).toBeFalsy()
})