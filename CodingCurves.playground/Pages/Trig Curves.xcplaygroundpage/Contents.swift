//: [Previous](@previous)
 
//: Each example in the blog post is implemented as a separate View struct. At the end of this file replace the view used in PlaygroundPage.current.setLiveView() with any variation to see that curve.


import SwiftUI
import PlaygroundSupport

//for i in 0..<628 {
//    var doubleValue = Double(i) / 100.0
//    print(sin(doubleValue))
//}
//for i in 0..<628 {
//    var doubleValue = Double(i) / 10.0
//    print(tan(doubleValue))
//}


struct SineWave: View {
    
    let width: CGFloat = 800
    let height: CGFloat = 500
    
    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    path.move(to: CGPoint(x: 0, y: height/2))
                    for x in 0..<Int(width) {
                        let y = height / 2.0 + sin(CGFloat(x))
                        let point = CGPoint(x: CGFloat(x), y: y)
                        path.addLine(to: point)
                    }
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }
    
}

struct AmplitudeSineWave: View {
    
    let width: CGFloat = 800
    let height: CGFloat = 500
    var amplitude: CGFloat {
        get {
            height * 0.45
        }
    }
    
    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    path.move(to: CGPoint(x: 0, y: height/2))
                    for x in 0..<Int(width) {
                        let y = height / 2.0 + sin(CGFloat(x)) * amplitude
                        let point = CGPoint(x: CGFloat(x), y: y)
                        path.addLine(to: point)
                    }
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }
    
}

struct FrequencySineWave: View {
    
    let width: CGFloat = 800
    let height: CGFloat = 500
    var amplitude: CGFloat {
        get {
            height * 0.45
        }
    }
    let freq: CGFloat = 1.0
    
    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    path.move(to: CGPoint(x: 0, y: height/2))
                    for x in 0..<Int(width) {
                        let y = height / 2.0 + sin(CGFloat(x) / width * CGFloat.pi * 2 * freq) * amplitude
                        let point = CGPoint(x: CGFloat(x), y: height - y)
                        path.addLine(to: point)
                    }
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }
    
}

struct WavelengthSineWave: View {
    
    let width: CGFloat = 800
    let height: CGFloat = 500
    var amplitude: CGFloat {
        get {
            height * 0.45
        }
    }
    let wavelength: CGFloat = 100.0
    
    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    path.move(to: CGPoint(x: 0, y: height/2))
                    for x in 0..<Int(width) {
                        let y = height / 2.0 + sin(CGFloat(x) / wavelength * CGFloat.pi * 2) * amplitude
                        let point = CGPoint(x: CGFloat(x), y: height - y)
                        path.addLine(to: point)
                    }
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }
    
}

struct ResolutionSineWave: View {
    
    let width: CGFloat = 800
    let height: CGFloat = 500
    var amplitude: CGFloat {
        get {
            height * 0.45
        }
    }
    let freq: CGFloat = 3
    let res: CGFloat = 20
    
    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    path.move(to: CGPoint(x: 0, y: height/2))
                    for x in stride(from: 0, to: Int(width), by: Int(res)) {
                        let y = height / 2.0 + sin(CGFloat(x) / width * CGFloat.pi * 2 * freq) * amplitude
                        let point = CGPoint(x: CGFloat(x), y: height - y)
                        path.addLine(to: point)
                    }
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }
    
}

struct CosineWave: View {
    
    let width: CGFloat = 800
    let height: CGFloat = 500
    var amplitude: CGFloat {
        get {
            height * 0.45
        }
    }
    let freq: CGFloat = 1.0
    
    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    path.move(to: CGPoint(x: 0, y: height/2))
                    for x in 0..<Int(width) {
                        let y = height / 2.0 + cos(CGFloat(x) / width * CGFloat.pi * 2 * freq) * amplitude
                        let point = CGPoint(x: CGFloat(x), y: height - y)
                        path.addLine(to: point)
                    }
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }
    
}

struct FunctionExample: View {
    
    let width: CGFloat = 800
    let height: CGFloat = 500
    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    path.sinewave(x0: 100, y0: 100, x1: 700, y1: 400, freq: 10, amp: 40)
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }
    
}

extension Path {
    
    mutating func sinewave(x0: CGFloat, y0: CGFloat, x1: CGFloat, y1: CGFloat, freq: CGFloat, amp: CGFloat) {
        let dx = x1 - x0
        let dy = y1 - y0
        let dist = sqrt(dx * dx + dy * dy)
        let angle = atan2(dy, dx)
        for x in 0..<Int(dist) {
            let y: CGFloat = sin(CGFloat(x) / dist * freq * CGFloat.pi * 2) * amp
            let point = CGPoint(x: CGFloat(x), y: y)
            self.addLine(to: point)
        }
        self = self.applying(CGAffineTransform(translationX: x0, y: y0))
        self = self.applying(CGAffineTransform(rotationAngle: angle))

    }
}

struct FrequencyTangentGraph: View {
    
    let width: CGFloat = 800
    let height: CGFloat = 500
    var amplitude: CGFloat  = 10
    let freq: CGFloat = 1.0
    
    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path() { path in
                    path.move(to: CGPoint(x: 0, y: height/2))
                    for x in 0..<Int(width) {
                        let y = height / 2.0 + tan(CGFloat(x) / width * CGFloat.pi * 2 * freq) * amplitude
                        let point = CGPoint(x: CGFloat(x), y: height - y)
                        path.addLine(to: point)
                    }
                },
                with: .color(.black),
                lineWidth: 1)
        }
        .frame(width: width, height: height)
        .background(Color.white)
    }
    
}


PlaygroundPage.current.setLiveView(SineWave())

//: [Next](@next)
