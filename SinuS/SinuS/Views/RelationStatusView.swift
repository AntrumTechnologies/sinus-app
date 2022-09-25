//
//  RelationStatusView.swift
//  SinuS
//
//  Created by Loe Hendriks on 25/09/2022.
//

import SwiftUI

/**
    View showing the status of the relationship, using the RelationshipStatus enum.
 */
struct RelationStatusView: View {
    let value: Int
    
    var status : RelationshipStatus {
        return ValueToRelationshipStatus(value: self.value)
    }
    
    var text : String {
        switch self.status {
        case .Twarrel: return "Twarrel"
        case .Scharrel: return "Scharrel"
        case .Kwarrel: return "Kwarrel"
        case .Prela: return "Prela"
        case .Ignorela: return "Ignorela"
        case .Relationship: return "Relationsip"
        }
    }
    
    /**
        The view.
     */
    var body: some View {
        HStack {
            Text("Status:")
            Text(self.text).bold()
        }
        .foregroundColor(.white)
        .frame(width: 250, height: 50)
        .background(Color.red.opacity(0.5))
        .cornerRadius(5)
        .shadow(radius: 5)
    }
}
    

struct RelationStatusView_Previews: PreviewProvider {
    static var previews: some View {
        RelationStatusView(value: 50)
    }
}
