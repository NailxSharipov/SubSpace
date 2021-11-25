//
//  SceneLogic.swift
//  Shared
//
//  Created by Nail Sharipov on 23.09.2021.
//

import SwiftUI
import SubSpace

final class SceneLogic: ObservableObject {

    @Published var points: [CGPoint] = []
    @Published var isFullConnectivity: Bool = false
    @Published var a: Int = 0 {
        didSet {
            if a == b {
                b = oldValue
            }
        }
    }
    @Published var b: Int = 1 {
        didSet {
            if a == b {
                a = oldValue
            }
        }
    }
    
    private (set) var pageIndex: Int
    private let key = String(describing: SceneLogic.self)
    private let data = SceneData.data
    private var moveIndex: Int?
    private var startPosition: CGPoint = .zero

    struct ViewModel {
        let dots: [DotView.Data]
        let line: EdgeView.Data
        let lines: [EdgeView.Data]
    }
    
    var viewModel: ViewModel {
        let n = points.count

        let adMatrix = AdMatrix(nodes: points)
        var map = ConMap(size: n)
        map.excludeCross(matrix: adMatrix)
        if isFullConnectivity {
            map.excludeChordes()
        }
        
        let nodes = map.nodes
        
        var dots = [DotView.Data]()
        dots.reserveCapacity(n)
        
        for p in points.enumerated() {
            let point = p.element
            let count = nodes[p.offset].pos.sequence.count
            dots.append(DotView.Data(id: p.offset, point: point, name: String("\(p.offset)(\(count))"), color: .gray))
        }
        
        var lines = [EdgeView.Data]()
        
        if let con = map[a, b] {
            for c in 0..<n {
                for d in 0..<n where con[c, d] {
                    let id = adMatrix.index(c, d)
                    lines.append(.init(id: id, points: [points[c], points[d]]))
                }
            }
        }

        return ViewModel(
            dots: dots,
            line: .init(id: .min, points: [points[a], points[b]]),
            lines: lines
        )
    }
    
    init() {
        self.pageIndex = 1
//        self.pageIndex = UserDefaults.standard.integer(forKey: key)
        self.points = self.data[self.pageIndex].points
    }
    
    func onNext() {
        let n = self.data.count
        self.pageIndex = (self.pageIndex + 1) % n
        UserDefaults.standard.set(self.pageIndex, forKey: key)
        self.points = self.data[self.pageIndex].points
    }
    
    func onPrev() {
        let n = self.data.count
        self.pageIndex = (self.pageIndex - 1 + n) % n
        UserDefaults.standard.set(pageIndex, forKey: self.key)
        self.points = self.data[self.pageIndex].points
    }
    
}

extension SceneLogic: DragArea {
    
    func onStart(start: CGPoint, radius: CGFloat) -> Bool {
        let ox = start.x
        let oy = start.y
        self.moveIndex = nil
        var min = radius * radius
        for i in 0..<self.points.count {
            let p = self.points[i]
            let dx = p.x - ox
            let dy = p.y - oy
            let rr = dx * dx + dy * dy
            if rr < min {
                min = rr
                self.moveIndex = i
                self.startPosition = p
            }
        }

        return self.moveIndex != nil
    }
    
    func onMove(delta: CGSize) {
        guard let index = moveIndex else {
            return
        }
        let dx = delta.width
        let dy = delta.height
        points[index] = CGPoint(x: (startPosition.x - dx).rounded(), y: (startPosition.y - dy).rounded())
    }
    
    func onEnd(delta: CGSize) {
        self.onMove(delta: delta)
    }
    
}
