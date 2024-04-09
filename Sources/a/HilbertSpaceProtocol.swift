//  SwiftAlgebraLib is a library adding abstract algebra to swift.
//
//  Copyright (C) 2024 Anthony Michalek
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.

//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.

import Foundation

public protocol HilbertSpaceProtocol
{
    associatedtype ScalarType: CStarAlgebraProtocol;
    associatedtype OperatorType: CStarAlgebraProtocol;
    
    static prefix func *(operand: Self) -> Self;
    
    static func +(operand1: Self, operand2: Self) -> Self;
    
    static func -(operand1: Self, operand2: Self) -> Self;
    
    static func *(operand1: ScalarType, operand2: Self) -> Self;
    
    static func *(operand1: OperatorType, operand2: Self) -> Self;
    
    static func *(operand1: Self, operand2: ScalarType) -> Self;
    
    static func /(operand1: Self, operand2: ScalarType) -> Self;
    
    static func innerProduct(operand1: Self, operand2: Self) -> ScalarType;
    
    static func ==(operand1: Self, operand2: Self) -> Bool;
    
    func real() -> Self;
    
    func imaginary() -> Self;
    
}


func +=<HilbertSpaceType>(operand1: inout HilbertSpaceType, operand2: HilbertSpaceType) -> HilbertSpaceType where HilbertSpaceType: HilbertSpaceProtocol
{
    operand1 = operand1 + operand2;
    return operand1;
}

func -=<HilbertSpaceType>(operand1: inout HilbertSpaceType, operand2: HilbertSpaceType) -> HilbertSpaceType where HilbertSpaceType: HilbertSpaceProtocol
{
    operand1 = operand1 - operand2;
    return operand1;
}

func *=<HilbertSpaceType>(operand1: inout HilbertSpaceType, operand2: HilbertSpaceType.ScalarType) -> HilbertSpaceType where HilbertSpaceType: HilbertSpaceProtocol
{
    operand1 = operand1 * operand2;
    return operand1;
}

func /=<HilbertSpaceType>(operand1: inout HilbertSpaceType, operand2: HilbertSpaceType.ScalarType) -> HilbertSpaceType where HilbertSpaceType: HilbertSpaceProtocol
{
    operand1 = operand1 / operand2;
    return operand1;
}
