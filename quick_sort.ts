function quicksort(a: Array<number>, left: number, right: number) {
    let index = partition(a, left, right)
    if (left < index - 1) {
        quicksort(a, left, index-1)
    }
    if (index < right) {
        quicksort(a, index, right)
    }
}

function partition(a: Array<number>, left: number, right: number) {
    let pivotValue = a[Math.floor((left + right)/2)]
    while (left <= right) {
        while(a[left] < pivotValue) {
            left += 1
        }

        while (a[right] > pivotValue) {
            right -= 1
        }

        if (left <= right) {
            let temp = a[left]
            a[left] = a[right]
            a[right] = temp 

            left += 1
            right -= 1
        }
    }
    return left 
}

let numberList = [8, 2, 10, 9, 11, 7, 4, 3, 23, 5, 86, 23, 9, 1, 86]
quicksort(numberList, 0, numberList.length-1)
console.log(numberList)