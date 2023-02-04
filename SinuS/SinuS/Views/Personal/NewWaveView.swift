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
    let manager: DataManager

    @State private var username: String = ""
    @State private var targetname: String = ""
    @State private var showingAlert = false

    /**
        The view.
     */
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create new Wave:")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
                .foregroundColor(Style.ThirdAppColor)

            Spacer()

            VStack {
                HStack {
                    Text("Wave name:")
                    Spacer()
                    TextField("", text: self.$username)
                        .disableAutocorrection(true)
                        .border(Style.FifthAppColor, width: 0.5)
                        .frame(width: 220)
                }.padding(.horizontal).padding(.top)

                HStack {
                    Text("Target:")
                    Spacer()
                    TextField("", text: self.$targetname)
                        .disableAutocorrection(true)
                        .border(Style.FifthAppColor, width: 0.5)
                        .frame(width: 220)
                }.padding(.horizontal)

                Button("Add Wave!") {
                    self.manager.addUser(user: self.username, target: self.targetname)
                }
                .padding()
                .alert("User added!", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .foregroundColor(Style.AppColor)
            .background(Style.SecondAppColor)
            .cornerRadius(5)
            .shadow(radius: 5)
            .padding()

            Spacer()
        }
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewWaveView(manager: DataManager())
    }
}
