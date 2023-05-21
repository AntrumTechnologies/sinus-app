//
//  NewUserView.swift
//  SinuS
//
//  Created by Loe Hendriks on 15/09/2022.
//

import SwiftUI

/**
    View which allows users to create new graphs.
 */
struct NewWaveView: View {
    let currentUsername: String

    @State private var waveName: String = ""
    @State private var showingAlert = false
    @State private var message: String = ""
    
    @StateObject var newWaveModel = NewWaveModel(retrievable: ExternalRestRetriever())
    /**
        The view.
     */
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "square.and.pencil")
                    .padding(.leading, 15)
                    .padding(.top, 5)
                Text("Create new wave")
                    .font(.headline)
                    .padding(.top, 5)
            }.foregroundColor(Style.AppColor)

            Spacer()

            VStack {
                HStack {
                    Text("Wave name")
                    Spacer()
                    TextField("", text: self.$waveName)
                        .disableAutocorrection(true)
                        .frame(width: 200)
                        .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1.0)
                        )
                }
                .padding(.horizontal)
                .padding(.top)
                .foregroundColor(Style.TextOnColoredBackground)

                Button("Add wave") {
                    let resign = #selector(UIResponder.resignFirstResponder)
                    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                    
                    Task {
                        do {
                            self.message = await self.newWaveModel.createNewWave(name: self.waveName)
                            showingAlert = true
                            self.waveName = ""
                        }
                        catch {
                            print(error)
                        }
                        
                    }
                }
                .padding()
                .foregroundColor(Style.TextOnColoredBackground)
                .alert(self.message, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .foregroundColor(Style.AppColor)
            .background(Style.AppBackground)
            .cornerRadius(5)
            .padding()

            Spacer()
        }
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewWaveView(currentUsername: "")
    }
}
