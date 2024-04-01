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

public protocol OperatorProtocol: SetProtocol
{
}

public protocol MultiplicitiveGroupWithOperatorsProtocol<MultiplicitiveOperatorType>: MultiplicitiveGroupProtocol
{
    associatedtype MultiplicitiveOperatorType: OperatorProtocol;
    static func multiplicitiveGroupActor(_operator: MultiplicitiveOperatorType) -> (Self) -> Self;
    static func *(_operator: MultiplicitiveOperatorType, operand: Self) -> Self;
}

extension MultiplicitiveGroupWithOperatorsProtocol {
    static func multiplicitiveGroupActor(_operator: MultiplicitiveOperatorType) -> (Self) -> Self
    {
        return {(operand: Self) -> Self in
            return _operator * operand;
        };
    }
}


public protocol AdditiveGroupWithOperatorsProtocol<AdditiveOperatorType>: AdditiveGroupProtocol
{
    associatedtype AdditiveOperatorType: OperatorProtocol;
    static func additiveGroupActor(operator: AdditiveOperatorType) -> (Self) -> Self;
    static func +(operand: AdditiveOperatorType, operand: Self) -> Self;
}

extension AdditiveGroupWithOperatorsProtocol {
    static func additiveGroupActor(_operator: AdditiveOperatorType) -> (Self) -> Self
    {
        return {(operand: Self) -> Self in
            return _operator + operand;
        };
    }
}


public protocol NearringModuleProtocol<NearRingType>: AdditiveGroupWithOperatorsProtocol
{
    associatedtype NearRingType: NearRingProtocol, OperatorProtocol;
    associatedtype AdditiveOperatorType = NearRingType;
}
