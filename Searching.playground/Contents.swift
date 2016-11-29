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
 
 Using a modified binary search, we find the first (left) of the number, and the last (right) of the same
 
 Array must be sorted 
 
*/

func countOccurancesOf(_ key: Int, array a: [Int]) -> Int {
    func leftBoundry() -> Int {
        //Start with the full array, we will be tracking indexes
        var low = 0
        var high = a.count
        
        //If high equals low, we may have found the number.
        //If high becomes less than low, the number isnt present
        while low < high {
            //Get the mid point between whevever low and high are set
            let mid = low + (high - low)/2
            
            //If the mid index is a lower value than the key,
            //we have not arrived at the first instance yet 
            //So the next possible instance would be next one after the mid index
            //
            //We are sccoting low up to be the at the first instance
            if a[mid] < key {
                low = mid + 1
            }
            //If the mid index is equal to or greater than the key
            //A lower value could be the first instance, so we need to keep going
            else {
                high = mid
            }
            
            //Either the low has been moved forward, or high has been brought closer 
            //If low is stuck on the first instance, high will move in until its equal to low
        }
        
        //Because we scooted low to the first instance, we return it
        return low
    }
    
    func rightBoundry() -> Int {
        var low = 0
        var high = a.count
        
        while low < high {
            let mid = low + (high - low)/2
            
            //This is the inverse of above,
            //Instead of scooting low up, we scoot high down
            //and low is collapsed into high
            if a[mid] > key {
                high = mid
            }
            else {
                low = mid + 1
            }
        }
        
        return low
    }
    
    return rightBoundry() - leftBoundry()
}

countOccurancesOf(3, array: [ 0, 1, 1, 3, 3, 3, 3, 6, 8, 10, 11, 11 ])  // returns 4


/*
 
 Find Min/Max in an unsorted array
 
 The easiest way is to just iterate though an array, checking each element to see if its greater than the current value, and if it is, store the new value.
 Same story for minimum.
 
 We can speed it up slightly by finding the min and the max at the same time. 
 Because we are doing this, we can do it with one less step than doing them individually.
 
*/

func findMinMax(array: [Int]) -> (min: Int, max: Int)? {
    guard !array.isEmpty else {
        return nil
    }
    
    var a = array
    var min = a.first!
    var max = a.first!
    
    //If the array is odd, we need to make it even
    //Its safe to remove the first because we set it as the value above
    //If it is already even, we will just consider the first number in the first pass
    if a.count % 2 != 0 {
        a.removeFirst()
    }
    
    while !a.isEmpty {
        //Pull off the next two numbers
        let pair = (a.removeFirst(), a.removeFirst())
        
        //Find the larger of the two
        //We do so that we dont waste a calculation asking the smaller of the two to be compared aginst the largest, because we know it wont be
        if pair.0 > pair.1 {
            if pair.0 > max {
                max = pair.0
            }
            
            if pair.1 < min {
                min = pair.1
            }
        }
        else {
            if pair.1 > max {
                max = pair.1
            }
            
            if pair.0 < min {
                min = pair.0
            }
        }
    }

    return (min, max)
}

findMinMax(array: [ 8, 3, 9, 4, 6 ])

/*
 
 k-th Largest Element
 
 In an array of [2,3,1,4], the 2nd largest element would be 3
 The slow way is to sort the array, and then do array.count - k
 
 To speed it up, we will use a devide and conquer with a method a lot like quicksort. Instead of sorting the whole array, we will just sort the part of the array we know the value must be in, ignoring the rest. 
 So every pass will have half the number of elements to deal with.
 
 This implentation isnt as efficent as it could be, im going to create new memory to keep the example simple
 
*/

let test = [0,1,2,3,4,5,6,7,8]
let min = 3
let max = 7
test[0...min-1]
test[min...max]
test[max...test.count-1]

//kthLargest(array: [ 7, 92, 23, 9, -1, 0, 11, 6 ], low: 0, high: 8, k: 4)

/* 
 
 Selection Sampling
 
 A pointer starts at 0 on an array, selects a random element in the array, moves it to point 0
 Move the pointer to 1, select an element infront of the moved pointer
 This makes a pool to the left of the pointer with the selected items
 To the right of the pointer is the unselected pool
 Return the left pool when you have selected enough
 
*/

func randomRange(min: Int, max: Int) -> Int {
    return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}

func randomFromArray(from a: [Int], count k: Int) -> [Int] {
    var a = a
    for i in 0..<k {
        let r = randomRange(min: i, max: a.count - 1)
        //Don't swap if the random selection was the pointer
        if i != r {
            swap(&a[i], &a[r])
        }
    }
    return Array(a[0..<k])
}

randomFromArray(from: numbers, count: 3)

