//
//  SceneData.swift
//  Shared
//
//  Created by Nail Sharipov on 23.09.2021.
//

import CoreGraphics

struct SceneData {

    struct Data {
        let points: [CGPoint]
        let path: [Int]
        
        init(_ points: [CGPoint], path: [Int] = []) {
            self.points = points
            self.path = path
        }
    }

    static let data: [Data] = [
        Data([
            CGPoint(x: -15, y:  -15),
            CGPoint(x: -15, y:  -5),
            CGPoint(x: -15, y:  5),
            CGPoint(x: -15, y:  15),

            CGPoint(x: -5, y:  -15),
            CGPoint(x: -5, y:  -5),
            CGPoint(x: -5, y:  5),
            CGPoint(x: -5, y:  15),
            
            CGPoint(x: 5, y:  -15),
            CGPoint(x: 5, y:  -5),
            CGPoint(x: 5, y:  5),
            CGPoint(x: 5, y:  15),
            
            CGPoint(x: 15, y:  -15),
            CGPoint(x: 15, y:  -5),
            CGPoint(x: 15, y:  5),
            CGPoint(x: 15, y:  15)
        ]),
        Data([
            CGPoint(x: 0.0, y: 24.0),
            CGPoint(x: 13.280306897592089, y: -12.489890080097426),
            CGPoint(x: 23.398269892363768, y: -5.340502414951544),
            CGPoint(x: 10.413209738821397, y: -21.623252829658057),
            CGPoint(x: -10.413209738821392, y: -21.62325282965806),
            CGPoint(x: -23.398269892363764, y: -5.34050241495155),
            CGPoint(x: -18.763955579232718, y: 14.963755244609601),
            CGPoint(x: -5.0, y: 0.0),
            CGPoint(x: 5.0, y: 0.0),
            CGPoint(x: 0.0, y: -7.0)
        ]),
        
//        Data(Self.circles(n: 7, radiuses: [24]) + [CGPoint(x: -5, y: 0), CGPoint(x: 5, y: 0), CGPoint(x: 0, y: -7)]),
//        Data(Self.circles(n: 16, radiuses: [16]) + Self.circles(n: 8, radiuses: [8])),
//        Data(Self.circles(n: 5, radiuses: [10])),
        Data([
            CGPoint(x: -20, y:   0),
            CGPoint(x: -10, y:  15),
            CGPoint(x:   0, y:  10),
            CGPoint(x:  10, y:  15),
            
            CGPoint(x:  20, y:   5),
            CGPoint(x:  25, y: -10),
            CGPoint(x:  10, y: -20),
            CGPoint(x:   0, y: -10),
            CGPoint(x: -15, y: -20),
            
            CGPoint(x: -10, y: -5),
            CGPoint(x:  15, y:  0)
        ]),
        Data([
            CGPoint(x: -15, y:  15),
            CGPoint(x:  15, y:  15),
            CGPoint(x:  15, y: -15),
            CGPoint(x: -15, y: -15),
            
            CGPoint(x:  -5, y:   5),
            CGPoint(x:   5, y:   5),
            CGPoint(x:   5, y:  -5),
            CGPoint(x:  -5, y:  -5)
        ]),
        Data([
            CGPoint(x: -25, y:  15),
            CGPoint(x:  25, y:  15),
            CGPoint(x:  25, y: -15),
            CGPoint(x: -25, y: -15),
            
            CGPoint(x:  -5, y:   5),
            CGPoint(x:   5, y:   5)
        ]),
        Data([
            CGPoint(x: -15, y:  15),
            CGPoint(x:  15, y:  15),
            CGPoint(x:  15, y: -15),
            CGPoint(x: -15, y: -15),
            
            CGPoint(x:   0, y:  10),
            CGPoint(x:  10, y:  0),
            CGPoint(x:   0, y: -10),
            CGPoint(x: -10, y:  0),
            
            CGPoint(x:   0, y:   0)
        ]),
        Data([
            CGPoint(x: -15, y:  15),
            CGPoint(x:  15, y:  15),
            CGPoint(x:  15, y: -15),
            CGPoint(x: -15, y: -15),

            
            CGPoint(x:   0, y:   0)
        ]),
        Data([
            CGPoint(x:   0, y:   6),
            CGPoint(x:   6, y:  -2),
            CGPoint(x:  -6, y:  -2),
            
            CGPoint(x:   0, y:  10),
            CGPoint(x:  10, y:  -4),
            CGPoint(x: -10, y:  -4)
        ]),
        Data(Self.circles(n: 3, radiuses: [5, 10])),
        Data(Self.circles(n: 3, radiuses: [5, 10, 20]))
    ]
    
    
    private static func circles(n: Int, radiuses: [CGFloat], center: CGPoint = .zero) -> [CGPoint] {
        var points = [CGPoint]()
        points.reserveCapacity(n * radiuses.count)

        let dA = 2 * CGFloat.pi / CGFloat(n)

        for radius in radiuses {
            var a: CGFloat = 0
            for _ in 0..<n {
                let x: CGFloat = radius * sin(a)
                let y: CGFloat = radius * cos(a)
                points.append(CGPoint(x: x, y: y) + center)
                a += dA
            }
        }

        return points
    }
   
}
