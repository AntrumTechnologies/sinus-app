//
//  CompareButtonView.swift
//  SinuS
//
//  Created by Loe Hendriks on 17/01/2023.
//

import SwiftUI

struct CompareButtonView: View {
    let data: SinusData

    var body: some View {
        NavigationLink(destination: CompareConfigurationView(originData: self.data), label: {
            HStack {
                Image(systemName: "questionmark.square")
                Text("Compare")
            }
            .frame(width: 150, height: 30)
            .foregroundColor(.white)
            .background(Style.AppColor)
            .cornerRadius(5)
        })
    }
}

struct CompareButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CompareButtonView(
            data: SinusData(
                id: 1, values: [], labels: [],
                descriptions: [], sinusName: "",
                sinusTarget: ""))
    }
}
