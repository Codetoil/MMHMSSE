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

prefix operator *

public protocol CStarAlgebra 
{
    
    static prefix func *(operand: Self) -> Self;
    
    static func +(operand1: Self, operand2: Self) -> Self;
    
    static func -(operand1: Self, operand2: Self) -> Self;
    
    static prefix func -(operand: Self) -> Self;
    
    static func *(operand1: Self, operand2: Self) -> Self;
    
    static func /(operand1: Self, operand2: Self) -> Self;
    
    static func inv(operand: Self) -> Self;
    
    func inv() -> Self;
    
    static func ==(operand1: Self, operand2: Self) -> Bool;
    
    func real() -> Self;
    
    func imaginary() -> Self;
}

extension CStarAlgebra
{
    func inv() -> Self {
        return Self.inv(operand: self);
    }
}

func +=<AlgebraType>(operand1: inout AlgebraType, operand2: AlgebraType) -> AlgebraType where AlgebraType: CStarAlgebra
{
    operand1 = operand1 + operand2;
    return operand1;
}

func -=<AlgebraType>(operand1: inout AlgebraType, operand2: AlgebraType) -> AlgebraType where AlgebraType: CStarAlgebra
{
    operand1 = operand1 - operand2;
    return operand1;
}

func *=<AlgebraType>(operand1: inout AlgebraType, operand2: AlgebraType) -> AlgebraType where AlgebraType: CStarAlgebra
{
    operand1 = operand1 * operand2;
    return operand1;
}

func /=<AlgebraType>(operand1: inout AlgebraType, operand2: AlgebraType) -> AlgebraType where AlgebraType: CStarAlgebra
{
    operand1 = operand1 / operand2;
    return operand1;
}
