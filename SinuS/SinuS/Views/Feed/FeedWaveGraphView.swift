//
//  FeedWaveGraphView.swift
//  SinuS
//
//  Created by Loe Hendriks on 29/12/2022.
//

import SwiftUI

struct FeedWaveGraphView: View {
    var pointA: Int
    var pointB: Int
    let screenWidth = UIScreen.main.bounds.width
    
    private var path: Path {
        var path = Path()
        
        let pointAx = 20
        let pointAy = 0
        let pointBx = Int(screenWidth - 150)
        let pointBy = Int((pointB - pointA) * -1)
        
        path.move(to: CGPoint(x: pointAx, y: pointAy))
        path.addEllipse(in: CGRect(x: pointAx, y: pointAy, width: 10, height: 10))
        path.addLine(
            to: CGPoint(
                x: pointBx,
                y: pointBy
            ))
        path.addEllipse(in: CGRect(x: pointBx, y: pointBy - 7, width: 10, height: 10))
            
        return path
    }
    
    var body: some View {
        VStack{
            self.path.stroke(.white, lineWidth: 2.0).padding(.top, 120)
                .frame(maxWidth: .infinity, maxHeight: 300)
        }
        .background(Color.red.opacity(0.5))
        .frame(height: 140)
        .cornerRadius(5)
        .padding(.all)

    }
}

struct FeedWaveGraphView_Previews: PreviewProvider {
    static var previews: some View {
        FeedWaveGraphView(pointA: 30, pointB: 40)
    }
}
