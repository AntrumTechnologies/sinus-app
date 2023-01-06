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
        
        if (pointA == 0 && pointB == 0) {
            path.addEllipse(in: CGRect(x: Int(screenWidth - 150) / 2 + 10, y: -5, width: 15, height: 15))
        } else {
            let pointAx = 20
            var pointAy: Int
            let pointBx = Int(screenWidth - 150)
            var pointBy: Int

            if pointB >= pointA {
                pointAy = 0
                pointBy = Int(Double(pointB - pointA) * -1)
            } else {
                pointAy = -100
                pointBy = Int(Double(pointA - pointB) * 0.5)
            }
            path.move(to: CGPoint(x: pointAx, y: pointAy))
            path.addEllipse(in: CGRect(x: pointAx, y: pointAy, width: 15, height: 15))
            path.addLine(
                to: CGPoint(
                    x: pointBx,
                    y: pointBy
                ))
            path.addEllipse(in: CGRect(x: pointBx, y: pointBy - 7, width: 15, height: 15))
        }
        
        

        return path
    }

    var body: some View {
        VStack {
            self.path.stroke(.white, lineWidth: 2.0).padding(.top, 120)
                .frame(maxWidth: .infinity, maxHeight: 300)
        }
        .background(ContentView.SecondAppColor)
        .frame(height: 200)
        .cornerRadius(5)
        .padding(.all)

    }
}

struct FeedWaveGraphView_Previews: PreviewProvider {
    static var previews: some View {
        FeedWaveGraphView(pointA: 0, pointB: 0)
    }
}
