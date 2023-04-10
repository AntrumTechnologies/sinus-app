//
//  DeleteWaveView.swift
//  SinuS
//
//  Created by Loe Hendriks on 26/03/2023.
//

import SwiftUI

struct DeleteWaveView: View {
    let waves: [SinusUserData]
    
    @State private var selection = ""
    @State private var message: String = ""
    @State private var showingAlert = false
    
    var deleteWaveModel = DeleteWaveModel(retrievable: ExternalRestRetriever())
    
    var options: [String] {
        return waves.map { "\($0.date_name)" }
    }
    
    var selectedWave: SinusUserData {
        if (self.selection == "") {
            return self.waves.first!
        }
            
        var wave = self.waves.filter{ $0.date_name == self.selection }.first
        return wave!
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "trash")
                    .padding(.leading, 15)
                    .padding(.top, 5)
                Text("Delete wave")
                    .font(.headline)
                    .padding(.top, 5)
            }.foregroundColor(Style.AppColor)
            
            Spacer()
            
            VStack {
                HStack {
                    Text("Wave").foregroundColor(Style.TextOnColoredBackground)
                    
                    Spacer()
                    
                    Picker("Choose...", selection: self.$selection) {
                        ForEach(options, id: \.self) {
                            Text($0)
                        }
                    }
                    .colorMultiply(Style.AppColor)
                    .accentColor(Style.TextOnColoredBackground)
                    .cornerRadius(5)
                    .shadow(radius: 10)
                }.padding(.horizontal).padding(.top)
                
                Button("Delete") {
                    let resign = #selector(UIResponder.resignFirstResponder)
                    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                    
                    Task {
                        do {
                            self.message = await self.deleteWaveModel.deleteWave(wave_id: self.selectedWave.id)
                            showingAlert = true
                        }
                        catch{
                            print(error)
                        }
                    }
                }
                .padding()
                .alert(self.message, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .background(Style.AppBackground)
            .foregroundColor(Style.TextOnColoredBackground)
            .cornerRadius(5)
            .padding()
            .foregroundColor(.white)
            
            Spacer()
            
        }
    }
}

struct DeleteWaveView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteWaveView(waves: [])
    }
}
