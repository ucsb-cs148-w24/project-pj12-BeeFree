import SwiftUI

struct FriendView: View {
    @StateObject var viewModel = FriendsViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.friends) { friend in
                HStack {
                    VStack(alignment: .leading) {
                        Text(friend.firstName)
                            .font(.headline)
                        if let screenTime = friend.userScreenTime {
                            Text("\(screenTime.hours) hours, \(screenTime.minutes) minutes")
                                .font(.subheadline)
                        } else {
                            Text("No screen time recorded")
                                .font(.subheadline)
                        }
                    }
                    Spacer()
                    if let screenTime = friend.userScreenTime {
                        let progress = friend.calculateProgress(goalHours: friend.screenTimeGoal ?? 4.0)
                        CircleProgressBar(progress: progress, size: 50)
                    }
                }
            }
            .navigationBarTitle("Friends' Screen Time", displayMode: .inline)
            .onAppear {
                viewModel.fetchFriendsScreenTime()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}





struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView()
    }
}
