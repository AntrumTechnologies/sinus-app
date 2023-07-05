//
//  ButtonStyle.swift
//  SinuS
//
//  Created by Loe Hendriks on 03/06/2023.
//

import SwiftUI

struct ButtonStyle: View {
    let text: String
    let width: CGFloat
    
    var body: some View {
        VStack{
            Text(self.text)
        }
        .frame(width: self.width, height: 30)
        .foregroundColor(.white)
        .background(Style.AppColor)
        .cornerRadius(5)
    }
}

struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyle(text: "", width: 100)
    }
}
