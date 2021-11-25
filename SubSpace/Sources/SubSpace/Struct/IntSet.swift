//
//  File.swift
//  
//
//  Created by Nail Sharipov on 10.11.2021.
//

public struct IntSet {

    private var array: [Bool]
    
    var isEmpty: Bool {
        array.first(where: { $0 }) == nil
    }
    
    private (set) var count: Int
//    var count: Int {
//        var result = 0
//        for i in 0..<array.count where array[i] {
//            result += 1
//        }
//        return result
//    }
    
    var first: Int? {
        array.firstIndex(where: { $0 })
    }
    
    public var sequence: [Int] {
        var result = [Int]()
        result.reserveCapacity(array.count)
        for i in 0..<array.count where array[i] {
            result.append(i)
        }
        return result
    }
    
    init(size: Int) {
        count = 0
        array = [Bool](repeating: false, count: size)
    }
    
    init(size: Int, _ array: [Int]) {
        self.init(size: size)
        for a in array {
            self.array[a] = true
        }
        count = array.count
    }
    
    func first(where predicate: (Int) -> (Bool)) -> Int? {
        for i in 0..<array.count where array[i] {
            if predicate(i) {
                return i
            }
        }
        return nil
    }

    mutating func formUnion(_ set: IntSet) {
        var cnt = 0
        for i in 0..<array.count where set.array[i] && !array[i] {
            array[i] = true
            cnt += 1
        }
        count += cnt
    }
    
    func union(_ set: IntSet) -> IntSet {
        var result = self
        result.formUnion(set)
        return result
    }
    
    mutating func subtract(_ set: IntSet) {
        var dif = 0
        for i in 0..<array.count where set.array[i] && array[i] {
            array[i] = false
            dif += 1
        }
        count -= dif
    }
    
    func subtracting(_ set: IntSet) -> IntSet {
        var result = self
        result.subtract(set)
        return result
    }
    
    mutating func intersect(_ set: IntSet) {
        var cnt = 0
        for i in 0..<array.count where array[i] && set.array[i] {
            self.array[i] = true
            cnt += 1
        }
        count = cnt
    }
    
    func intersection(_ set: IntSet) -> IntSet {
        var result = self
        result.intersect(set)
        return result
    }
    
    func contains(_ element: Int) -> Bool {
        array[element]
    }
    
    func isSubset(of set: IntSet) -> Bool {
        for i in 0..<array.count where array[i] && !set.array[i] {
            return false
        }
        return true
    }
    
    mutating func insert(_ element: Int) {
        guard !array[element] else { return }
        array[element] = true
        count += 1
    }
    
    mutating func remove(_ element: Int) {
        guard array[element] else { return }
        array[element] = false
        count -= 1
    }
    
    mutating func removeAll() {
        for i in 0..<array.count {
            array[i] = false
        }
        count = 0
    }

    mutating func removeFirst() -> Int {
        for i in 0..<array.count where array[i] {
            array[i] = false
            count -= 1
            return i
        }
        return -1
    }

}

extension IntSet: CustomDebugStringConvertible, CustomStringConvertible {
    
    public var debugDescription: String {
        return "\(self.sequence)"
    }
    
    public var description: String {
        return "\(self.sequence)"
    }
    
}
