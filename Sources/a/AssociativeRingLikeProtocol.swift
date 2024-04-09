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

infix operator *: MultiplicationPrecedence

public protocol NearSemiringProtocol: AdditiveMonoidProtocol, MultiplicitiveSemigroupProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol SemiringProtocol: AdditiveCommutativeMonoidProtocol, MultiplicitiveMonoidProtocol, NearSemiringProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol NearRingProtocol: AdditiveGroupProtocol, MultiplicitiveSemigroupProtocol, NearSemiringProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol RngProtocol: AdditiveAbelianGroupProtocol, MultiplicitiveSemigroupProtocol, NearRingProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol RingProtocol: AdditiveAbelianGroupProtocol, MultiplicitiveMonoidProtocol, RngProtocol, SemiringProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol CommutativeRingProtocol: AdditiveAbelianGroupProtocol, MultiplicitiveCommutativeMonoidProtocol, RingProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol ProperSemifieldProtocol: AdditiveMonoidProtocol, MultiplicitiveGroupProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol NearFieldProtocol: AdditiveAbelianGroupProtocol, MultiplicitiveGroupProtocol, NearRingProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol DivisionRingProtocol: AdditiveAbelianGroupProtocol, MultiplicitiveGroupProtocol, NearFieldProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}

public protocol FieldProtocol: AdditiveAbelianGroupProtocol, MultiplicitiveAbelianGroupProtocol, DivisionRingProtocol
{
    static func *(operand1: Self, operand2: Self) -> Self;
}
