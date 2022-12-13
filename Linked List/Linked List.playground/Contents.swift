import Foundation

//MARK: - Linked List
final class Node<T> {
    let value: T
    var next: Node<T>?
    
    init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
}

struct LinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    var isEmpty: Bool { head == nil }
    
    //MARK: Operations
    mutating func push(_ node: Node<T>) {
        node.next = head
        head = node
        
        // setup tail 🦘
        if tail == nil {
            tail = head
        }
    }
    
    mutating func push(_ value: T) {
        let node = Node(value: value)
        self.push(node)
    }
    
    mutating func append(_ node: Node<T>) {
        tail?.next = node
        tail = node
    }
    
    mutating func append(_ value: T) {
        let node = Node(value: value)
        self.append(node)
    }
    
    func node(at index: Int) -> Node<T>? {
        var currentIndex = 0
        var currentNode = head
        
        while currentNode != nil,
              currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }
    
    mutating func insert(_ value: T, after index: Int) {
        guard let node = node(at: index) else { return }
        node.next = Node(value: value, next: node.next)
    }
    
    mutating func insert(node: Node<T>, at index: Int) {
        guard let currentNode = self.node(at: index) else { return }
        node.next = currentNode
    }
    
    /// Pop: By popping data, we remove the head from the list, so the second node will then become the head.
    mutating func pop() -> T? {
        defer {
            var oldHead = head
            head = head?.next
            oldHead = nil
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    mutating func removeLast() -> T? {
        
        guard !isEmpty else { return nil }
        guard let head = head else { return nil }
        guard head.next != nil else { return pop() }
        
        var currentNode = head
        var previousNode = head
        
        while let next = currentNode.next {
            previousNode = currentNode
            currentNode = next
        }
        
        previousNode.next = nil
        tail = previousNode
        
        return currentNode.value
    }
    
    func print() {
        var currentNode = head
        
        while let value = currentNode?.value {
            Swift.print(value)
            currentNode = currentNode?.next
        }
    }
}

var list = LinkedList<Int>()
list.push(10)
list.push(22)


list.append(5)
list.append(2)

list.insert(15, after: 1)

list.print()
