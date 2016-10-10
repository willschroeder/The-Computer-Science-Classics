

import Foundation

/*

 Binary Search Tree
 
*/

class BinarySearchTree<T: Comparable> {
    fileprivate(set) var value: T
    fileprivate(set) var parent: BinarySearchTree?
    fileprivate(set) var left: BinarySearchTree?
    fileprivate(set) var right: BinarySearchTree?
    
    init(value: T) {
        self.value = value
    }
    
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    // === is an identical check, literally has to be this node
    var isLeftChild: Bool {
        return parent?.left === self
    }
    
    var isRightChild: Bool {
        return parent?.right === self
    }
    
    var hasLeftChild: Bool {
        return left != nil
    }
    
    var hasRightChild: Bool {
        return right != nil
    }
    
    var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    
    var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    func leftMostNode() -> BinarySearchTree {
        var node = self
        while node.left != nil {
            node = node.left!
        }
        return node
    }
    
    func rightMostNode() -> BinarySearchTree {
        var node = self
        while node.right != nil {
            node = node.right!
        }
        return node
    }
}

let bst = BinarySearchTree<Int>(value: 7)

// Insertion

extension BinarySearchTree {
    // Insert a single value
    func insert(value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            }
            else {
                left = BinarySearchTree(value: value)
                left?.parent = self
            }
        }
        //== and > go in the right branch
        else {
            if let right = right {
                right.insert(value: value)
            }
            else {
                right = BinarySearchTree(value: value)
                right?.parent = self
            }
        }
    }
}

//             7
//            /  \
//           6    8
//          /      \
//        2         9
//       /  \
//      1    4
//          /  \
//         3    5

for i in [6,8,9,2,1,4,3,5] {
    bst.insert(value: i)
}

// Depth First Search

extension BinarySearchTree {
    func depthFirstSearch(value: T) -> T? {
        
        if self.value == value {
            return value
        }
        
        if value < self.value {
            return left?.depthFirstSearch(value: value)
        }
        
        if value > self.value {
            return right?.depthFirstSearch(value: value)
        }
        
        return nil
    }
    
}

bst.depthFirstSearch(value: 5)
bst.depthFirstSearch(value: 5555)

// Breadth First Search 

// Keep appending nodes, deeper and deeper from left to right, then going down a level, until a value is found or no nodes left to search

extension BinarySearchTree {
    func breadthFirstSearch(value: T) -> T? {
        var nodes = [BinarySearchTree<T>]()
        nodes.append(self)
        
        while nodes.count > 0 {
            let node = nodes.removeFirst()
            
            if node.value == value {
                return value
            }
            
            if let left = node.left {
                nodes.append(left)
            }

            if let right = node.right {
                nodes.append(right)
            }
        }
        
        return nil
    }
}

bst.breadthFirstSearch(value: 5)
bst.breadthFirstSearch(value: 55)

// Traversal

/*

 Traversal is in what order you navigate a tree.
 You can traverse in 3 ways.
 Pretend you are writing a function to add all the nodes in a BST to an array
 
 1) in order - Append left, append self, then append right (this is most used, depth first works this way)
 2) pre order - Append self, append left, append right
 3) post order - Append left, append right, append self
 
 This will change the order of the array you get back 
 
*/

// Making a map function, done using an in order traversal

extension BinarySearchTree {
    func map(formula: (T) -> T) -> [T] {
        var a = [T]()
        if let left = left { a += (left.map(formula: formula)) }
        a.append(formula(value))
        if let right = right { a += (right.map(formula: formula)) }
        return a
    }
    
    func toArray() -> [T] {
        return map { $0 }
    }
}

bst.map { (val) -> Int in
    return val * 2
}

bst.toArray()

// Deleting Nodes

extension BinarySearchTree {
    //Replace self with the node parameter
    private func connectParentToNode(node: BinarySearchTree?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            }
            else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
    
    private func removeSelfAndReplaceWith(node: BinarySearchTree?) {
        connectParentToNode(node: node)

        parent = nil
        left = nil
        right = nil
    }
    
