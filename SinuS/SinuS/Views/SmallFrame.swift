//
//  SmallFrame.swift
//  SinuS
//
//  Created by Loe Hendriks on 15/09/2022.
//

import SwiftUI

struct SmallFrame: View {
    let header: String
    let text: String
    
    var body: some View {
        VStack {
            Text(header)
                .bold()
            Text(text)
        }
        .foregroundColor(.blue)
        .frame(width: 150, height: 75)
        .background(Color.yellow)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}

struct SmallFrame_Previews: PreviewProvider {
    static var previews: some View {
        SmallFrame(header: "test", text: "test")
    }
}
