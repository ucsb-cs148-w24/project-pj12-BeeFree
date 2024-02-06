import SwiftUI

struct ScreenTimeGoalView: View {
    @Binding var isDarkMode : Bool
    let percents: [Double] = [0.4, 0.5, 0.1]
    var body: some View {
        ZStack {
           RectangleSection(isDarkMode: $isDarkMode, height: 200)
            VStack {
//                Text("Today's Screen Time")
                HStack {
                    Spacer()
                    // get some percents from firebase
                    // use function to convert percent[] to trim[]
                    // pass in trim instead
                    
                    let trims = calculateTrims(inputPercents: percents)
                    CircleProgressBar(trims: trims)
                    
                    
                }
                .padding([.leading, .trailing], 50)
            }
        }
    }
}

#Preview {
    ScreenTimeGoalView(isDarkMode: .constant(false))
}
