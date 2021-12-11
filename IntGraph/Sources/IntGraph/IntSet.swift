//
//  IntSet.swift
//  
//
//  Created by Nail Sharipov on 26.11.2021.
//

public struct IntSet {
    
    private struct Node {
        static let empty = Node(prev: .empty, next: .empty)
        var prev: Int
        var next: Int
    }

    private var buffer: [Node]
    private var firstIndex: Int = .empty
    public private (set) var count: Int
    
    @inline(__always)
    public var isEmpty: Bool { count == 0 }
    
    @inline(__always)
    public var first: Int {
        firstIndex
    }

    @inline(__always)
    public var sequence: [Int] {
        var result = [Int]()
        result.reserveCapacity(count)
        var index = firstIndex
        while index != .empty {
            result.append(index)
            index = buffer[index].next
        }
        return result
    }
    
    public init(size: Int) {
        buffer = [Node](repeating: .empty, count: size)
        self.count = 0
    }

    public init(size: Int, array: [Int]) {
        buffer = [Node](repeating: .empty, count: size)
        count = array.count
        switch count {
        case 0:
            return
        case 1:
            firstIndex = array[0]
            return
        case 2:
            let a0 = array[0]
            let a1 = array[1]
            firstIndex = a0
            buffer[a0].next = a1
            buffer[a1].prev = a0
            return
        default:
            var prev = Int.empty
            firstIndex = array[0]
            var index = firstIndex
            for i in 1..<count {
                let next = array[i]
                buffer[index] = Node(prev: prev, next: next)
                prev = index
                index = next
            }
            buffer[index].prev = prev
        }
    }
    
    @inline(__always)
    public func contains(_ element: Int) -> Bool {
        assert(element < buffer.count)
        let node = buffer[element]
        let isExist = node.prev != .empty || firstIndex == element
        return isExist
    }
    
    @inline(__always)
    public func contains(where predicate: (Int) -> Bool) -> Bool {
        var index = firstIndex
        while index != .empty {
            if predicate(index) {
                return true
            }
            index = buffer[index].next
        }

        return false
    }
    
    @inline(__always)
    public mutating func insert(_ element: Int) {
        assert(element < buffer.count)
        guard !self.contains(element) else { return }
        count += 1
        buffer[element] = Node(prev: .empty, next: firstIndex)
        if firstIndex != .empty {
            buffer[firstIndex].prev = element
        }
        firstIndex = element
    }
    
    @inline(__always)
    public mutating func insert(contentsOf sequence: [Int]) {
        for index in sequence {
            self.insert(index)
        }
    }
    
    @inline(__always)
    public mutating func remove(_ element: Int) {
        assert(element < buffer.count)
        let node = buffer[element]
        guard self.contains(element) else { return }
        count -= 1
        
        buffer[element] = .empty
        
        if node.prev != .empty {
            buffer[node.prev].next = node.next
        }
        
        if node.next != .empty {
            buffer[node.next].prev = node.prev
        }
        
        if firstIndex == element {
            firstIndex = node.next
        }
    }
    
    @inline(__always)
    public func first(where predicate: (Int) -> (Bool)) -> Int {
        var index = firstIndex
        while index != .empty {
            if predicate(index) {
                return index
            }
            index = buffer[index].next
        }

        return .empty
    }
    
    @inline(__always)
    public mutating func formUnion(_ set: IntSet) {
        var index = set.firstIndex
        while index != .empty {
            self.insert(index)
            index = set.buffer[index].next
        }
    }
    
    @inline(__always)
    public func union(_ set: IntSet) -> IntSet {
        var result = self
        result.formUnion(set)
        return result
    }
    
    @inline(__always)
    public mutating func subtract(_ set: IntSet) {
        var index = set.firstIndex
        while index != .empty {
            self.remove(index)
            index = set.buffer[index].next
        }
    }
    
    @inline(__always)
    public func subtracting(_ set: IntSet) -> IntSet {
        var result = self
        result.subtract(set)
        return result
    }

    @inline(__always)
    public mutating func intersect(_ set: IntSet) {
        var index = self.firstIndex
        while index != .empty {
            let nextIndex = buffer[index].next
            if !set.contains(index) {
                self.remove(index)
            }
            index = nextIndex
        }
    }
    
    @inline(__always)
    public func intersection(_ set: IntSet) -> IntSet {
        var result = self
        result.intersect(set)
        return result
    }
    
    @inline(__always)
    public func forEach(_ body: (Int) -> ()) {
        var index = firstIndex
        while index != .empty {
            body(index)
            index = buffer[index].next
        }
    }

    @inline(__always)
    public mutating func removeAll() {
        var index = firstIndex
        while index != .empty {
            let nextIndex = buffer[index].next
            buffer[index] = .empty
            index = nextIndex
        }
        count = 0
        firstIndex = .empty
    }
    
}

extension IntSet: CustomDebugStringConvertible, CustomStringConvertible {
    
    public var debugDescription: String {
        sequence.debugDescription
    }
    
    public var description: String {
        sequence.debugDescription
    }
    
}
