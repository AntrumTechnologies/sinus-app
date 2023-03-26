//
//  CompareConfigurationView.swift
//  SinuS
//
//  Created by Loe Hendriks on 26/03/2023.
//

import SwiftUI

struct CompareConfigurationView: View {
    let originData: SinusData
    @ObservedObject var configurationModel = CompareConfigurationModel()
    @State public var compareSelection = ""
    @State public var differenceSelection = "Merged"
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Image(systemName: "gear")
                    .padding(.leading, 15)
                    .padding(.top, 5)
                Text("Comparison options")
                    .font(.headline)
                    .padding(.top, 5)
            }
            .foregroundColor(Style.AppColor)
            .padding(.top)
            
            Spacer()
            
            VStack{
                HStack {
                    Text("Select wave to compare to:")
                    Spacer()
                }.padding()
                
                Picker("Select a wave to compare to", selection: $compareSelection) {
                    ForEach(self.configurationModel.compareOptions, id: \.self) {
                        Text($0)
                    }
                }
                .frame(width: 300, height: 40)
                .background(Style.AppColor)
                .cornerRadius(5)
                .shadow(radius: 10)
                
                HStack {
                    Text("View options:")
                    Spacer()
                }
                .padding()
                
                Picker("Select a view option", selection: $differenceSelection) {
                    ForEach(self.configurationModel.differenceOptions, id: \.self) {
                        Text($0)
                    }
                }
                .frame(width: 300, height: 40)
                .background(Style.AppColor)
                .cornerRadius(5)
                .shadow(radius: 10)
                
                Text("In the comparison wave graph the dates are replaced by index points to give a better overview for comparing. Both waves will start at the same index point.")
                    .padding()
                
                Spacer()
                
                NavigationLink(destination: CompareView(originData: self.originData, compareName: compareSelection, merged: self.differenceSelection == "Merged"), label: {
                    HStack {
                        Image(systemName: "questionmark.square")
                        Text("Compare")
                    }
                    .frame(width: 150, height: 30)
                    .foregroundColor(.white)
                    .background(Style.AppColor)
                    .cornerRadius(5)
                    .shadow(radius: 10)
                })
                .padding()
            }
            .frame(width: 350)
            .background(Style.AppBackground)
            .foregroundColor(Style.TextOnColoredBackground)
            .cornerRadius(5)
            .shadow(radius: 5)
            .padding()
            .foregroundColor(.white)
            .toolbar(.visible, for: ToolbarPlacement.navigationBar)
            .toolbarBackground(Style.AppColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            
        }
        .task{
            await self.configurationModel.reload()
            self.compareSelection = self.configurationModel.compareOptions.first!
        }
        .refreshable{
            await self.configurationModel.reload()
        }
    }
}

struct CompareConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        CompareConfigurationView(originData: SinusData(id: 1, values: [], labels: [], descriptions: [], sinusName: "", sinusTarget: ""))
    }
}
