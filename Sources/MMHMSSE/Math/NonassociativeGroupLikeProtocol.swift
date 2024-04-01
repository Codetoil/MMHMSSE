//  MMHMSSE is a multiplayer-enabled game and physics engine library for curved spaces.
//
//  Copyright (C) 2024 Anthony Michalek
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.

//  You should have received a copy of the GNU Lesser General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.

import Foundation

precedencegroup NonAssociativeAdditionPrecedence {
}

precedencegroup NonAssociativeMultiplicationPrecedence {
    higherThan: AdditionPrecedence
}

infix operator +: NonAssociativeAdditionPrecedence
infix operator *: NonAssociativeMultiplicationPrecedence

public protocol MultiplicitivePartialMagmaProtocol: SetProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self?;
}

public protocol MultiplicitiveMagmaProtocol: MultiplicitivePartialMagmaProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol MultiplicitiveQuasigroupProtocol: MultiplicitiveMagmaProtocol
{
    static func inv(operand: Self) -> Self;
    func inv() -> Self;
}

extension MultiplicitiveQuasigroupProtocol
{
    func inv() -> Self
    {
        return Self.inv(operand: self);
    }
}

public protocol MultiplicitiveUnitalMagmaProtocol: MultiplicitiveMagmaProtocol
{
    static func id() -> Self;
}

public protocol MultiplicitiveLoopProtocol: MultiplicitiveQuasigroupProtocol, MultiplicitiveUnitalMagmaProtocol
{
}



public protocol AdditivePartialMagmaProtocol: SetProtocol
{
    static func +(operand1: Self, operand2: Self) -> Self?;
}

public protocol AdditiveMagmaProtocol: AdditivePartialMagmaProtocol
{
    static func +(operand1: Self, operand2: Self) -> Self;
}

public protocol AdditiveQuasigroupProtocol: AdditiveMagmaProtocol
{
    static prefix func -(operand: Self) -> Self;
}

public protocol AdditiveUnitalMagmaProtocol: AdditiveMagmaProtocol
{
    static func zero() -> Self;
}

public protocol AdditiveLoopProtocol: AdditiveQuasigroupProtocol, AdditiveUnitalMagmaProtocol
{
}
