import Foundation

/*
 
 Heap Max-Heap High-To-Low
 
 Good for priorirty queues, also can be used to sort, though not as fast as quicksort
 Swapping the > to a < turns this into a min heap
 
 Makes a binary tree inside an array, so 0 is pointing to 1,2 as its children, and 1 is pointing to 3,4, with 2 going to 5,6
 Push adds a value to the end, and then swaps it way up with its current parent until its under a node with a higher value
 Pop removes the top, and moves the lowest element to the root, then swaps it with its down with its largest child until its under a parent with a higher value
*/


class Heap<T: Comparable> {
    var elements = [T]()
    
    //Add and Remove
    func push(_ value: T) {
        elements.append(value)
        shiftUp(index: elements.count - 1)
    }
    
    func pop() -> T? {
        if elements.isEmpty {
            return nil
        }
        else if elements.count == 1 {
            return elements.removeLast()
        }
        else {
            // Use the last node to replace the first one, then fix the heap by
            // shifting this new first node into its proper position.
            let value = elements[0]
            elements[0] = elements.removeLast()
            shiftDown(index: 0)
            return value
        }
    }
    
    //Functions to navigate the array
    func parentIndex(ofIndex i: Int) -> Int {
        return (i-1) / 2
    }
    
    func leftChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 1
    }
    
    func rightChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 2
    }
    
    //Heap Sorters
    //If element is greater than parent, it needs to swap with its parent
    func shiftUp(index: Int) {
        var childIndex = index
        let child = elements[index]
        var parentIndex = self.parentIndex(ofIndex: index)
        let parent = elements[parentIndex]

        //If the child is greater than the parent, it needs to move up
        if child > parent {
            //Verify correct order all the way to the root node
            //The parent can reach 0, leaving the child at 1, which is the root
            while childIndex > 0 {
                //Move the child element to the parents slot because its lower
                elements[childIndex] = elements[parentIndex]
                //The child is now at the parent index, so get the next parent
                childIndex = parentIndex
                parentIndex = self.parentIndex(ofIndex: childIndex)
            }
        }
        //Now that we have the correct index, put the child there
        elements[childIndex] = child
    }
    

    //If an element is smaller than its childrne, it needs to shift down
    func shiftDown(index: Int) {
        var parentIndex = index
        
        while true {
            let leftChildIndex = self.leftChildIndex(ofIndex: parentIndex)
            let rightChildIndex = self.rightChildIndex(ofIndex: parentIndex)
            
            //We will check to see who is the largest between a parent and its children, 
            //The largest value should be the parent
            var largestNode = parentIndex
            
            //We actually have a value at the index generated && the left child is larger than the parent
            if leftChildIndex < elements.count && elements[leftChildIndex] > elements[largestNode] {
                largestNode = leftChildIndex
            }
            
            if rightChildIndex < elements.count && elements[rightChildIndex] > elements[largestNode] {
                largestNode = rightChildIndex
            }
            
            //If it is still the parent node, no swap is needed
            if largestNode == parentIndex { return }
            
            //Otherwise swap the largest of the two children with the parent node
            swap(&elements[parentIndex], &elements[largestNode])
            //Move down the tree, continue this until no swap is needed
            parentIndex = largestNode
        }
    }
}

let heap = Heap<Int>()
heap.push(10)
heap.push(14)
heap.push(33)
heap.push(81)
heap.push(82)
heap.push(99)
heap.push(1)
heap.elements
heap.pop()
heap.pop()
heap.pop()
heap.pop()
heap.pop()
heap.pop()
heap.pop()
heap.elements
