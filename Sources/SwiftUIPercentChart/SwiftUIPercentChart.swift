import SwiftUI


@available(iOS 13.0, *)
/// Creates a horizontal chart that calculates percentile slices
public struct SwiftUIPercentChart : View {
    private var data: Array<Double>
    private var percentValue : Double
    private var applyPercent : Double{
        if self.data.reduce(0, +) > percentValue{
            return self.data.reduce(0, +)
        }else{
            return self.percentValue
        }
    }
    private var colorData : Array<LinearGradient>
    private var applyColor : Array<LinearGradient>{
        if self.colorData.isEmpty{
            return ColorHelper().defaultColors
        }else{
            return colorData
        }
    }
    @State var valueScale = CGFloat(1)
    private var screenSize = UIScreen.main.bounds
    private var screenRatio : Double
    private var backgroundColor : Color
    // Required variables
    public init(data:Array<Double> , percentValue : Double , colorData : Array<LinearGradient> , screenRatio : Double, backgroundColor : Color){
        // Data of the graphics
        self.data = data
        // The value that determines the percentage of the bar
        self.percentValue = percentValue
        // The value set the chart colors
        self.colorData = colorData
        // The value for setting the width of the chart according to the device screen (among to 0 - 1)
        self.screenRatio = screenRatio
        // The value set the backgorund bar color
        self.backgroundColor = backgroundColor
    }
    public var body: some View{
        ZStack(alignment:.leading){
            Rectangle()
                .foregroundColor(self.backgroundColor.opacity(0.3))
                .frame(width: screenSize.width * self.screenRatio, height: 20)
                .cornerRadius(16)
            HStack(spacing:0){
                if #available(iOS 15.0, *){
                    if self.data.count > 0 {
                        if self.data.count == 1{
                            Rectangle()
                                .frame(width: calWidth(value: self.data[0]) , height: 20)
                                .cornerRadius(16)
                                .foregroundStyle(self.applyColor[0])
                            
                        }else{
                            Rectangle()
                                .frame(width: calWidth(value: self.data[0]), height: 20)
                                .cornerRadius(16,corners:[.topLeft,.bottomLeft])
                                .foregroundStyle(self.applyColor[0])
                            ForEach(0..<self.data.count) {
                                a in
                                if a == 0{
                                    
                                }
                                else if a == self.data.count - 1 {
                                    Rectangle()
                                        .frame(width: calWidth(value: self.data[a]), height: 20)
                                        .cornerRadius(16,corners:[.topRight,.bottomRight])
                                        .foregroundStyle(self.applyColor[a % self.applyColor.count])
                                }
                                else{
                                    Rectangle()
                                        .frame(width: calWidth(value: self.data[a]), height: 20)
                                        .foregroundStyle(self.applyColor[a % self.applyColor.count])
                                    
                                }
                            }
                        }
                    }
                }else
                {
                    Text("Make the app version ios 15")
                }
            }.scaleEffect(self.valueScale)
                .onTouchGesture(
                    touchBegan: { withAnimation { self.valueScale = 1.2 } },
                    touchEnd: { _ in withAnimation { self.valueScale = 1.0 } }
                )
        }
    }
    func calWidth(value : Double) -> Double{
        return (value * (screenSize.width * self.screenRatio))/applyPercent
    }
}

#if DEBUG
struct SwiftUIPercentChart_Previews : PreviewProvider {
    @available(iOS 13.0, *)
    static var previews: some View {
        SwiftUIPercentChart(data: [10,20,30], percentValue: 100 , colorData: [] ,screenRatio: 0.8,backgroundColor: .primary)
    }
}
#endif
