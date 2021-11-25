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
        
//        print("points: \(points)")
        
        let adMatrix = AdMatrix(nodes: points)
        var map = ConMap(size: n)
//        map.excludeCross(matrix: adMatrix)
//        map.excludeChordes()

//        let contour = map.findContour()
        let contourSet = Set(adMatrix.excludeMiddles())
//        let contourSet = Set(contour)
        
        var dots = [DotView.Data]()
        dots.reserveCapacity(n)
        
        for p in points.enumerated() {
            let point = p.element
            let color: Color = contourSet.contains(p.offset) ? .gray : .red
            
            dots.append(DotView.Data(id: p.offset, point: point, name: String(p.offset), color: color))
        }

        let nodes = map.nodes
        
        var lines = [EdgeView.Data]()

        var i = 0
        
//        if var a = contour.last {
//            for b in contour {
//                lines.append(.init(id: i, points: [points[a], points[b]], lineWidth: 2, color: .black))
//                a = b
//                i += 1
//            }
//        }
        
        for node in nodes {
            let a = node.index
            for b in node.pos.sequence where !(contourSet.contains(a) && contourSet.contains(b)) {
                lines.append(.init(id: i, points: [points[a], points[b]], lineWidth: 1, color: .orange))
                i += 1
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
