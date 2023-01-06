//
//  SinusUpdate.swift
//  SinuS
//
//  Created by Loe Hendriks on 12/09/2022.
//

import Foundation

/**
    Struct holding all parameters required to update a sinus graph
 */
public struct SinusUpdate {

    /**
        The name of the user.
     */
    let name: String

    /**
        The password of the user.
     */
    let password: String

    /**
        The new point for the graph.
     */
    let value: Int

    /**
         The date corrosponding to the value.
     */
    let date: Date
}
