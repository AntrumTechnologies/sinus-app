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
struct FeedWaveView: View {
    var data: SinusUserData
    var pointA: Int
    var pointB: Int
  

    private var percentage: Int {
        return pointB - pointA
    }

    private var color: Color {
        if (self.percentage > 0) {
            return .green
        }
        else if (self.percentage < 0)
        {
            return .red
        }
        return .gray
    }
    
    private var icon: Image {
        if (self.percentage > 0) {
            return Image(systemName: "arrowtriangle.up.fill")
        }
        else if (self.percentage < 0)
        {
            return Image(systemName: "arrowtriangle.down.fill")
        }
        return Image(systemName: "square.fill")
    }
    
    /**
        The view.
     */
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Image(systemName: "person.fill")
                    .foregroundColor(.red)
                Text(self.data.name)
                Image(systemName: "arrow.right")
                    .foregroundColor(.red)
                Text(self.data.date_name)
                Spacer()
                
                Spacer()
                self.icon
                    .foregroundColor(self.color)
                Text(String(self.percentage) + "%").foregroundColor(self.color).bold()
                Spacer()
            }
            
            Spacer()
            FeedWaveGraphView(pointA: self.pointA, pointB: self.pointB)
            Spacer()
        }
        .frame(height: 200)
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        FeedWaveView(data: SinusUserData(id: 1, name: "Name", date_name: "Target", created_at: "", updated_at: "", deleted_at: ""), pointA: 30, pointB: 42)
    }
}
