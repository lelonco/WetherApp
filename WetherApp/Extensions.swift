//
//  Extensions.swift
//  WetherApp
//
//  Created by Yaroslav on 16.09.2023.
//
import Foundation
import SwiftUI

// Extension for rounded Double to 0 decimals
extension Double {
    func toDegreeString() -> String {
        roundDouble() + "°"
    }
    
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}


// Extension for adding rounded corners to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
