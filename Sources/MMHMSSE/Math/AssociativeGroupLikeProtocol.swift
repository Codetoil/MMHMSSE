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

infix operator +: AdditionPrecedence
infix operator *: MultiplicationPrecedence

public protocol MultiplicitiveSemigroupoidProtocol: MultiplicitivePartialMagmaProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self?;
}

public protocol MultiplicitiveSmallCatagoryProtocol: MultiplicitiveSemigroupoidProtocol
{
    static func id() -> Self;
}

public protocol MultiplicitiveGroupoidProtocol: MultiplicitiveSmallCatagoryProtocol
{
    static func inv(operand: Self) -> Self;
    func inv() -> Self;
}

extension MultiplicitiveGroupoidProtocol
{
    func inv() -> Self
    {
        return Self.inv(operand: self);
    }
}

public protocol MultiplicitiveSemigroupProtocol: MultiplicitiveMagmaProtocol, MultiplicitiveSemigroupoidProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol MultiplicitiveAssociativeQuasigroupProtocol: MultiplicitiveSemigroupProtocol, MultiplicitiveQuasigroupProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol MultiplicitiveMonoidProtocol: MultiplicitiveSemigroupProtocol, MultiplicitiveUnitalMagmaProtocol, MultiplicitiveSmallCatagoryProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol MultiplicitiveCommutativeMonoidProtocol: MultiplicitiveMonoidProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol MultiplicitiveGroupProtocol: MultiplicitiveLoopProtocol, MultiplicitiveAssociativeQuasigroupProtocol, MultiplicitiveMonoidProtocol, MultiplicitiveGroupoidProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol MultiplicitiveAbelianGroupProtocol: MultiplicitiveGroupProtocol, MultiplicitiveCommutativeMonoidProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}


public protocol AdditiveSemigroupoidProtocol: AdditivePartialMagmaProtocol
{
    static func +(operand1: Self, operand2: Self) -> Self?;
}

public protocol AdditiveSmallCatagoryProtocol: AdditiveSemigroupoidProtocol
{
    static func zero() -> Self;
}

public protocol AdditiveGroupoidProtocol: AdditiveSmallCatagoryProtocol
{
    static prefix func -(operand: Self) -> Self;
}

public protocol AdditiveSemigroupProtocol: AdditiveMagmaProtocol, AdditiveSemigroupoidProtocol
{
    static func +(operand1: Self, operand2: Self) -> Self;
}

public protocol AdditiveAssociativeQuasigroupProtocol: AdditiveSemigroupProtocol, AdditiveQuasigroupProtocol
{
    static func +(operand1: Self, operand2: Self) -> Self;
}

public protocol AdditiveMonoidProtocol: AdditiveSemigroupProtocol, AdditiveUnitalMagmaProtocol, AdditiveSmallCatagoryProtocol
{
    static func +(operand1: Self, operand2: Self) -> Self;
}

public protocol AdditiveGroupProtocol: AdditiveLoopProtocol, AdditiveAssociativeQuasigroupProtocol, AdditiveMonoidProtocol, AdditiveGroupoidProtocol
{
    static func +(operand1: Self, operand2: Self) -> Self;
}

public protocol AdditiveCommutativeMonoidProtocol: AdditiveMonoidProtocol
{
    static func +(operand1: Self, operand2: Self) -> Self;
}

public protocol AdditiveAbelianGroupProtocol: AdditiveGroupProtocol, AdditiveCommutativeMonoidProtocol
{
    static func +(operand1: Self, operand2: Self) -> Self;
}
