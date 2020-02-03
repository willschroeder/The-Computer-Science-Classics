function binarySearch(a: Array<number>, target: number, min: number, max: number): boolean {
    if (min > max) {
        return false 
    }

    const midIndex = Math.round((min + max) / 2)
    const midValue = a[midIndex]

    if (midValue == target) {
        return true 
    }

    if (target < midValue) {
        return binarySearch(a, target, min, midIndex-1)
    }

    if (target > midValue) {
        return binarySearch(a, target, midIndex+1, max)
    }

    throw `shouldn't end up here, midIndex: ${midIndex} midVal: ${midValue} target: ${target}`
}

function print(val: any) {
    console.log(val)
}

let numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print(binarySearch(numberList, 7, 0, numberList.length-1))
print(binarySearch(numberList, 77, 0, numberList.length-1))