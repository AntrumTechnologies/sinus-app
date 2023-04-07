//
//  EditProfileView.swift
//  SinuS
//
//  Created by Loe Hendriks on 08/01/2023.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct EditProfileView: View {
    let currentUser: Profile

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var selectedImageData: Data?
    @State private var name: String = ""
    @State private var email: String = ""

    init(currentUser: Profile) {
        self.currentUser = currentUser
        _name = State(initialValue: self.currentUser.name)
        _email = State(initialValue: self.currentUser.email)
    }

    private var image: Image {
        if self.selectedImageData == nil {
            return Image("Placeholder")
        }

        let uiImage = UIImage(data: self.selectedImageData!)!
        return Image(uiImage: uiImage)
    }

    var currentAvatar: KFImage {
        let avatar: String = currentUser.avatar ?? "avatars/placeholder.jpg"
        let url: URL = URL(string: "https://lovewaves.antrum-technologies.nl/" + avatar)!
        return KFImage.url(url).setProcessor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 100)))
    }

    var body: some View {
        let network = NetworkManager()

        VStack {
            Spacer()

            VStack {
                HStack {
                    Spacer()

                    self.currentAvatar
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(Style.TextOnColoredBackground, lineWidth: 4)
                                .shadow(radius: 10)
                        }

                    Spacer()

                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .not(.videos),
                        photoLibrary: .shared()) {
                            Label("Select new avatar", systemImage: "photo")
                                .frame(width: 180, height: 30)
                                .background(.white)
                                .foregroundColor(Style.TextOnColoredBackground)
                                .cornerRadius(5)
                                .shadow(radius: 5)
                        }
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                     _ = network.uploadFile(
                                        fileName: selectedItem?.itemIdentifier ?? "avatar.jpg",
                                        fileData: data)

                                    if let uiImage = UIImage(data: data) {
                                        selectedImage = Image(uiImage: uiImage)
                                    }
                                }
                            }
                    }

                    Spacer()
                }

                HStack {
                    Text("Name")
                    Spacer()
                    TextField(self.currentUser.name, text: self.$name)
                        .disableAutocorrection(true)
                        .frame(width: 220)
                        .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1.0)
                        )
                }.padding(.horizontal).padding(.top)

                HStack {
                    Text("Email")
                    Spacer()
                    TextField(self.currentUser.email, text: self.$email)
                        .disableAutocorrection(true)
                        .frame(width: 220)
                        .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1.0)
                        )
                }.padding(.horizontal).padding(.top)

            }
            .frame(height: 300)
            .background(Style.AppBackground)
            .foregroundColor(Style.TextOnColoredBackground)
            .cornerRadius(5)
            .shadow(radius: 5)
            .padding()
            .foregroundColor(.white)

            Button("Save") {

            }
            .foregroundColor(Style.AppColor)
            .font(.headline)
            .shadow(radius: 5)

            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Style.AppColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    HStack {
                        Text("Edit profile")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .padding(.bottom)
                    }
                }
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(currentUser: Profile.init(id: 0, name: "Jan", email: "Jan@Jan.nl", email_verified_at: "", created_at: "", updated_at: "", avatar: ""))
    }
}
