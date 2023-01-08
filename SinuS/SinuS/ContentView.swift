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
