//
//  SwiftUIView.swift
//  
//
//  Created by Mehmet Ateş on 12.11.2021.
//

import SwiftUI

@available(iOS 15.0, *)
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

@available(iOS 15.0, *)
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

public enum Themes: String, CaseIterable {
    case currency = "Currency"
    case light = "Light"
    case dark = "Dark"
    case love = "Love"
    case ocean = "Ocean"
    case natural = "Natural"
    case colorful = "Colorful"
    case sunset = "Sunset"
    case neon = "Neon"
}

@available(iOS 15.0, *)
public struct ColorThemes {
    public static let currency: [Color] = [
        .init(hex: "007f5f"),
        .init(hex: "2b9348"),
        .init(hex: "55a630"),
        .init(hex: "80b918"),
        .init(hex: "00a3cc"),
        .init(hex: "0081a7"),
        .init(hex: "005082"),
        .init(hex: "993366"),
        .init(hex: "cc3366")
    ]
    
    public static let light: [Color] = [
        .init(hex: "fec5bb"),
        .init(hex: "fcd5ce"),
        .init(hex: "fae1dd"),
        .init(hex: "f8edeb"),
        .init(hex: "e8e8e4"),
        .init(hex: "d8e2dc"),
        .init(hex: "ece4db"),
        .init(hex: "ffd7ba"),
        .init(hex: "fec89a")
    ]
    
    public static let dark: [Color] = [
        .init(hex: "181818"),
        .init(hex: "282828"),
        .init(hex: "404048"),
        .init(hex: "505860"),
        .init(hex: "66707a"),
        .init(hex: "381820"),
        .init(hex: "501820"),
        .init(hex: "502028")
    ]
    
    public static let love: [Color] = [
        .init(hex: "fff0f3"),
        .init(hex: "ffccd5"),
        .init(hex: "ffb3c1"),
        .init(hex: "ff8fa3"),
        .init(hex: "ff758f"),
        .init(hex: "ff4d6d"),
        .init(hex: "a4133c"),
        .init(hex: "800f2f"),
        .init(hex: "590d22")
    ]
    
    public static let ocean: [Color] = [
        .init(hex: "a9d6e5"),
        .init(hex: "89c2d9"),
        .init(hex: "61a5c2"),
        .init(hex: "468faf"),
        .init(hex: "2c7da0"),
        .init(hex: "2a6f97"),
        .init(hex: "014f86"),
        .init(hex: "01497c"),
        .init(hex: "013a63"),
        .init(hex: "012a4a")
    ]
    
    public static let natural: [Color] = [
        .init(hex: "d8f3dc"),
        .init(hex: "b7e4c7"),
        .init(hex: "95d5b2"),
        .init(hex: "74c69d"),
        .init(hex: "52b788"),
        .init(hex: "40916c"),
        .init(hex: "2d6a4f"),
        .init(hex: "1b4332"),
        .init(hex: "081c15")
    ]
    
    public static let colorful: [Color] = [
        .init(hex: "ffadad"),
        .init(hex: "ffd6a5"),
        .init(hex: "fdffb6"),
        .init(hex: "caffbf"),
        .init(hex: "9bf6ff"),
        .init(hex: "a0c4ff"),
        .init(hex: "bdb2ff"),
        .init(hex: "ffc6ff"),
        .init(hex: "fffffc")
    ]
    
    public static let sunset: [Color] = [
        .init(hex: "ff7b00"),
        .init(hex: "ff8800"),
        .init(hex: "ff9500"),
        .init(hex: "ffa200"),
        .init(hex: "ffaa00"),
        .init(hex: "ffb700"),
        .init(hex: "ffd000"),
        .init(hex: "ffea00"),
    ]
    
    public static let neon: [Color] = [
        .init(hex: "f72585"),
        .init(hex: "b5179e"),
        .init(hex: "7209b7"),
        .init(hex: "560bad"),
        .init(hex: "3a0ca3"),
        .init(hex: "3f37c9"),
        .init(hex: "4361ee"),
        .init(hex: "4895ef"),
        .init(hex: "4cc9f0")
    ]
}

@available(iOS 15.0, *)
public extension Color {
    static func getColor(_ colorTheme: [Color], _ index: Int) -> Color {
        if colorTheme.indices.contains(index) {
            return colorTheme[index]
        } else {
            return colorTheme[index % colorTheme.count]
        }
    }
    
    static func themeColor(by index: Int, with theme: Themes) -> Color {
        switch theme {
        case .light:
            return getColor(ColorThemes.light, index)
        case .dark:
            return getColor(ColorThemes.dark, index)
        case .love:
            return getColor(ColorThemes.love, index)
        case .ocean:
            return getColor(ColorThemes.ocean, index)
        case .natural:
            return getColor(ColorThemes.natural, index)
        case .colorful:
            return getColor(ColorThemes.colorful, index)
        case .sunset:
            return getColor(ColorThemes.sunset, index)
        case .neon:
            return getColor(ColorThemes.neon, index)
        case .currency:
            return getColor(ColorThemes.currency, index)
        }
    }
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
