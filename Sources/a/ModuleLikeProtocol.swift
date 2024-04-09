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

public protocol OperatorProtocol: SetProtocol
{
}


public protocol MultiplicitiveGroupWithOperatorsProtocol<MultiplicitiveOperatorType>: MultiplicitiveGroupProtocol
{
    associatedtype MultiplicitiveOperatorType: OperatorProtocol;
    static func multiplicitiveGroupActor(_operator: MultiplicitiveOperatorType) -> (Self) -> Self;
    static func ^(operand: Self, _operator: MultiplicitiveOperatorType) -> Self;
}

extension MultiplicitiveGroupWithOperatorsProtocol {
    static func multiplicitiveGroupActor(_operator: MultiplicitiveOperatorType) -> (Self) -> Self
    {
        return {(operand: Self) -> Self in
            return operand ^ _operator;
        };
    }
}


public protocol AdditiveGroupWithOperatorsProtocol<AdditiveOperatorType>: AdditiveGroupProtocol
{
    associatedtype AdditiveOperatorType: OperatorProtocol;
    static func additiveGroupActor(_operator: AdditiveOperatorType) -> (Self) -> Self;
    static func *(_operand: AdditiveOperatorType, operand: Self) -> Self;
}

extension AdditiveGroupWithOperatorsProtocol {
    static func additiveGroupActor(_operator: AdditiveOperatorType) -> (Self) -> Self
    {
        return {(operand: Self) -> Self in
            return _operator * operand;
        };
    }
}


public protocol LeftNearRingModuleProtocol<LeftNearRingType>: AdditiveGroupWithOperatorsProtocol
{
    associatedtype LeftNearRingType: NearRingProtocol, OperatorProtocol;
    associatedtype AdditiveOperatorType = LeftNearRingType;
}

public protocol LeftModuleOverSemiringProtocol<LeftSemiringType>: AdditiveCommutativeMonoidProtocol
{
    associatedtype LeftSemiringType: SemiringProtocol, OperatorProtocol;
    static func additiveGroupActor(_operator: LeftSemiringType) -> (Self) -> Self;
    static func *(_operator: LeftSemiringType, operand: Self) -> Self;
}

extension LeftModuleOverSemiringProtocol {
    static func additiveGroupActor(_operator: LeftSemiringType) -> (Self) -> Self
    {
        return {(operand: Self) -> Self in
            return _operator * operand;
        };
    }
}

public protocol LeftModuleProtocol<LeftRingType>: LeftNearRingModuleProtocol, LeftModuleOverSemiringProtocol, AdditiveAbelianGroupProtocol
{
    associatedtype LeftRingType: RingProtocol, OperatorProtocol;
    associatedtype LeftNearRingType = LeftRingType;
}


public protocol RightNearRingModuleProtocol<RightNearRingType>: AdditiveGroupWithOperatorsProtocol
{
    associatedtype RightNearRingType: NearRingProtocol, OperatorProtocol;
    static func additiveGroupActor(_operator: RightNearRingType) -> (Self) -> Self;
    static func *(operand: Self, _operator: RightNearRingType) -> Self;
}

extension RightNearRingModuleProtocol {
    static func additiveGroupActor(_operator: RightNearRingType) -> (Self) -> Self
    {
        return {(operand: Self) -> Self in
            return operand * _operator;
        };
    }
}

public protocol RightModuleOverSemiringProtocol<RightSemiringType>: AdditiveCommutativeMonoidProtocol
{
    associatedtype RightSemiringType: SemiringProtocol, OperatorProtocol;
    static func additiveGroupActor(_operator: RightSemiringType) -> (Self) -> Self;
    static func *(operand: Self, _operator: RightSemiringType) -> Self;
}

extension RightModuleOverSemiringProtocol {
    static func additiveGroupActor(_operator: RightSemiringType) -> (Self) -> Self
    {
        return {(operand: Self) -> Self in
            return operand * _operator;
        };
    }
}

public protocol RightModuleProtocol<RightRingType>: RightNearRingModuleProtocol, RightModuleOverSemiringProtocol, AdditiveAbelianGroupProtocol
{
    associatedtype RightRingType: RingProtocol, OperatorProtocol;
    associatedtype RightNearRingType = RightRingType;
}

public protocol BiModuleProtocol<LeftRingType, RightRingType>: LeftModuleProtocol, RightModuleProtocol
{
}

public protocol ModuleProtocol<RingType>: BiModuleProtocol
{
    associatedtype RingType: RingProtocol, OperatorProtocol;
    associatedtype LeftRingType = RingType;
    associatedtype RightRingType = RingType;
}

public protocol VectorSpaceProtocol<FieldType>: ModuleProtocol
{
    associatedtype FieldType: FieldProtocol, OperatorProtocol;
    associatedtype RingType = FieldType;
}
