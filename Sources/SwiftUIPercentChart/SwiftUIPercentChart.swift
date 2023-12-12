import SwiftUI

/// Creates a horizontal chart that calculates percentile slices
public struct SwiftUIPercentChart: View {
    private var data: [Double] = []
    private var percentValue: Double = 0
    private var colors: [Color] = []

    public init(data: [Double] = [], percentValue: Double? = nil, theme: Themes = .dark) {
        self.commonInit(
            data,
            percentValue: calculatePercent(percentValue),
            colors: ColorThemes.getColors(by: theme)
        )
    }
    
    public init(data: [Double] = [], percentValue: Double? = nil, theme: [Color]?) {
        commonInit(
            data,
            percentValue: calculatePercent(percentValue),
            colors: theme ?? ColorThemes.getColors(by: .currency)
        )
    }
    
    private mutating func commonInit(_ data: [Double], percentValue: Double, colors: [Color]) {
        self.data = data
        self.percentValue = percentValue
        self.colors = colors
    }
    
    private func calculatePercent(_ percentValue: Double?) -> Double {
        guard let percentValue else { return 0 }
        let sumOfDatas = Double(data.reduce(0, +))
        return max(sumOfDatas, percentValue)
    }
    
    public var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                ForEach(Array(zip(data.indices, data)), id: \.0) { index, value in
                    createRectange(by: index, proxy: proxy)
                }
                
                if percentValue > data.reduce(0, +) {
                    Spacer()
                }
            }.background(.quaternary)
                .clipShape(
                    RoundedRectangle(cornerRadius: 16)
                )
        }
    }
    
    @ViewBuilder private func createRectange(by index: Int, proxy: GeometryProxy) -> some View {
        if let cellRect = getCellRectShape(by: index) {
            Rectangle()
                .cornerRadius(cellRadius(by: index), corners: cellRect)
                .foregroundColor(Color.getColor(colors, index))
                .frame(width: cellWidth(by: index, proxy.size.width))
        } else {
            Rectangle()
                .foregroundColor(Color.getColor(colors, index))
                .frame(width: cellWidth(by: index, proxy.size.width))
        }
    }
    
    private func getCellRectShape(by index: Int) -> UIRectCorner? {
        if index == .zero {
            return [.topLeft, .bottomLeft]
        } else if index == data.count - 1 {
            return [.topRight, .bottomRight]
        }
        
        return nil
    }
    
    private func cellCapacity(by index: Int) -> Double {
        return (data[index] * 100) / percentValue
    }
    
    private func cellWidth(by index: Int, _ width: CGFloat) -> Double {
        if data[index] == 0 {
            return 0
        }
        return (cellCapacity(by: index) * width) / 100
    }
    
    private func cellRadius(by index: Int) -> Double {
        return 500 / cellCapacity(by: index)
    }
}

#if DEBUG
struct SwiftUIPercentChart_Previews : PreviewProvider {
    static var previews: some View {
        let screenSize = UIScreen.main.bounds
        
        VStack {
            SwiftUIPercentChart(data: [1, 2, 25], percentValue: 10, theme: [.red, .blue, .green])
                .frame(width: screenSize.width * 0.7, height: 10)
            
            SwiftUIPercentChart(data: [1, 0, 0], theme: .currency)
                .frame(width: screenSize.width * 0.7, height: 10)
            
            ForEach(Themes.allCases, id: \.self) { theme in
                VStack(alignment: .leading) {
                    SwiftUIPercentChart(data: [50, 40, 30, 20, 30, 50, 30, 10, 20, 50], percentValue: 350, theme: theme)
                        .frame(width: screenSize.width * 0.7, height: 10)
                    Text(theme.rawValue)
                        .bold()
                }.padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
            }
        }
    }
}
#endif
