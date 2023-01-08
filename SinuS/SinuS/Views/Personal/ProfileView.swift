//
//  ProfileView.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/09/2022.
//

import SwiftUI

/**
    View showing the user profile,.
    This view allows the user to update their graph.
 */
struct ProfileView: View {
    let manager: DataManager
    let waves: [SinusUserData]

    @State private var value = 50.0
    @State private var isEditing = false
    @State private var date = Date()
    @State private var showingAlert = false
    @State private var selection = ""

    var options: [String] {
        return waves.map { "\($0.date_name)" }
    }

    /**
        The view.
     */
    var body: some View {
        VStack(alignment: .leading) {
            Text("Update Wave:")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
                .foregroundColor(Style.ThirdAppColor)

            Spacer()

            VStack {
                HStack {
                    Text("Wave:")

                    Spacer()

                    Picker("", selection: self.$selection) {
                        ForEach(options, id: \.self) {
                            Text($0)
                        }
                    }
                    .cornerRadius(5)
                    .shadow(radius: 10)
                }.padding(.horizontal).padding(.top)

                HStack {
                    DatePicker(selection: $date, displayedComponents: [.date], label: { Text("Date:") })
                        .colorScheme(.dark)
                }.padding(.horizontal)

                HStack {
                    Text("Value:")
                    Spacer()
                    Slider(
                        value: self.$value,
                        in: 0...100,
                        step: 1).foregroundColor(.yellow)
                        .frame(width: 220)
                }.padding(.horizontal)

                HStack {
                    Text("\(Int(self.value))")
                }.font(.system(size: 50))

                Button("Update") {
                    let update = SinusUpdate(name: self.selection, value: Int(self.value), date: self.date)
                    manager.sendData(data: update)
                    showingAlert = true
                }
                .padding()
                .alert("Value added!", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .background(Style.AppColor)
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
            SinusUserData(id: 1, name: "Name", user_id: 2, date_name: "Target1", created_at: "", updated_at: "", deleted_at: "", archived: 0),
            SinusUserData(id: 2, name: "Name2", user_id: 4, date_name: "Target2", created_at: "", updated_at: "", deleted_at: "", archived: 0),
            SinusUserData(id: 3, name: "Name3", user_id: 5, date_name: "Target3", created_at: "", updated_at: "", deleted_at: "", archived: 0)
        ]

        ProfileView(manager: DataManager(), waves: waves)
    }
}
