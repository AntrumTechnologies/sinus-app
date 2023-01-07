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

    @State private var username: String = ""
    @State private var value = 50.0
    @State private var isEditing = false
    @State private var date = Date()
    @State private var showingAlert = false

    /**
        The view.
     */
    var body: some View {
        VStack(alignment: .leading) {
            Text("Update Wave:")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
                .foregroundColor(ContentView.AppColor)

            Spacer()
            
            VStack {
                HStack {
                    Text("Wave name:")
                    Spacer()
                    TextField("", text: self.$username)
                        .disableAutocorrection(true)
                        .border(Color.white, width: 0.5)
                        .frame(width: 220)
                }.padding(.horizontal).padding(.top)

                HStack {
                    DatePicker(selection: $date, displayedComponents: [.date], label: { Text("Date:") })
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
                    let update = SinusUpdate(name: self.username, password: "", value: Int(self.value), date: self.date)
                    manager.sendData(data: update)
                    showingAlert = true
                }
                .padding()
                .alert("Value added!", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .background(ContentView.AppColor)
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
        ProfileView(manager: DataManager())
    }
}
