import Foundation


/*

BIG O 

The performace or complexity of an algorithm, calculated to the worst case scenario. 
Can be ued to describe execution time or memory requirements, though usually the foucs is on execution time.

*/

// O(1) - Constant
// Returns the same speed regardless of data set

func isFirstElementNil(objects: [AnyObject?]) -> Bool {
    return objects[0] == nil
}

isFirstElementNil(objects: [true as Optional<AnyObject>])


// O(N) - Linear
// An algorithm whose perforamce will grow in direct proportion with its input data
// Also known as linear, or brute force, it would need to check all the numbers to determine if key isnt present

let numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
func linearSearch(key: Int) {
    
    //check all possible values
    for number in numberList {
        if number == key {
            print("value at \(key) found..")
            break
        }
    }
}

linearSearch(key: 5)
linearSearch(key: 11)


// O(N^2) - Quadratic
// Also whose performance is directly proportional to the square of the size of the data set
// Usually it means you are using nested loops, the more loops, the higher the power to 

let comboList = [1, 2, 3]
func allCombinations() {
    var results = [(Int, Int)]()
    for item in comboList {
        for innerItem in comboList {
            results.append((item, innerItem))
        }
    }
    print(results)
}

allCombinations()

// O(2^N) - Exponential
// An algo whose growth doubles with each addition to the input, pretty damn expensive 

func fibonacci(number: Int) -> Int {
    if number <= 1 {
        return number
    }
    
    return fibonacci(number: number-2) + fibonacci(number: number-1)
}

fibonacci(number: 11)


// O(log N) - Logarithmic
// This binary search works by cutting the list in half every pass, and arrives much more quickly at the result
// This is assuming the data is in order
// This "cutting the data in half" technique is called logarithmitic, or log for short

func binarySearch(key: Int, min: Int, max: Int) {
    // If min as surpassed max, the value was not found
    // This is because it has narrowed it down to the slot where it should be
    // but because it is not there, min and max will slip one past each other
    if min > max {
        print("value \(key) NOT found..")
        return
    }
    
    //Middle of the array
    let midIndex = Int(round(Double((min + max) / 2)))
    
    //The value at the middle of the array
    let midNumber = numberList[midIndex]
    
    //reduce the range
    if key < midNumber {
        binarySearch(key: key, min: min, max: midIndex - 1)
    }
        
    //increase the range
    else if key > midNumber {
        binarySearch(key: key, min: midIndex + 1, max: max)
    }
    
    else if key == midNumber {
        print("value \(key) found..")
    }
}

binarySearch(key: 7, min: 0, max: numberList.count-1)


// O(N log N) = "Devide and Conquer"
// If every time the data is split in half, but not discared like above, it is N log N
// Sorting algos like Merge, Heap and Quick sort are N log N




