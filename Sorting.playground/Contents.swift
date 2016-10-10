import Foundation

/*

Sorting

Moving from dissaray to order, these algorithems turn chaos into order
Often numbers, but works for anything that can be sorted

*/

var numberList = [8, 2, 10, 9, 11, 7, 4, 3, 23, 5, 86, 23, 9, 1, 86]

//Bubble Sort
func bubbleSort(numberList: [Int]) -> [Int] {
    guard numberList.count > 1 else { return numberList }

    var a = numberList
    
    while true {
        var swapped = false
        
        //Run though list swapping two values if the one on the left is lower than the one on the right
        for i in 1..<a.count {
            if a[i] < a[i-1] {
                swap(&a[i], &a[i-1])
                swapped = true
            }
        }
        
        //If it completes an entire pass with out a swap, the list is sorted
        if !swapped {
            break
        }
        
    }
    
    return a
}

bubbleSort(numberList: numberList)

//Insertion Sort O(n^2)
//Inserting a number at a time into a sorted section of the array
//This sort traverses though an array, picking each number, 
//and inserting it into the previously sorted numbers behind it in the array

func insertionSort(numberList: [Int]) -> [Int] {
    var a = numberList

    //Key traverses the array from left to right
    for key in 1..<a.count {
        //y copies key, the latest number to sort
        var x = key
        
        //Walk right to left though the array,
        //swapping the position of the two numbers if one is less than the other
        //
        //Because the things behind the current key are in order, you just can swap backwards
        //and it will eventually fall into place
        //
        //This loop will break when it no longer needs to make a swap or hits the end
        //If it its the end, then this was the lowest number
        while x > 0 && a[x] < a[x-1] {
            swap(&a[x], &a[x-1])
            x -= 1
        }
    }
    
    return a
}

insertionSort(numberList: numberList)

//Selection Sort O(n^2)
//Selecting the lowest number from the remaing unsorted
//Moving from left to right, this finds the lowest number to the right of the key, 
//If it finds a lowest number, it swaps it, then moves onto the next

func selectionSort(numberList: [Int]) -> [Int] {
    guard numberList.count > 1 else { return numberList }
    
    var a = numberList
    
    //Key traverses the array from left to right
    for key in 0..<a.count-1 {
        //have the lowest start as the key
        var lowest = key
        
        //for the key+1 to the end of the array,
        //if you find a lower value, thats our new lowest
        for y in (key+1)..<a.count {
            if a[y] < a[lowest] {
                lowest = y
            }
        }
        
        //if we found a lower number swap it out
        if key != lowest {
            swap(&a[key], &a[lowest])
        }
    }
    
    return a
}

selectionSort(numberList: numberList)

//Mergesort O(n log n)
//Devide and conqure by splitting numbers apart and merging them back togeather
//Keep splitting pile of numbers in half until they are by themselves
//Then you merge them back togeather in order, which is easy because you have chunks already in order

func mergeSort(a: [Int]) -> [Int] {
    guard a.count > 1 else { return a }

    //Bust it in half
    let middleIndex = a.count/2
    //Keep busting it recursivly until its 1 element each
    let leftArray = mergeSort(a: Array(a[0..<middleIndex]))
    let rightArray = mergeSort(a: Array(a[middleIndex..<a.count]))
    
    return merge(leftPile: leftArray, rightPile: rightArray)
}

//Keep in mind that both piles will be in order, this just combines them
func merge(leftPile: [Int], rightPile: [Int]) -> [Int] {
    var leftIndex = 0
    var rightIndex = 0
    
    var orderedPile = [Int]()
    
    //while both piles have values
    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        //if left pile's index value is less than right, add it to the ordered set
        if leftPile[leftIndex] < rightPile[rightIndex] {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        }
        //same as above but for right
        else if leftPile[leftIndex] > rightPile[rightIndex] {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
        //the values are equal, so add both
        else {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
    }
    
    //fill in the rest of the left, because the other is empty
    while leftIndex < leftPile.count {
        orderedPile.append(leftPile[leftIndex])
        leftIndex += 1
    }
    
    //same as above, only one of these should trigger
    while rightIndex < rightPile.count {
        orderedPile.append(rightPile[rightIndex])
        rightIndex += 1
    }
    
    return orderedPile
}

mergeSort(a: numberList)

//Quicksort O(n log n) on average, O(n^2) on worst

func quickSort(a: [Int]) -> [Int] {
    guard a.count > 1 else { return a }
    
    let pivot = a[a.count/2]
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }
    
    return quickSort(a: less) + equal + quickSort(a: greater)
}

quickSort(a: numberList)

//Quicksort in place
//Above creates and destroys a lot of memory, so this is the more efficent 

func quickSortInPlace(numbers: inout [Int], indexLow: Int, indexHigh: Int) {
    var i = indexLow
    var j = indexHigh
    let pivot = numbers[(indexLow + indexHigh)/2]
    
    while i <= j {
        while numbers[i] < pivot {
            i += 1
        }
        
        while numbers[j] > pivot {
            j -= 1
        }
        
        if i <= j {
            let swap = numbers[i]
            numbers[i] = numbers[j]
            numbers[j] = swap
            
            i += 1
            j -= 1
        }
    }
    
    if indexLow < j {
        quickSortInPlace(numbers: &numbers, indexLow: indexLow, indexHigh: j)
    }
    if i < indexHigh {
        quickSortInPlace(numbers: &numbers, indexLow: i, indexHigh: indexHigh)
    }
}

quickSortInPlace(numbers: &numberList, indexLow: 0, indexHigh: numberList.count - 1)
