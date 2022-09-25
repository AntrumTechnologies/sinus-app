//
//  Row.swift
//  SinuS
//
//  Created by Loe Hendriks on 05/09/2022.
//

import SwiftUI

/**
    View for the rows in the list of users. Can be expanded with user picture.
 */
struct Row: View {
    var data: SinusUserData
  
    // TODO show last percentage again in the row view.
    /*
    private var percentage: Int {
        if (data.values.count > 0) {
            return data.values.last!
        }
        return 0
    }
    
    private var color: Color {
        if (data.values.count > 1) {
            if (data.values.last! > data.values[data.values.count - 2]) {
                return Color.green
            }
            else if (data.values.last! < data.values[data.values.count - 2]) {
                return Color.red
            }
        }
        return Color.gray
    }*/
    
    /**
        The view.
     */
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .foregroundColor(.red)
            Text(self.data.name)
            Image(systemName: "arrow.right")
                .foregroundColor(.red)
            Text(self.data.date_name)
            Spacer()
            // TODO show last percentage again in the row view.
            //Text(String(self.percentage) + "%").foregroundColor(self.color).bold()
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        let values = generatePoints()
        let labels = getLabels()
        Row(data: SinusUserData(id: 1, name: "Name", date_name: "Target"))
    }
}
