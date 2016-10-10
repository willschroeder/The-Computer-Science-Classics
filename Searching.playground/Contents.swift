import Foundation

/*
 
 Searching
 
*/

let numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]

/*
 
 Linear Search
 
 O(n)
 
*/

func linearSearch<T: Equatable>(a: [T], _ object: T) -> Int? {
    var count = 0
    for i in a {
        if i == object {
            return count
        }
        count += 1
    }
    
    return nil
}

numbers[linearSearch(a: numbers, 5)!]

/*
 
 Binary Search
 
 With a sorted array, as opposed to going though an array in a linear fashion
 devide and conqure
 
 Keep splitting the array in half until you arrive at the value.
 
 n log n
 
 */

func binarySearch(a: [Int], key: Int, low: Int, high: Int) -> Int? {
    if low >= high {
        return nil
    }
    
    //Get middle of this chunk of aray
    let midIndex = low + (high - low) / 2
    
    //Split in array in half for another search depending on where the key falls
    if key < a[midIndex] {
        return binarySearch(a: a, key: key, low: low, high: midIndex)
    }
    
    if key > a[midIndex] {
        return binarySearch(a: a, key: key, low: midIndex + 1, high: high)
    }
    
    return midIndex
}

binarySearch(a: numbers, key: 7, low: 0, high: numbers.count)



/* 
 
 Count Occurences 
 
 Uses a modified binary search 
 
*/

/*
 
 Find Min/Max
 
*/

/*
 
 k-th Largest Element
 
*/

/* 
 
 Selection Samlping
 
*/

