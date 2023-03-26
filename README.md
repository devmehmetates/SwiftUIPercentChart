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
        SwiftUIPercentChart(data: [50, 40, 30, 20, 30, 50, 30, 10, 20, 50], percentValue: 350, theme: .ocean)
            .frame(width: screenSize.width * 0.7, height: 10)
    }
}
```

## Demo Images
<div>
<img width="270" alt="Screenshot 2023-03-26 at 6 46 47 PM" src="https://user-images.githubusercontent.com/74152011/227787917-0f400044-df9e-4797-90cd-addb27d90752.png">
<img width="272.5" alt="Screenshot 2023-03-26 at 6 48 48 PM" src="https://user-images.githubusercontent.com/74152011/227787907-ba66250b-5a36-4f71-adc2-0b145f4902be.png">
</div>
