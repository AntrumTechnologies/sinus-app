//
//  SearchView.swift
//  SinuS
//
//  Created by Loe Hendriks on 18/04/2023.
//

import SwiftUI

struct SearchView: View {
    
    @State private var filter: String = ""
    @StateObject var searchModel = SearchModel(retrievable: ExternalRestRetriever())
    
    var body: some View {
        VStack {
            HStack{
                TextField(" Filter", text: self.$filter, axis: .vertical)
                    .disableAutocorrection(true)
                    .cornerRadius(5)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1.0)
                    )
                    .padding()
                
                Button{
                    let resign = #selector(UIResponder.resignFirstResponder)
                    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                    Task{
                        await self.searchModel.reload(filter: self.filter)
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                }
                
            }
            .frame(width: 360)
            .foregroundColor(Style.TextOnColoredBackground)
            .background(Style.AppBackground)
            .cornerRadius(5)
            .foregroundColor(.white)
            .padding()
            
            Spacer()
            
            List(self.searchModel.filteredUsers) { user in
                NavigationLink(
                    destination: WaveView(user: user),
                    label: {
                        SearchItemView(user: user)
                    })
            }.scrollContentBackground(.hidden)
            
        }
        .task {
            await self.searchModel.reload(filter: self.filter)
         }
         .refreshable {
             await self.searchModel.reload(filter: self.filter)
         }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
