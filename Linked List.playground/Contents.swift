import Foundation

/*

Linked List

*/

class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    
    init(value: T) {
        self.value = value
    }
}

class LinkedList<T> {
    typealias Node = LinkedListNode<T>
    
    private var head: Node?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: Node? {
        return head
    }
    
    var last: Node? {
        guard head != nil else { return nil }
        
        var node = head
        
        while node?.next != nil {
            node = node!.next
        }
        
        return node
    }
    
    var count: Int {
        guard head != nil else { return 0 }

        var count = 0
        var node = head
        
        while node?.next != nil {
            node = node!.next
            count += 1
        }
        return count
    }
    
    func append(value: T) {
        let newNode = Node(value: value)
        
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        }
        else {
            head = newNode
        }
    }
    
    func nodeAtIndex(index: Int) -> Node? {
        guard head != nil else { return nil }
        
        var node = head
        var i = index
        
        while node != nil {
            if i == 0 { return node }
            i -= 1
            node = node!.next
        }

        return nil
    }
    
    subscript(index: Int) -> T {
        let node = nodeAtIndex(index: index)
        assert(node != nil)
        return node!.value
    }
    
    private func nodesBeforeAndAFter(index: Int) -> (Node?, Node?) {
        assert(index >= 0)
        
        var i = index
        var next = head
        var prev: Node?
        
        while next != nil && i > 0 {
            i -= 1
            prev = next
            next = next!.next
        }
        assert(i == 0)
        
        return (prev, next)
    }
    
    func insert(value: T, atIndex index: Int) {
        let (prev, next) = nodesBeforeAndAFter(index: index)
        let newNode = Node(value: value)
        
        newNode.previous = prev
        newNode.next = next
        prev?.next = newNode
        next?.previous = newNode
        
        if prev == nil {
            head = newNode
        }
    }
    
    func removeAll() {
        head = nil
    }
    
    func removeNode(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        }
            
        //Node is first, aka the head
        else {
            head = next
        }
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    func removeAtIndex(index: Int) -> T {
        let node = nodeAtIndex(index: index)
        assert(node != nil)
        return removeNode(node: node!)
    }
    
    //Just flip the next and previous pointers to reverse list
    func reverse() {
        var node = head
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            head = currentNode
        }
    }
}

let list = LinkedList<String>()
list.isEmpty   // true
list.first     // nil
list.append(value: "Hello")
list.isEmpty         // false
list.first!.value    // "Hello"
list.last!.value     // "Hello"
list.append(value: "World")
list.first!.value    // "Hello"
list.last!.value     // "World"
list[0]   // "Hello"
list[1]   // "World"
//list[2]   // crash!
list.insert(value: "Swift", atIndex: 1)
list[0]     // "Hello"
list[1]     // "Swift"
list[2]     // "World"
list.removeNode(node: list.first!)   // "Hello"
list.count                     // 2
list[0]                        // "Swift"
list[1]                        // "World"
