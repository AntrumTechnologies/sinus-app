//
//  LegendView.swift
//  SinuS
//
//  Created by Loe Hendriks on 26/03/2023.
//

import SwiftUI

struct LegendView: View {
    let whiteName: String
    let darkName: String
    
    var body: some View {
        HStack {
            Image(systemName: "swatchpalette")
                .padding(.leading, 15)
                .padding(.top, 5)
            Text("Legend")
                .font(.headline)
                .padding(.top, 5)
        }.foregroundColor(Style.AppColor)
        
        VStack {
            HStack {
                VStack {
                    Color.white
                }
                .frame(width: 30, height:30)
                .border(.black)
                
                Text("Wave: \(self.whiteName)")
                
                Spacer()
            }.padding()
            
            HStack {
                VStack {
                    Style.TextOnColoredBackground
                }
                .frame(width: 30, height:30)
                .border(.black)
                    
                Text("Wave: \(self.darkName)")
                
                Spacer()
            }.padding()
        }
        .frame(width: 350)
        .foregroundColor(Style.TextOnColoredBackground)
        .background(Style.AppBackground)
        .cornerRadius(5)
        .shadow(radius: 10)
        .foregroundColor(.white)
        .padding()
    }
}

struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        LegendView(whiteName: "", darkName: "")
    }
}
