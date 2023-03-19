//
//  Wave.swift
//  SinuS
//
//  Created by Loe Hendriks on 01/03/2023.
//

import SwiftUI

struct Wave: Shape {

    // how high our waves should be
    var strength: Double

    // how frequent our waves should be
    var frequency: Double

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()

        // calculate some important values up front
        let width = Double(rect.width)
        let height = Double(rect.height)
        let midWidth = width / 2
        let midHeight = height / 2

        // split our total width up based on the frequency
        let wavelength = width / frequency

        // start at the left center
        path.move(to: CGPoint(x: 0, y: midHeight))

        // now count across individual horizontal points one by one
        for xValue in stride(from: 0, through: width, by: 1) {
            // find our current position relative to the wavelength
            let relativeX = xValue / wavelength

            // calculate the sine of that position
            let sine = sin(relativeX)

            // multiply that sine by our strength to determine final offset, then move it down to the middle of our view
            let yValue = strength * sine + midHeight

            // add a line to here
            path.addLine(to: CGPoint(x: xValue, y: yValue))
        }

        return Path(path.cgPath)
    }
}
