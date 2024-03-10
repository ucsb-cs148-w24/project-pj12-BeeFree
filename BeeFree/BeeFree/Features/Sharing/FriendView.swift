import Foundation
import SwiftUI

struct FriendView: View {
    // Example friend data
    let friendsScreenTime = [
        "Alex": "4 hours, 30 minutes",
        "Jordan": "5 hours, 15 minutes",
        "Sam": "3 hours, 45 minutes"
    ]
    
    var body: some View {
        List(friendsScreenTime.sorted(by: >), id: \.key) { name, time in
            HStack {
                Text(name)
                Spacer()
                Text(time)
            }
        }
        .navigationBarTitle("Friends' Screen Time", displayMode: .inline)
    }
}

struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView()
    }
}
