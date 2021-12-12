//
//  Random.swift
//  RandomTest
//
//  Created by Nail Sharipov on 12.12.2021.
//

struct Random {
    
    private var next: UInt = 1
    
    mutating func number(max: Int) -> Int {
        next = next &* 1103515245 &+ 12345
        let a = (next / 65536) % 32768
        return Int(a % UInt(max))
    }
    
}
