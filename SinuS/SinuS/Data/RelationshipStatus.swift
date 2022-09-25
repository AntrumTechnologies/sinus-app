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
    case Twarrel
    
    /**
        value = 21% - 40%
     */
    case Scharrel
    
    /**
        value = 41% - 60%
     */
    case Kwarrel
    
    /**
        value = 61% - 80%
     */
    case Prela
    
    /**
        value = 81% - 99%
     */
    case Ignorela
    
    /**
        value = 100%
     */
    case Relationship
}

/**
    Converts a graph value to a RelationshipStatus.
 */
public func ValueToRelationshipStatus(value: Int) -> RelationshipStatus {
    if value < 20 {
        return RelationshipStatus.Twarrel
    }
    else if value >= 21 && value <= 40 {
        return RelationshipStatus.Scharrel
    }
    else if value >= 41 && value <= 60 {
        return RelationshipStatus.Kwarrel
    }
    else if value >= 61 && value <= 80 {
        return RelationshipStatus.Prela
    }
    else if value >= 81 && value <= 99 {
        return RelationshipStatus.Ignorela
    }
    else if value == 100 {
        return RelationshipStatus.Relationship
    }
    
    return RelationshipStatus.Twarrel
}
