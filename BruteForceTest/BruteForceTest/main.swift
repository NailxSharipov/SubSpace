//
//  main.swift
//  BruteForceTest
//
//  Created by Nail Sharipov on 09.12.2021.
//

import Foundation
import IntGraph

print("start")

let n: Int = 6
let max: UInt64 = 1 << ((n - 1) * n + 1)

let threadsFactor: UInt64 = 3 // power of 2
let threadsCount: UInt64 = 1 << threadsFactor

let step: UInt64 = max >> threadsFactor
var a: UInt64 = 0
var i: UInt64 = 0

let group = DispatchGroup()

print("threads count: \(threadsCount)")

while i < threadsCount {
    group.enter()
    DispatchQueue.global().async { [index = i, start = a, count = step, n = n] in
        HamiltonPathTest.test(index: index, start: start, count: count, n: n)
        group.leave()
    }
    a += step
    i += 1
}

group.notify(queue: .main) {
    print("end")
}

group.wait()
