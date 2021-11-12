# SwiftUIPercentChart
 
Easily create graphs that calculate percentiles

## How to install this package 

+ Open your project on Xcode
+ Go to Project Tab and select "Package Dependencies"
+ Click "+" and search this package with use git clone url
+ Don't change anything and click Add Package
+ The package will be attached to the targeted application

## How to use this package

```swift
import SwiftUIPercentChart

struct DemoView: View {
    var body: some View {
        PercentChart(data: [20,10,40,30], 
        percentValue: 150, 
        colorData: [], 
        screenRatio: 0.8, 
        backgroundColor: .primary)
    }
}
```
<img src="https://github.com/devmehmetates/SwiftUIPercentChart/blob/main/Sources/Resources/Ads%C4%B1z.gif" width=200 height=100>

## Variables Usage

| Variable | Type | Recommend Usage |
| -------- | ---- | --------------- |
| data | Array(Double) | - |
| percentValue | Double | Enter the percentage rate you want to calculate (If the data exceeds this value, overflow is prevented) |
| colorData | Array(LinearGradient) | If you send an empty array, the default colors are used. (There are no restrictions on the array size) |
| screenRatio | Double | The value dec 0 to 1 must be entered (Proportions the bar according to the screen width of the device)|
| backgroundColor | Color | Sets the color of the bar on the back |

## Note 
It also includes a small touch animation :)
