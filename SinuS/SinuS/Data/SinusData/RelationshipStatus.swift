//
//  RelationshipStatus.swift
//  SinuS
//
//  Created by Loe Hendriks on 25/09/2022.
//

import Foundation

/**
    Enum holding the values of the different statusus of a relationship.
 */
public enum RelationshipStatus {
    /**
        value = 0% - 20%
     */
    case twarrel

    /**
        value = 21% - 40%
     */
    case scharrel

    /**
        value = 41% - 60%
     */
    case kwarrel

    /**
        value = 61% - 80%
     */
    case prela

    /**
        value = 81% - 99%
     */
    case ignorela

    /**
        value = 100%
     */
    case relationship
}

/**
    Converts a graph value to a RelationshipStatus.
 */
public func valueToRelationshipStatus(value: Int) -> RelationshipStatus {
    if value < 20 {
        return RelationshipStatus.twarrel
    } else if value >= 21 && value <= 40 {
        return RelationshipStatus.scharrel
    } else if value >= 41 && value <= 60 {
        return RelationshipStatus.kwarrel
    } else if value >= 61 && value <= 80 {
        return RelationshipStatus.prela
    } else if value >= 81 && value <= 99 {
        return RelationshipStatus.ignorela
    } else if value == 100 {
        return RelationshipStatus.relationship
    }

    return RelationshipStatus.twarrel
}
