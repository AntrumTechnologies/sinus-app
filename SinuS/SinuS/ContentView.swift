//
//  ContentView.swift
//  SinuS
//
//  Created by Loe Hendriks on 28/08/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Gather data.
        let data = DataGatherer.CollectData()
        
        // Show data as list.
        GraphList(charts: data)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
