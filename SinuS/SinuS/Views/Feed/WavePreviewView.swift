//
//  WavePreviewView.swift
//  SinuS
//
//  Created by Loe Hendriks on 01/03/2023.
//

import SwiftUI

struct WavePreviewView: View {
    let percentage: Int
    let description: String
    let hasData: Bool

    private var color: Color {
        if self.percentage > 0 {
            return .green
        } else if self.percentage < 0 {
            return .red
        }
        return .gray
    }

    private var icon: Image {
        if self.percentage > 0 {
            return Image(systemName: "arrowtriangle.up.fill")
        } else if self.percentage < 0 {
            return Image(systemName: "arrowtriangle.down.fill")
        }
        return Image(systemName: "square.fill")
    }

    var body: some View {
        VStack {
            if (self.hasData) {
                VStack{
                    Text(self.description).foregroundColor(Style.AppColor)
                    
                }
                
                HStack {
                    VStack{
                        Wave(strength: 10, frequency: 20)
                            .stroke(self.color, lineWidth: 5)
                    }
                    .frame(height: 75)
                    
                    HStack {
                        self.icon
                            .foregroundColor(.white)
                        Text(String(self.percentage) + "%").foregroundColor(.white).bold()
                        
                    }
                    .frame(width: 75, height: 50)
                    .background(self.color)
                    .cornerRadius(5)
                    .shadow(radius: 10)
                    
                }
            }
            else{
                VStack (alignment: .center){
                    Text("Has created a wave but has no dates yet..")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Style.AppColor)
                }.frame(width: 300)
                
            }

        }
    }
}

struct WavePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        WavePreviewView(percentage: 10, description: "", hasData: true)
    }
}
