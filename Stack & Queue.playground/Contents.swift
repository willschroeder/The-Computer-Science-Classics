import Foundation
/*
 
 Stack - First in, Last out
 
*/

class Node<T> {
    var value: T
    var next: Node? = nil
    
    init(value: T) {
        self.value = value
    }
}

class Stack<T> {
    var head: Node<T>?
    
    func push(value: T) {
        let node = Node(value: value)
        
        if head != nil {
            node.next = head
            head = node
        }
        else {
            head = node
        }
    }
    
    func pop() -> T? {
        let value = head?.value
        head = head?.next
        return value
    }
}

let stack = Stack<Int>()

stack.push(value: 1)
stack.push(value: 2)
stack.push(value: 3)

stack.pop()
stack.pop()
stack.pop()
stack.pop()

/* 
 
 Queue 
 
*/

class Queue<T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    func push(value: T) {
        let node = Node(value: value)
        
        if tail == nil {
            head = node
            tail = node
        }
        else {
            tail?.next = node
            tail = node
        }
    }
    
    func pop() -> T? {
        let value = head?.value
        
        head = head?.next
        //If the next is null, queue is now empty
        if head == nil {
            tail = nil
        }
        
        return value
    }
}

let queue = Queue<Int>()

queue.push(value: 1)
queue.push(value: 2)
queue.push(value: 3)

queue.pop()
queue.pop()
queue.pop()
