//
//  ContentView.swift
//  SinuS
//
//  Created by Loe Hendriks on 28/08/2022.
//

import SwiftUI

struct ContentView: View {
    static var AuthenticationToken: String = ""
    static var Cookie: String = ""
    static let AppColor: Color = Color(red: 253/255, green: 81/255, blue: 106/255)
    static let SecondAppColor: Color = Color(red: 255/255, green: 112/255, blue: 134/255)

    var body: some View {
        // MenuView()
        AutenticationStartView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
