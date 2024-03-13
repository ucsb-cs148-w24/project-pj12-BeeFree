//
//  ProfileSheetView.swift
//  BeeFree
//
//  Created by Karankumar Mageswaran on 1/20/24.
//


import DeviceActivity
import ManagedSettings
import FamilyControls
import SwiftUI

struct AsyncImage<Placeholder: View>: View {
    @State private var data: Data?

    private let url: URL
    private let placeholder: Placeholder
    private let frameSize: CGSize

    init(url: URL, frameSize: CGSize, @ViewBuilder placeholder: () -> Placeholder) {
        self.url = url
        self.frameSize = frameSize
        self.placeholder = placeholder()
    }

    var body: some View {
        if let data = data, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: frameSize.width, height: frameSize.height)
        } else {
            placeholder
                .frame(width: frameSize.width, height: frameSize.height)
                .onAppear(perform: loadImage)
        }
    }

    private func loadImage() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error downloading image: \(error)")
                } else if let data = data, UIImage(data: data) != nil {
                    self.data = data
                } else {
                    print("Invalid image data or format")
                }
            }
        }.resume()
    }
}


struct ProfileSheetView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Binding var isDarkMode: Bool
    @Binding var userInfo: Userinfo? 
    @State var isScreenTimeGoalPresented: Bool = false
    @EnvironmentObject var store: ManagedSettingsStore
    @EnvironmentObject var model: BeeFreeModel
    

    var body: some View {
        NavigationStack {
            VStack {
                // Title Stack
                ZStack {
                    HStack {
                        Text("Account")
                            .bold()
                            .font(.title2)
                            .padding(EdgeInsets(top: 32, leading: 16, bottom: 8, trailing: 16))
                    }
                    HStack {
                        Text("Done")
                            .onTapGesture {
                                dismiss()
                            }
                            .bold()
                            .font(.title3)
                            .foregroundColor(Color("AccentColor"))
                            .padding(EdgeInsets(top: 32, leading: 16, bottom: 8, trailing: 16))
                        Spacer()
                    }
                }
                // Settings
                Form {
                    Section(content: {
                        HStack {
                            profileImageView()
                            userInfoView()
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                    })
                    Section(content: {
                        HStack{
                            Button(action: {self.isScreenTimeGoalPresented.toggle()}) {
                                Text("Change Screen Time Goal").font(.title3)
                            }
                            .sheet(isPresented: $isScreenTimeGoalPresented) {
                                // Create a sheet view to create a limit
                                ScreenTimeGoalSheetView(isDarkMode: $isDarkMode, goal: model.getScreenTimeGoal())
                                    .environmentObject(BeeFreeModel.shared)
                                    .environmentObject(store)
                            }
                        }
                    })
//                    Section(content: {
//                        HStack{
//                            Text("Privacy").font(.title3)
//                        }
//                        HStack{
//                            Text("Notifications").font(.title3)
//                        }
//                    })
//                    Section(content: {
//                        HStack{
//                            Toggle(isOn: $isDarkMode) {
//                                Text("Dark Mode").font(.title3)
//                            }
//                        }
//                    })
//                    Section(content: {
//                        HStack{
//                            Text("Sign Out")
//                                .font(.title3)
//                                .foregroundColor(.red)
//                        }
//                    })
                }
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func profileImageView() -> some View {
        Group {
            if let imageUrl = userInfo?.googleProfileImageUrl, let url = URL(string: imageUrl) {
                AsyncImage(url: url, frameSize: CGSize(width: 48, height: 48), placeholder: { defaultImageView() })
            } else {
                defaultImageView()
            }
        }
        .foregroundColor(Color("DynamicGray")) // Apply the modifier to the Group
    }


       private func defaultImageView() -> some View {
           Image(systemName: "person.circle.fill")
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 48, height: 48)
       }

       @ViewBuilder
       private func userInfoView() -> some View {
           VStack {
               Text(userInfo?.displayName ?? "Unknown name").font(.title3).frame(maxWidth: .infinity, alignment: .leading)
               Text(userInfo?.email ?? "Unknown email").frame(maxWidth: .infinity, alignment: .leading)
           }
       }
   }


//#Preview {
//    ProfileSheetView(isDarkMode: .constant(false))
//}



struct ProfileSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyUserInfo = Userinfo(userID: "123", email: "goodExample@example.com", displayName: "Big Boy", firstName: "Boy", friends: [])

        ProfileSheetView(isDarkMode: .constant(false), userInfo: .constant(dummyUserInfo))
            .previewLayout(.sizeThatFits)
    }
}
