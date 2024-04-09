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

public protocol SetElementProtocol
{
    static func ==(operand1: Self, operand2: any SetElementProtocol) -> Bool;
    static func ==(operand1: any SetElementProtocol, operand2: Self) -> Bool;
}

infix operator ∈: CastingPrecedence
infix operator ∪: LogicalDisjunctionPrecedence
infix operator ∩: LogicalConjunctionPrecedence
infix operator ⊂: ComparisonPrecedence
infix operator ⊃: ComparisonPrecedence
infix operator ⊆: ComparisonPrecedence
infix operator ⊇: ComparisonPrecedence
postfix operator ∁

public protocol SetProtocol: SetElementProtocol
{
    static func ∈(element: any SetElementProtocol, set: Self) -> Bool;
    static func ∪(operand1: Self, operand2: any SetProtocol) -> any SetProtocol;
    static func ∪(operand1: any SetProtocol, operand2: Self) -> any SetProtocol;
    static func ∩(operand1: Self, operand2: any SetProtocol) -> any SetProtocol;
    static func ∩(operand1: any SetProtocol, operand2: Self) -> any SetProtocol;
    static func ⊂(properSubset: any SetProtocol, set: Self) -> Bool;
    static func ⊃(properSuperset: any SetProtocol, set: Self) -> Bool;
    static func ⊆(subset: any SetProtocol, set: Self) -> Bool;
    static func ⊇(superset: any SetProtocol, set: Self) -> Bool;
    static postfix func ∁(operand: Self) -> any SetProtocol;
}

public class EmptySet: SetProtocol
{
    public static var instance: EmptySet = EmptySet();
    
    private init() {}
    
    public static func ∈(element: any SetElementProtocol, emptySet: EmptySet) -> Bool
    {
        return false;
    }
    public static func ==(emptySet: EmptySet, operand: any SetElementProtocol) -> Bool
    {
        return operand is EmptySet;
    }
    public static func ==(operand: any SetElementProtocol, emptySet: EmptySet) -> Bool
    {
        return operand is EmptySet;
    }
    public static func ∪(emptySet: EmptySet, operand: any SetProtocol) -> any SetProtocol
    {
        return operand;
    }
    public static func ∪(operand: any SetProtocol, emptySet: EmptySet) -> any SetProtocol
    {
        return operand;
    }
    public static func ∩(emptySet: EmptySet, operand: any SetProtocol) -> any SetProtocol
    {
        return EmptySet.instance;
    }
    public static func ∩(operand: any SetProtocol, emptySet: EmptySet) -> any SetProtocol
    {
        return EmptySet.instance;
    }
    public static func ⊂(properSubset: any SetProtocol, emptySet: EmptySet) -> Bool
    {
        return false;
    }
    public static func ⊃(properSuperset: any SetProtocol, emptySet: EmptySet) -> Bool
    {
        return !(properSuperset is EmptySet);
    }
    public static func ⊆(subset: any SetProtocol, emptySet: EmptySet) -> Bool
    {
        return false;
    }
    public static func ⊇(superset: any SetProtocol, emptySet: EmptySet) -> Bool
    {
        return true;
    }
    public static postfix func ∁(operand: EmptySet) -> any SetProtocol
    {
        return UniverseSet.instance;
    }
}

public class UniverseSet: SetProtocol
{
    public static var instance: UniverseSet = UniverseSet();
    
    private init() {}
    
    public static func ∈(element: any SetElementProtocol, universeSet: UniverseSet) -> Bool
    {
        return true;
    }
    public static func ==(universeSet: UniverseSet, operand: any SetElementProtocol) -> Bool
    {
        return operand is UniverseSet;
    }
    public static func ==(operand: any SetElementProtocol, universeSet: UniverseSet) -> Bool
    {
        return operand is UniverseSet;
    }
    public static func ∪(universeSet: UniverseSet, operand: any SetProtocol) -> any SetProtocol
    {
        return UniverseSet.instance;
    }
    public static func ∪(operand: any SetProtocol, universeSet: UniverseSet) -> any SetProtocol
    {
        return UniverseSet.instance;
    }
    public static func ∩(universeSet: UniverseSet, operand: any SetProtocol) -> any SetProtocol
    {
        return operand;
    }
    public static func ∩(operand: any SetProtocol, universeSet: UniverseSet) -> any SetProtocol
    {
        return operand;
    }
    public static func ⊂(properSubset: any SetProtocol, universeSet: UniverseSet) -> Bool
    {
        return !(properSubset is UniverseSet)
    }
    public static func ⊃(properSuperset: any SetProtocol, universeSet: UniverseSet) -> Bool
    {
        return false;
    }
    public static func ⊆(subset: any SetProtocol, universeSet: UniverseSet) -> Bool
    {
        return true;
    }
    public static func ⊇(superset: any SetProtocol, universeSet: UniverseSet) -> Bool
    {
        return false;
    }
    public static postfix func ∁(operand: UniverseSet) -> any SetProtocol
    {
        return EmptySet.instance;
    }
}

public protocol TopologicalSpaceProtocol: SetProtocol
{
    
}

public protocol NeighborhoodProtocol<TopologicalSpaceType>: SetProtocol
{
    associatedtype TopologicalSpaceType: TopologicalSpaceProtocol;
    static func containsElement(operand: TopologicalSpaceType) -> Bool;
}
