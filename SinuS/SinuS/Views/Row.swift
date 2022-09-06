//
//  Row.swift
//  SinuS
//
//  Created by Loe Hendriks on 05/09/2022.
//

import SwiftUI

// View for the rows in the list of users. Can be expanded with user picture.
struct Row: View {
    var data: SinusData
    
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
            Text(data.sinusName)
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        let values = generatePoints()
        let labels = getLabels()
        Row(data: SinusData(id: 1, values: values, labels: labels, sinusName: "Lukas")).previewLayout(.fixed(width: 300, height: 70))
    }
}
