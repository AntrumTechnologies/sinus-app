//
//  CropView.swift
//  SinuS
//
//  Created by Loe Hendriks on 15/04/2023.
//

import SwiftUI
import PhotoSelectAndCrop
import Kingfisher

struct CropView: View {
    let currentUser: Profile
    
    @State private var isEditMode: Bool = true
    @State private var selectedImage: Image?
    @State private var selectedImageData: Data?
    @State private var renderingMode: SymbolRenderingMode = .hierarchical
    @State private var colors: [Color] =
    [
        Style.TextOnColoredBackground,
        Style.AppColor,
        Style.AppBackground
    ]
    @State private var image: ImageAttributes = ImageAttributes(withSFSymbol: "person.crop.circle.fill")
    @StateObject var viewModel: CropView.ViewModel
    
    let size: CGFloat = 220
    let renderingButtonWidth: CGFloat = 167.5
    let renderingButtonHeight: CGFloat = 32
    @Environment(\.presentationMode) var presentationMode
    
    init(viewModel: ViewModel = .init(), user: Profile) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.currentUser = user
    }
    
    var currentAvatar: KFImage {
        let avatar: String = currentUser.avatar ?? "avatars/placeholder.jpg"
        let url: URL = URL(string: "\(LoveWavesApp.baseUrl)/" + avatar)!
        return KFImage.url(url).setProcessor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 100)))
    }
    
    var body: some View {
        let network = NetworkManager()
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "gearshape.fill")
                    .padding(.leading, 15)
                    .padding(.top, 5)
                Text("Edit profile")
                    .font(.headline)
                    .padding(.top, 5)
            }
            .foregroundColor(Style.AppColor)
            
            VStack {
                ImagePane(image: image,
                          isEditMode: $isEditMode,
                          renderingMode: renderingMode,
                          colors: colors)
                    .background(Style.AppColor)
                    .cornerRadius(5)
                    .frame(width: 250, height: 290)
                    .padding()
                
                
                Spacer()
                
                Button("Update Image") {
                    Task {
                        let data = self.image.croppedImage!.jpegData(compressionQuality: 0.8)
                            selectedImageData = data
                             _ = network.uploadFile(
                                fileName: "avatar.jpg",
                                fileData: data)

                        if let uiImage = UIImage(data: data!) {
                                selectedImage = Image(uiImage: uiImage)
                            }
                    }
                }
                .foregroundColor(Style.TextOnColoredBackground)
                .padding()
                
            }
            .frame(width: 300, height: 400)
            .background(Style.AppBackground)
            .foregroundColor(Style.TextOnColoredBackground)
            .cornerRadius(5)
            .padding()
            .foregroundColor(.white)
        }
        .toolbar(.visible, for: ToolbarPlacement.navigationBar)
        .toolbarBackground(Style.AppColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button("Back"){self.presentationMode.wrappedValue.dismiss()})
        
    }
}

extension CropView {
    class ViewModel: ObservableObject {
        @Published var symbolName: String = "person.crop.circle.fill"
        func update(_ image: ImageAttributes) {
            if symbolName != "avatar" {
                image.image = Image(systemName: symbolName.lowercased())
            }
        }
    }
}
