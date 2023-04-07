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

    var status: RelationshipStatus {
        return valueToRelationshipStatus(value: self.value)
    }

    var text: String {
        switch self.status {
        case .twarrel: return "Twarrel"
        case .scharrel: return "Scharrel"
        case .kwarrel: return "Kwarrel"
        case .prela: return "Prela"
        case .ignorela: return "Ignorela"
        case .relationship: return "Relationship"
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
        .background(Style.AppColor)
        .cornerRadius(5)
        .shadow(radius: 5)
    }
}

struct RelationStatusView_Previews: PreviewProvider {
    static var previews: some View {
        RelationStatusView(value: 50)
    }
}