    private func removeNodeWithTwoChildren(left: BinarySearchTree, _ right: BinarySearchTree) -> BinarySearchTree? {
        //Replace this node with the smallest child that is larger than this nodes value
        let sucessor = right.leftMostNode()
        
        //Remove from hierarchy, it will be replacing this node
        sucessor.remove()
    
        //Reconnect the left node
        sucessor.left = left
        left.parent = sucessor
        
        //Reconnect the right node
        //If the right node is not the sucessor node, reconnect it
        if right !== sucessor {
            sucessor.right = right
            right.parent = sucessor
        }
        //Otherwise, this was the only node to the right, and no longer exists
        else {
            sucessor.right = nil
        }
        
        return sucessor
    }
    
    func remove() {
        if isLeaf {
            removeSelfAndReplaceWith(node: nil)
        }
        else if hasLeftChild && !hasRightChild {
            removeSelfAndReplaceWith(node: self.left)
        }
        else if !hasLeftChild && hasRightChild {
            removeSelfAndReplaceWith(node: self.right)
        }
        else if hasLeftChild && hasRightChild {
            let replacementNode = removeNodeWithTwoChildren(left: self.left!, self.right!)
            removeSelfAndReplaceWith(node: replacementNode)
        }
    }
}

let deleteMe = bst.left!.left!
bst.depthFirstSearch(value: 2)
deleteMe.value
deleteMe.remove()
bst.depthFirstSearch(value: 2)

// Depth & Height

extension BinarySearchTree {
    //How many connections is the furthest node from this node
    func height() -> Int {
        if isLeaf {
            return 0
        }
        return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
    }
    
    //How many levels deep is this node
    func depth() -> Int {
        var node = self
        var count = 0
        while node.parent != nil {
            node = node.parent!
            count += 1
        }
        return count
    }
}

bst.height()
bst.left!.left!.depth()

// Predecessor & Successor

//If you have a tree that is 7 -> 2 -> 5, the predecessor of 7 would be 5, which is after the 2 in the tree
extension BinarySearchTree {
    func predecessor() -> BinarySearchTree? {
        //The right most node on the left side is the maximum
        if let left = left {
            return left.rightMostNode()
        }
        
        //Otherwise loop upward though the parents to find a smaller node
        var node = self
        while node.parent != nil {
            if parent!.value < value { return parent }
            node = node.parent!
        }
        
        return nil
    }
    
    //Reverse predecessor to get a sucessor
    func sucessor() -> BinarySearchTree? {
        if let right = right {
            return right.leftMostNode()
        }
        
        // A thing to note here is that this only goes up though the parents,
        // it never traverses down, so its not searching the whole tree
        var node = self
        while node.parent != nil {
            if parent!.value > value { return parent }
            node = node.parent!
        }
        
        return nil
    }
}

bst.value
bst.predecessor()!.value
bst.predecessor()!.predecessor()!.value
bst.sucessor()!.value

// Is Tree Valid?

extension BinarySearchTree {
    func isValid(minValue: T, maxValue: T) -> Bool {
        //If outside the range, tree isnt valid
        if value < minValue || value > maxValue { return false }
        
        //All things on the left must be between the lowest and the value of this node
        //If there is no left node, then its valid
        let isLeftValid = left?.isValid(minValue: minValue, maxValue: value) ?? true
        
        let isRightValid = right?.isValid(minValue: value, maxValue: maxValue) ?? true
        return isLeftValid && isRightValid
    }
}

bst.isValid(minValue: Int.min, maxValue: Int.max)
bst.rightMostNode().insert(value: 5) // 5 less than the root 7
bst.isValid(minValue: Int.min, maxValue: Int.max)
bst.rightMostNode().left!.remove()
bst.isValid(minValue: Int.min, maxValue: Int.max)


// Invert a Binary Search Tree

extension BinarySearchTree {
    func invert() {
        //Flip left and right
        let tempLeft = left
        let tempRight = right
        right = tempLeft
        left = tempRight
        
        //Do the same for all child nodes
        if let left = left {
            left.invert()
        }
        
        if let right = right {
            right.invert()
        }
    }
}

bst.left!.value
bst.invert()
bst.left!.value
bst.invert()
bst.left!.value

