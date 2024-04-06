//
//  File.swift
//  
//
//  Created by Anthony Michalek on 4/1/24.
//

import Foundation

public protocol AssociativeAlgebraOverRingProtocol<RingType>: ModuleProtocol, RingProtocol
{
    static func *(operand1: Self, operand2: Self);
    static func scalarMultiplication(scalar: RingType) -> Self;
}

public protocol AssociativeAlgebraOverFieldProtocol<FieldType>: VectorSpaceProtocol, FieldProtocol, AssociativeAlgebraOverRingProtocol
{
    associatedtype RingType = FieldType;
    static func scalarMultiplication(scalar: FieldType) -> Self;
}

