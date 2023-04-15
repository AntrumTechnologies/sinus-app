//
//  DetailsView.swift
//  SinuS
//
//  Created by Loe Hendriks on 15/04/2023.
//

import SwiftUI
import PhotoSelectAndCrop

struct DetailsView: View {
    @Environment(\.dismiss) var dismiss
    let image: ImageAttributes
    let themeColor: Color
    var body: some View {
        ZStack {
            themeColor
                .ignoresSafeArea(.all)
            VStack (spacing: 10) {
                Text("ImageAttributes")
                    .font(.title)
                Divider()
                image.image.resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(3)
                    .background(Circle().foregroundColor(.white))
                Text(".image")
                if (image.originalImage != nil) {
                    Image(uiImage: image.originalImage!)
                        .resizable()
                        .scaledToFit()
                        .padding(3)
                        .border(Color.white, width: 4)
                        .frame(width: 300)
                    Text(".originalImage")
                }
                Group {
                    Text(".scale: \(image.scale)")
                    Text("xWidth: \(image.xWidth)")
                    Text("yHeight: \(image.yHeight)")
                }
                Spacer()
            }
            .foregroundColor(.white)
            .font(.title3)
            .padding()
        }
    }
}
