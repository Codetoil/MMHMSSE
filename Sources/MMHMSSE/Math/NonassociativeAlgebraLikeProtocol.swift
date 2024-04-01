//
//  File.swift
//  
//
//  Created by Anthony Michalek on 4/1/24.
//

import Foundation

infix operator *: NonAssociativeMultiplicationPrecedence

public protocol NonassociativeAlgebraOverFieldProtocol<FieldType>: VectorSpaceProtocol
{
    static func *(operand1: Self, operand2: Self);
}

public protocol NonassociativeAlgebraWithUnitOverFieldProtocol<FieldType>: VectorSpaceProtocol, NonassociativeAlgebraOverFieldProtocol
{
    static func id() -> Self;
}

public protocol LieAlgebraProtocol<FieldType>: NonassociativeAlgebraOverFieldProtocol
{
}
