//
//  CompareButtonView.swift
//  SinuS
//
//  Created by Loe Hendriks on 17/01/2023.
//

import SwiftUI

struct CompareButtonView: View {
    let gatherer: DataManager
    let data: SinusData

    var body: some View {
        NavigationLink(destination: CompareView(initialData: data, gatherer: self.gatherer), label: {
            HStack {
                Image(systemName: "questionmark.square")
                Text("Compare")
            }
            .frame(width: 150, height: 30)
            .foregroundColor(.white)
            .background(Style.TextOnColoredBackground)
            .cornerRadius(5)
            .shadow(radius: 10)
        })
    }
}

struct CompareButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CompareButtonView(
            gatherer: DataManager(),
            data: SinusData(
                id: 1, values: [], labels: [],
                descriptions: [], sinusName: "",
                sinusTarget: ""))
    }
}
