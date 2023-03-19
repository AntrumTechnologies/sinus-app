//
//  HistoryItemView.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/03/2023.
//

import SwiftUI

struct HistoryItemView: View {
    let date: String
    let description: String
    
    var body: some View {
        VStack{
            HStack{
                HStack{
                    Image(systemName: "water.waves")
                    Text(date)
                        .foregroundColor(Style.AppColor)
                }
                Spacer()
            }
            
            Spacer()
            
            Text(description)
                .foregroundColor(Style.TextOnColoredBackground)
            
            Divider()
        }.padding(.leading).padding(.trailing).padding(.top)
    }
}

struct HistoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryItemView(date: "", description: "")
    }
}
