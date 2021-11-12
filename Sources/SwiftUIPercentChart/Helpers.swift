//
//  SwiftUIView.swift
//  
//
//  Created by Mehmet Ateş on 12.11.2021.
//

import SwiftUI

@available(iOS 13.0, *)
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

@available(iOS 13.0, *)
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

@available(iOS 13.0, *)
class ColorHelper{
    let defaultColors = [LinearGradient(colors: [.red,.orange], startPoint: .top, endPoint: .bottom),LinearGradient(colors: [.blue.opacity(0.8),.blue], startPoint: .top, endPoint: .bottom),LinearGradient(colors: [.purple.opacity(0.8),.purple], startPoint: .top, endPoint: .bottom),LinearGradient(colors: [.green.opacity(0.8),.green], startPoint: .top, endPoint: .bottom)]
}

@available(iOS 13.0, *)
struct TouchGestureViewModifier: ViewModifier {
    let touchBegan: () -> Void
    let touchEnd: (Bool) -> Void
    
    @State private var hasBegun = false
    @State private var hasEnded = false
    
    private func isTooFar(_ translation: CGSize) -> Bool {
        let distance = sqrt(pow(translation.width, 2) + pow(translation.height, 2))
        return distance >= 20.0
    }
    
    func body(content: Content) -> some View {
        content.gesture(DragGesture(minimumDistance: 0)
                            .onChanged { event in
            guard !self.hasEnded else { return }
            
            if self.hasBegun == false {
                self.hasBegun = true
                self.touchBegan()
            } else if self.isTooFar(event.translation) {
                self.hasEnded = true
                self.touchEnd(false)
            }
        }
                            .onEnded { event in
            if !self.hasEnded {
                let success = !self.isTooFar(event.translation)
                self.touchEnd(success)
            }
            self.hasBegun = false
            self.hasEnded = false
        })
    }
}
@available(iOS 13.0, *)
extension View {
    func onTouchGesture(touchBegan: @escaping () -> Void,
                        touchEnd: @escaping (Bool) -> Void) -> some View {
        modifier(TouchGestureViewModifier(touchBegan: touchBegan, touchEnd: touchEnd))
    }
}
