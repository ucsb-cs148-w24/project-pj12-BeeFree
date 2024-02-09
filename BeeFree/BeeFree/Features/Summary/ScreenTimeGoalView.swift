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
                    
//                    let trims = calculateTrims(inputPercents: percents)
                    CircleProgressBar().scaleEffect(CGSize(width: 0.8, height: 0.8))
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    VStack{
                        Text("Hi, Karan!").font(.headline).foregroundStyle(.white)
                       
                        Text("You've used 67% of your total screentime goal.").font(.system(size:17, weight: .regular, design: .default)).foregroundStyle(.white).multilineTextAlignment(.center)
                      
                    }.padding([.top, .bottom], 30)
                        .frame(width:130, height:200)
                    
                    
                    Spacer()
                    
                    
                }
                .padding([.leading, .trailing, .bottom], 15)
            }
        }
    }
}

#Preview {
    ScreenTimeGoalView(isDarkMode: .constant(false))
}
