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
    
    var body: some View {
        //MenuView()
        AutenticationStartView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
