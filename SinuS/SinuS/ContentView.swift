//
//  ContentView.swift
//  SinuS
//
//  Created by Loe Hendriks on 28/08/2022.
//

import SwiftUI
import SwiftKeychainWrapper

struct ContentView: View {
    static var AuthenticationToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""
    static let AppColor: Color = Color(red: 253/255, green: 81/255, blue: 106/255)
    static let SecondAppColor: Color = Color(red: 255/255, green: 112/255, blue: 134/255)
    @State private var pushActive = true

    var body: some View {
        NavigationView {
            if KeychainWrapper.standard.string(forKey: "bearerToken") == nil {
                AuthenticationStartView()
            } else {
                MenuView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
