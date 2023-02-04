//
//  TextView.swift
//  SinuS
//
//  Created by Loe Hendriks on 17/01/2023.
//

import SwiftUI

struct TextView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.headline)
            .padding(.leading, 15)
            .padding(.top, 5)
            .foregroundColor(Style.ThirdAppColor)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(text: "")
    }
}
