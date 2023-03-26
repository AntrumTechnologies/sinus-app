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
    let value: Int
    
    var body: some View {
        VStack{
            HStack{
                HStack{
                    Text(date)
                        .foregroundColor(Style.TextOnColoredBackground)
                }
                
                Spacer()
                
                HStack{
                    Text(String(value))
                        .foregroundColor(Style.AppColor)
                }
            }
            
            Spacer()
            
            Text(description)
                .foregroundColor(Style.AppColor)
            
            Divider()
        }.padding(.leading).padding(.trailing).padding(.top)
    }
}

struct HistoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryItemView(date: "1970-01-01", description: "Foobar", value: 10)
    }
}
