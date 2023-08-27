import SwiftUI

@available(iOS 15.0, *)
/// Creates a horizontal chart that calculates percentile slices
public struct SwiftUIPercentChart: View {
    private var data: [Double]
    private var percentValue: Double
    private var theme: Themes
    
    public init(data: [Double] = [], percentValue: Double? = nil, theme: Themes = .dark) {
        self.data = data
        self.percentValue = percentValue ?? 0 < Double(data.reduce(0, +)) ? Double(data.reduce(0, +)) : percentValue ?? Double(data.reduce(0, +))
        self.theme = theme
    }
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.gray.opacity(0.2))
                HStack(spacing: 0) {
                    ForEach(Array(zip(data.indices, data)), id: \.0) { index, value in
                        if index == 0 {
                            Rectangle()
                                .cornerRadius(cellRadius(by: index), corners: [.topLeft, .bottomLeft])
                                .foregroundColor(.themeColor(by: index, with: theme))
                                .frame(width: cellWidth(by: index, proxy.size.width))
                        } else if index == data.count - 1 {
                            Rectangle()
                                .cornerRadius(cellRadius(by: index), corners: [.topRight, .bottomRight])
                                .foregroundColor(.themeColor(by: index, with: theme))
                                .frame(width: cellWidth(by: index, proxy.size.width))
                        } else {
                            Rectangle()
                                .foregroundColor(.themeColor(by: index, with: theme))
                                .frame(width: cellWidth(by: index, proxy.size.width))
                        }
                    }
                    
                    if percentValue > data.reduce(0, +) {
                        Spacer()
                    }
                }
            }.mask {
                RoundedRectangle(cornerRadius: 16)
            }
        }
    }
    
    private func cellCapacity(by index: Int) -> Double {
        return (data[index] * 100) / percentValue
    }
    
    private func cellWidth(by index: Int, _ width: CGFloat) -> Double {
        return  (cellCapacity(by: index) * width) / 100
    }
    
    private func cellRadius(by index: Int) -> Double {
        return 500 / cellCapacity(by: index)
    }
}

#if DEBUG
@available(iOS 15.0, *)
struct SwiftUIPercentChart_Previews : PreviewProvider {
    static var previews: some View {
        let screenSize = UIScreen.main.bounds
        
        VStack {
            SwiftUIPercentChart(data: [20, 30, 40], theme: .currency)
                .frame(width: screenSize.width * 0.7, height: 10)
            
            ForEach(Themes.allCases, id: \.self) { theme in
                if #available(iOS 15.0, *) {
                    VStack(alignment: .leading) {
                        SwiftUIPercentChart(data: [50, 40, 30, 20, 30, 50, 30, 10, 20, 50], percentValue: 350, theme: theme)
                            .frame(width: screenSize.width * 0.7, height: 10)
                        Text(theme.rawValue)
                            .bold()
                    }.padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                } else {
                    VStack(alignment: .leading) {
                        SwiftUIPercentChart(data: [50, 40, 30, 20, 30, 50, 30, 10, 20, 50], percentValue: 350, theme: theme)
                            .frame(width: screenSize.width * 0.7, height: 10)
                        Text(theme.rawValue)
                    }
                }
            }
        }
    }
}
#endif
