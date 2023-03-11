//
//  ProfileView.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/09/2022.
//

import SwiftUI

struct UpdateWaveView: View {
    let manager: DataManager
    let waves: [SinusUserData]

    @State private var value = 50.0
    @State private var isEditing = false
    @State private var date = Date()
    @State private var showingAlert = false
    @State private var selection = ""
    @State private var description: String = ""
    @State private var message: String = ""

    var options: [String] {
        return waves.map { "\($0.date_name)" }
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
                    Text("Wave:").foregroundColor(Style.TextOnColoredBackground)

                    Spacer()

                    Picker("", selection: self.$selection) {
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
                    DatePicker(selection: $date, displayedComponents: [.date], label: { Text("Date:") })
                        .colorMultiply(Style.AppColor)
                        .accentColor(Style.TextOnColoredBackground)
                }.padding(.horizontal)

                HStack {
                    Text("Value:")
                    Spacer()
                    Slider(
                        value: self.$value,
                        in: 0...100,
                        step: 1).foregroundColor(.yellow)
                        .frame(width: 220)
                        .accentColor(Style.TextOnColoredBackground)
                }.padding(.horizontal)

                VStack (alignment: .leading){
                    Text("Description:")
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
                    if (self.description.count < 300)
                    {
                        self.message = "Value added!"
                        let update = SinusUpdate(
                            name: self.selection,
                            value: Int(self.value),
                            date: self.date,
                            description: self.description)
                        manager.updateWave(data: update)
                        showingAlert = true
                    }
                    else{
                        self.message = "Description is to long!"
                    }
                }
                .padding()
                .alert(self.description, isPresented: $showingAlert) {
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let waves = [
            SinusUserData(
                id: 1, name: "Name", user_id: 2, date_name: "Target1",
                created_at: "", updated_at: "", deleted_at: "", archived: 0, following: false),
            SinusUserData(
                id: 2, name: "Name2", user_id: 4, date_name: "Target2",
                created_at: "", updated_at: "", deleted_at: "", archived: 0, following: false),
            SinusUserData(
                id: 3, name: "Name3", user_id: 5, date_name: "Target3",
                created_at: "", updated_at: "", deleted_at: "", archived: 0, following: false)
        ]

        UpdateWaveView(manager: DataManager(), waves: waves)
    }
}
