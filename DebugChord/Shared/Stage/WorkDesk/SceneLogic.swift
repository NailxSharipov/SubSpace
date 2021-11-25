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
    
    private (set) var pageIndex: Int
    private let key = String(describing: SceneLogic.self)
    private let data = SceneData.data
    private var moveIndex: Int?
    private var startPosition: CGPoint = .zero

    struct ViewModel {
        let dots: [DotView.Data]
        let lines: [EdgeView.Data]
    }
    
    var viewModel: ViewModel {
        let n = points.count
        
        var dots = [DotView.Data]()
        dots.reserveCapacity(n)
        
        for p in points.enumerated() {
            let point = p.element
            dots.append(DotView.Data(id: p.offset, point: point, name: String(p.offset), color: .gray))
        }
        
        let adMatrix = AdMatrix(nodes: points)
        var map = ConMap(size: n)
        map.excludeCross(matrix: adMatrix)
        map.excludeChordes()
        
        var lines = [EdgeView.Data]()
        for a in 0..<n-1 {
            for b in a + 1..<n where map[a, b] != nil {
                let id = adMatrix.index(a, b)
                lines.append(.init(id: id, points: [points[a], points[b]]))
            }
        }

        return ViewModel(
            dots: dots,
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
        guard let index = self.moveIndex else {
            return
        }
        let dx = delta.width
        let dy = delta.height
        self.points[index] = CGPoint(x: self.startPosition.x - dx, y: self.startPosition.y - dy)
    }
    
    func onEnd(delta: CGSize) {
        self.onMove(delta: delta)
    }
    
}
