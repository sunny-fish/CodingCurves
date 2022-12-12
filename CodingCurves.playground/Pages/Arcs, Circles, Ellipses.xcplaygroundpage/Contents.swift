//: [Previous](@previous)

import SwiftUI
import PlaygroundSupport

struct Circle: View {
    
    let width: CGFloat = 600
    let height: CGFloat = 600
    var cx: CGFloat { get { width / 2 } }
    var cy: CGFloat { get { height / 2 } }
    let radius: CGFloat = 250
    
    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    let startPoint = CGPoint(x: cx + cos(0) * radius, y: cy + sin(0) * radius)
                    path.move(to: startPoint)
                    for t in stride(from: 0, to: CGFloat.pi * 2, by: 0.01) {
                        let point = CGPoint(x: cx + cos(t) * radius, y: cy + sin(t) * radius)
                        path.addLine(to: point)
                    }
                    path.closeSubpath()
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }
    
}

struct CircleFunction: View {
    
    let width: CGFloat = 600
    let height: CGFloat = 600

    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    path.circle(x: width / 2, y: height / 2, r: 200)
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }

}

struct ArcFunction: View {
    
    let width: CGFloat = 600
    let height: CGFloat = 600

    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    path.arc(x: width / 2, y: height / 2, r: 200, start: 3.5, end: 0.5, anticlockwise: true)
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }

}

struct SegmentFunction: View {
    
    let width: CGFloat = 600
    let height: CGFloat = 600

    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    path.segment(x: width / 2, y: height / 2, r: 200, start: 3.5, end: 0.5, anticlockwise: true)
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }

}

struct SectorFunction: View {
    
    let width: CGFloat = 600
    let height: CGFloat = 600

    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    path.sector(x: width / 2, y: height / 2, r: 200, start: 2.5, end: 4.5, anticlockwise: false)
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }

}

struct PolygonFunction: View {
    
    let width: CGFloat = 600
    let height: CGFloat = 600

    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    path.polygon(x: width / 2, y: height / 2, r: 200, sides: 5, rotation: 0.5)
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }

}

struct PolygonPattern: View {
    
    let width: CGFloat = 600
    let height: CGFloat = 600

    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    var angle: CGFloat = 0
                    for r:CGFloat in stride(from: 5, to: 255, by: 10) {
                        path.polygon(x: width / 2, y: height / 2, r: r, sides: 5, rotation: angle)
                        angle += 0.05
                    }
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }

}

struct EllipseFunction: View {
    
    let width: CGFloat = 600
    let height: CGFloat = 600

    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                        path.ellipse(x: width / 2, y: height / 2, rx: 250, ry: 150)
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }

}

struct CircleOfCirclesFunction: View {
    
    let width: CGFloat = 600
    let height: CGFloat = 600

    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    path.circleOfCircles(x: width / 2, y: height / 2, r: 200)                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }

}



extension Path {
    
    mutating func circle(x: CGFloat, y: CGFloat, r: CGFloat) {
        arc(x: x, y: y, r: r, start: 0, end: 2 * .pi, anticlockwise: false)
    }
    
    mutating func arc(x: CGFloat, y: CGFloat, r: CGFloat, start: CGFloat, end: CGFloat, anticlockwise: Bool) {
        var vEnd = anticlockwise ? start : end
        var vStart = anticlockwise ? end : start
        while (vEnd < vStart) {
            vEnd += 2 * .pi
        }
        let res = 4 / r
        let startPoint = CGPoint(x: x + cos(vStart) * r, y: y + sin(vStart) * r)
        self.move(to: startPoint)
        for t in stride(from: vStart, to: vEnd, by: res) {
            let point = CGPoint(x: x + cos(t) * r, y: y + sin(t) * r)
            self.addLine(to: point)
        }
    }
    
    mutating func segment(x: CGFloat, y: CGFloat, r: CGFloat, start: CGFloat, end: CGFloat, anticlockwise: Bool) {
        arc(x: x, y: y, r: r, start: start, end: end, anticlockwise: anticlockwise)
        self.closeSubpath()
    }

    mutating func sector(x: CGFloat, y: CGFloat, r: CGFloat, start: CGFloat, end: CGFloat, anticlockwise: Bool) {
        arc(x: x, y: y, r: r, start: start, end: end, anticlockwise: anticlockwise)
        self.addLine(to: CGPoint(x: x, y: y))
        self.closeSubpath()
    }
    
    mutating func polygon(x: CGFloat, y: CGFloat, r: CGFloat, sides: CGFloat, rotation: CGFloat = 0) {
        let res = .pi * 2 / sides
        let startPoint = CGPoint(x: x + cos(rotation) * r, y: y + sin(rotation) * r)
        self.move(to: startPoint)
        for i in stride(from: 0, to: CGFloat.pi * 2,  by: res) {
            let point = CGPoint(x: x + cos(i + rotation) * r, y: y + sin(i + rotation) * r)
            self.addLine(to: point)
        }
        self.closeSubpath()
    }
    
    mutating func ellipse(x: CGFloat, y: CGFloat, rx: CGFloat, ry: CGFloat) {
        let res = 4 / max(rx, ry)
        let startPoint = CGPoint(x: x + cos(0) * rx, y: y + sin(0) * ry)
        self.move(to: startPoint)
        for t in stride(from: 0, to: CGFloat.pi * 2,  by: res) {
            let point = CGPoint(x: x + cos(t) * rx, y: y + sin(t) * ry)
            self.addLine(to: point)
        }
        self.closeSubpath()

    }
    
    mutating func circleOfCircles(x cx: CGFloat, y cy: CGFloat, r: CGFloat) {
        let res = CGFloat.pi * 2 / 20
        for t in stride(from: 0, to: CGFloat.pi * 2, by: res) {
            let x = cx + cos(t) * r
            let y = cy + sin(t) * r
            self.circle(x: x, y: y, r: 20)
        }
    }
}

PlaygroundPage.current.setLiveView(CircleOfCirclesFunction())

//: [Next](@next)
