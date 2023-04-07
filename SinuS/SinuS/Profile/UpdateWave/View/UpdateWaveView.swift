//
//  ProfileView.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/09/2022.
//

import SwiftUI

struct UpdateWaveView: View {
    let waves: [SinusUserData]

    @State private var value = 50.0
    @State private var isEditing = false
    @State private var date = Date()
    @State private var showingAlert = false
    @State private var selection = ""
    @State private var description: String = ""
    @State private var message: String = ""
    
    var updateWaveModel = UpdateWaveModel(retrievable: ExternalRestRetriever())
    
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

    /**
        The view.
     */
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "slider.vertical.3")
                    .padding(.leading, 15)
                    .padding(.top, 5)
                Text("Update wave")
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

                HStack {
                    DatePicker(selection: $date, displayedComponents: [.date], label: { Text("Date") })
                        .colorMultiply(Style.AppColor)
                        .accentColor(Style.TextOnColoredBackground)
                }.padding(.horizontal)

                HStack {
                    Text("Value")
                    Spacer()
                    Slider(
                        value: self.$value,
                        in: 0...100,
                        step: 1).foregroundColor(.yellow)
                        .frame(width: 220)
                        .accentColor(Style.TextOnColoredBackground)
                    Spacer()
                    Text("\(Int(self.value))")
                }.padding(.horizontal)

                VStack (alignment: .leading){
                    Text("Description")
                    TextField("", text: self.$description, axis: .vertical)
                        .disableAutocorrection(true)
                        .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1.0)
                        )
        
                }.padding(.horizontal)
                

                Button("Update") {
                    let resign = #selector(UIResponder.resignFirstResponder)
                    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                    
                    if (self.description.count < 300)
                    {
                        Task {
                            do {
                                let update = WaveUpdate(wave_id: self.selectedWave.id, date: self.date, value: Int(self.value), description: self.description)
                                self.message = await self.updateWaveModel.updateWave(update: update)
                                showingAlert = true
                            }
                            catch{
                                print(error)
                            }
                        }
                    }
                    else{
                        self.message = "Description can not be longer than 300 characters"
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
            .shadow(radius: 5)
            .padding()
            .foregroundColor(.white)

            Spacer()

        }
    }
}

struct UpdateWaveView_Previews: PreviewProvider {
    static var previews: some View {
        let waves = [
            SinusUserData(
                id: 1, name: "Name", user_id: 2, date_name: "Target1",
                created_at: "", updated_at: "", deleted_at: "", archived: 0, avatar: "", following: false),
        
        ]

        UpdateWaveView(waves: waves)
    }
}
