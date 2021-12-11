//
//  FixedList.swift
//  
//
//  Created by Nail Sharipov on 26.11.2021.
//

public struct FixedList<T> {
    
    private struct Node<T> {
        var prev: Int
        var next: Int
        var value: T
    }
    
    private let empty: T
    public private (set) var set: IntSet
    public private (set) var buffer: [T]

    @inline(__always)
    public var count: Int { self.set.count }
    
    @inline(__always)
    public var first: T? {
        let index = set.first
        if index != .empty {
            return buffer[index]
        } else {
            return nil
        }
    }

    @inline(__always)
    public var sequence: [T] {
        var result = [T]()
        result.reserveCapacity(count)
        set.forEach { index in
            result.append(buffer[index])
        }
        return result
    }

    @inline(__always)
    public var indices: [Int] { self.set.sequence }

    @inline(__always)
    public subscript(index: Int) -> T {
        get {
            return buffer[index]
        }
        set {
            self.insert(index, value: newValue)
        }
    }
    
    public init(size: Int, empty: T) {
        self.empty = empty
        self.set = IntSet(size: size)
        buffer = .init(repeating: empty, count: size)
    }

    public init(array: [T], empty: T) {
        let size = array.count
        self.empty = empty
        self.set = IntSet(size: size, array: Array(0..<size))
        buffer = array
    }
    
    @inline(__always)
    public func contains(_ index: Int) -> Bool { set.contains(index) }

//    @inlinable
    @inline(__always)
    public func contains(where predicate: (T) -> Bool) -> Bool {
        for index in set.sequence {
            if predicate(buffer[index]) {
                return true
            }
        }
        return false
    }
    
//    @inlinable
    @inline(__always)
    public func contains(where predicate: (Int, T) -> (Bool)) -> Bool {
        for index in set.sequence {
            if predicate(index, buffer[index]) {
                return true
            }
        }

        return false
    }
    
    @inline(__always)
    public mutating func insert(_ index: Int, value: T) {
        assert(index < buffer.count)
        
        buffer[index] = value
        set.insert(index)
    }

    @inline(__always)
    public mutating func remove(_ index: Int) {
        assert(index < buffer.count)
        guard set.contains(index) else { return }
        
        buffer[index] = empty
     
        set.remove(index)
    }
    
    @inline(__always)
    public mutating func removeAll() {
        set.removeAll()
        for i in 0..<buffer.count {
            buffer[i] = empty
        }
    }
    
//    @inlinable
    @inline(__always)
    public func firstIndex(where predicate: (T) -> (Bool)) -> Int {
        for index in set.sequence {
            if predicate(buffer[index]) {
                return index
            }
        }

        return .empty
    }
    
//    @inlinable
    @inline(__always)
    public func firstIndex(where predicate: (Int, T) -> (Bool)) -> Int {
        for index in set.sequence {
            if predicate(index, buffer[index]) {
                return index
            }
        }

        return .empty
    }
    
//    @inlinable
    @inline(__always)
    public func first(where predicate: (T) -> (Bool)) -> T? {
        for index in set.sequence {
            let value = buffer[index]
            if predicate(value) {
                return value
            }
        }

        return nil
    }
    
//    @inlinable
    @inline(__always)
    public func forEachIndex(_ body: (Int) -> ()) {
        self.set.forEach(body)
    }

}

extension FixedList: CustomDebugStringConvertible, CustomStringConvertible {
    
    public var debugDescription: String {
        var result = String()
        result.append("\n")
        result.append("set: \(self.set.debugDescription)\n")
        result.append("buffer: \(self.buffer.debugDescription)\n")
        return result
    }
    
    public var description: String {
        var result = String()
        result.append("\n")
        result.append("set: \(self.set.debugDescription)\n")
        result.append("buffer: \(self.buffer.debugDescription)\n")
        return result
    }

}

extension FixedList: CustomReflectable {
    public var customMirror: Mirror {
        Mirror(self, children: [
            "count": self.count,
            "set": self.set.sequence,
            "buffer": buffer
        ])
    }
}
