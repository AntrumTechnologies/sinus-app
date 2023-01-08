//
//  EditProfileView.swift
//  SinuS
//
//  Created by Loe Hendriks on 08/01/2023.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    let gatherer: DataManager

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var name: String = ""
    @State private var email: String = ""

    init(gatherer: DataManager) {
        self.gatherer = gatherer
        _email = State(initialValue: self.currentEmail)
        _name = State(initialValue: self.currentName)
    }

    private var image: Image {
        if self.selectedImageData == nil {
            return Image("Placeholder")
        }

        let uiImage = UIImage(data: self.selectedImageData!)!
        return Image(uiImage: uiImage)
    }

    var currentUser: UserData? {
        return self.gatherer.getCurrentUser()?.success
    }

    var currentName: String {
        if currentUser == nil {
            return "Unknown"
        }

        return currentUser!.name
    }

    var currentEmail: String {
        if currentUser == nil {
            return "Unknown"
        }

        return currentUser!.email
    }

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "water.waves")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .padding(.bottom)
                Text("Edit Profile")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .padding(.bottom)
                Spacer()
            }
            .background(Style.AppColor)

            Spacer()

            VStack {
                Text("Avatar:")

                HStack {
                    Spacer()

                    self.image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(Style.ThirdAppColor, lineWidth: 4)
                                .shadow(radius: 10)
                        }

                    Spacer()

                    PhotosPicker(
                           selection: $selectedItem,
                           matching: .images,
                           photoLibrary: .shared()) {
                               Label("Select a photo", systemImage: "photo")
                                   .frame(width: 150, height: 30)
                                   .background(.white)
                                   .foregroundColor(Style.ThirdAppColor)
                                   .cornerRadius(5)
                                   .shadow(radius: 5)
                           }
                           .onSubmit {
                               // do nothing
                           }
                           .onChange(of: selectedItem) { newItem in
                               Task {
                                   if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                       selectedImageData = data
                                   }
                               }
                           }

                    Spacer()
                }

                HStack {
                    Text("Name:")
                    Spacer()
                    TextField(self.currentName, text: self.$name)
                        .disableAutocorrection(true)
                        .border(Color.white, width: 0.5)
                        .frame(width: 220)
                }.padding(.horizontal).padding(.top)

                HStack {
                    Text("Email:")
                    Spacer()
                    TextField(self.currentEmail, text: self.$email)
                        .disableAutocorrection(true)
                        .border(Color.white, width: 0.5)
                        .frame(width: 220)
                }.padding(.horizontal).padding(.top)

            }
            .frame(height: 300)
            .background(Style.AppColor)
            .cornerRadius(5)
            .shadow(radius: 5)
            .padding()
            .foregroundColor(.white)

            Button("Save") {

            }
            .foregroundColor(Style.ThirdAppColor)
            .font(.headline)
            .shadow(radius: 5)

            Spacer()
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(gatherer: DataManager())
    }
}
