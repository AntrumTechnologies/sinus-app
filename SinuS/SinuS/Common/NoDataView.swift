//
//  NoDataView.swift
//  SinuS
//
//  Created by Loe Hendriks on 18/03/2023.
//

import SwiftUI

struct NoDataView: View {
    let scale : CGFloat
    let useLogo: Bool
    
    var body: some View {
        VStack {
            if (self.useLogo) {
                HStack {
                    Image("Logo_no_bg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 55 * self.scale)
                        .foregroundColor(.white)
                }
                .frame(width: 200, height: 150)
                .cornerRadius(5)
            }
            
            Text("Has created a wave but has no dates yet")
                .foregroundColor(.white)
                .padding(.bottom)
                .font(.system(size: 20 * self.scale))
        }
        .frame(width: 350 * self.scale)
        .background(Style.AppColor)
        .cornerRadius(5)
        .padding()
    }
}

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView(scale: 1, useLogo: true)
    }
}
