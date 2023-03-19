//
//  SmallFrame.swift
//  SinuS
//
//  Created by Loe Hendriks on 15/09/2022.
//

import SwiftUI

/**
    Small frame view in the style of the application.
    Used by the LineChart.
 */
struct SmallFrame: View {
    let header: String
    let text: String

    /**
        The view.
     */
    var body: some View {
        VStack {
            Text(header)
                .bold()
            Text(text)
        }
        .foregroundColor(Style.TextOnColoredBackground)
        .frame(width: 150, height: 75)
        .background(Style.AppBackground)
        .cornerRadius(5)
        .shadow(radius: 5)
    }
}

struct SmallFrame_Previews: PreviewProvider {
    static var previews: some View {
        SmallFrame(header: "test", text: "test")
    }
}
