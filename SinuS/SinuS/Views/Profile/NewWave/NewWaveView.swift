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
                    TextField("", text: self.$username)
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

                HStack {
                    Text("Target")
                    Spacer()
                    TextField("", text: self.$targetname)
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
                .foregroundColor(Style.TextOnColoredBackground)

                Button("Add Wave!") {
                    self.manager.addUser(user: self.username, target: self.targetname)
                }
                .padding()
                .foregroundColor(Style.TextOnColoredBackground)
                .alert("User added!", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .foregroundColor(Style.AppColor)
            .background(Style.AppBackground)
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