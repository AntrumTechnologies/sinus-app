//
//  HistoryView.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/03/2023.
//

import SwiftUI

private struct HistoryPoint {
    let date: String
    let description: String
    let value: Int
}

struct HistoryView: View {
    let descriptions: [String]
    let dates: [String]
    let values: [Int]
    
    private var history_items : [HistoryPoint]{
        var values: [HistoryPoint]
        values = []
        
        for i in 0..<self.dates.count{
            values.append(HistoryPoint(
                date: self.dates.reversed()[i],
                description: self.descriptions.reversed()[i],
                value: self.values.reversed()[i]))
            
        }
        
        return values
    }
    
    var body: some View {
        VStack (alignment: .leading) {
                HStack {
                    Image(systemName: "calendar")
                        .padding(.leading, 15)
                        .padding(.top, 5)
                    Text("History")
                        .font(.headline)
                        .padding(.top, 5)
                }
                .foregroundColor(Style.AppColor)
            
            VStack(alignment: .leading){
                ForEach(self.history_items, id: \.date) { item in
                    HistoryItemView(
                        date: item.date,
                        description: item.description,
                        value: item.value)
                }
            }
            .background(Style.AppBackground)
            .scrollContentBackground(.hidden)
            .frame(width: 350)
            .cornerRadius(5)
            .padding()
            
        }
        
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(descriptions: [], dates: [], values: [])
    }
}
