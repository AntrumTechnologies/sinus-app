//
//  PersonalView.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/01/2023.
//

import SwiftUI

struct PersonalView: View {
    let gatherer: DataManager
    
    var body: some View {
        VStack {
            ScrollView (.vertical) {
                CreatedRowView(gatherer: gatherer, waves: gatherer.gatherUsers(postfix: "/created"))
                
                ProfileView(manager: gatherer)
                
                NewWaveView(manager: gatherer)
                
            }
            
        }
    }
}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalView(gatherer: DataManager())
    }
}
