import XCTest
@testable import IntGraph

final class IntSetTests: XCTestCase {

    func test_insert() throws {
        let size = 10
        
        for _ in 0..<1000 {
            var aSet = Set<Int>()
            var bSet = IntSet(size: size)
            for _ in 0..<size {
                let e = Int.random(in: 0..<size)
                aSet.insert(e)
                bSet.insert(e)
            }

            XCTAssertEqual(aSet.count, bSet.count)
            XCTAssertEqual(aSet, Set(bSet.sequence))
        }
    }
    
    func test_remove() throws {
        let size = 10
        
        for _ in 0..<1000 {
            var aSet = Self.randomSet(max: size)
            var bSet = IntSet(size: size, array: Array(aSet))
            XCTAssertEqual(aSet, Set(bSet.sequence))
            for _ in 0..<size {
                let e = Int.random(in: 0..<size)
                aSet.remove(e)
                bSet.remove(e)
            }
            
            XCTAssertEqual(aSet.count, bSet.count)
            XCTAssertEqual(aSet, Set(bSet.sequence))
        }
    }
    
    func test_union() throws {
        let size = 10
        
        for _ in 0..<1000 {
            let aSet0 = Self.randomSet(max: size)
            let bSet0 = IntSet(size: size, array: Array(aSet0))

            let aSet1 = Self.randomSet(max: size)
            let bSet1 = IntSet(size: size, array: Array(aSet1))

            let aSet2 = aSet0.union(aSet1)
            let bSet2 = bSet0.union(bSet1)

            XCTAssertEqual(aSet2.count, bSet2.count)
            XCTAssertEqual(aSet2, Set(bSet2.sequence))
        }
    }
    
    func test_subtracting() throws {
        let size = 10
        
        for _ in 0..<1000 {
            let aSet0 = Self.randomSet(max: size)
            let bSet0 = IntSet(size: size, array: Array(aSet0))

            let aSet1 = Self.randomSet(max: size)
            let bSet1 = IntSet(size: size, array: Array(aSet1))

            let aSet2 = aSet0.subtracting(aSet1)
            let bSet2 = bSet0.subtracting(bSet1)
            
            XCTAssertEqual(aSet2.count, bSet2.count)
            XCTAssertEqual(aSet2, Set(bSet2.sequence))
        }
    }
    
    func test_intersection() throws {
        let size = 10
        
        for _ in 0..<1000 {
            let aSet0 = Self.randomSet(max: size)
            let bSet0 = IntSet(size: size, array: Array(aSet0))

            let aSet1 = Self.randomSet(max: size)
            let bSet1 = IntSet(size: size, array: Array(aSet1))

            let aSet2 = aSet0.intersection(aSet1)
            let bSet2 = bSet0.intersection(bSet1)

            XCTAssertEqual(aSet2.count, bSet2.count)
            XCTAssertEqual(aSet2, Set(bSet2.sequence))
        }
    }
    
    
    static func randomSet(max: Int) -> Set<Int> {
        var set = Set<Int>()
        for _ in 0..<max {
            set.insert(Int.random(in: 0..<max))
        }
        return set
    }
}
