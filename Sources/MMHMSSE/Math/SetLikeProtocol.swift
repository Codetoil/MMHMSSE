//
//  File.swift
//  
//
//  Created by Anthony Michalek on 4/1/24.
//

import Foundation

public protocol SetElementProtocol
{
    static func ==(operand1: Self, operand2: any SetElementProtocol) -> Bool;
    static func ==(operand1: any SetElementProtocol, operand2: Self) -> Bool;
}

infix operator ∪: LogicalDisjunctionPrecedence
infix operator ∩: LogicalConjunctionPrecedence
infix operator ∈: CastingPrecedence
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

extension SetProtocol {
    public static func ∪<SetType: SetProtocol>(operand1: Self, operand2: SetType) -> any SetProtocol
    {
        return UnionSet<Self, SetType>(set1: operand1, set2: operand2);
    }
    public static func ∪<SetType: SetProtocol>(operand1: SetType, operand2: Self) -> any SetProtocol
    {
        return UnionSet<SetType, Self>(set1: operand1, set2: operand2);
    }
    public static func ∩<SetType: SetProtocol>(operand1: Self, operand2: SetType) -> any SetProtocol
    {
        return IntersectionSet<Self, SetType>(set1: operand1, set2: operand2);
    }
    public static func ∩<SetType: SetProtocol>(operand1: SetType, operand2: Self) -> any SetProtocol
    {
        return IntersectionSet<SetType, Self>(set1: operand1, set2: operand2);
    }
    public static postfix func ∁(operand: Self) -> any SetProtocol
    {
        return ComplementSet<Self>(set: operand);
    }
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

public class UnionSet<Set1Type: SetProtocol, Set2Type: SetProtocol>: SetProtocol
{
    public final var set1: Set1Type;
    public final var set2: Set2Type;
    
    public init(set1: Set1Type, set2: Set2Type) {
        self.set1 = set1;
        self.set2 = set2;
    }
    
    public static func ∈(element: any SetElementProtocol, unionSet: UnionSet<Set1Type, Set2Type>) -> Bool
    {
        return element ∈ unionSet.set1 && element ∈ unionSet.set2;
    }
}

public class IntersectionSet<Set1Type: SetProtocol, Set2Type: SetProtocol>: SetProtocol
{
    public final var set1: Set1Type;
    public final var set2: Set2Type;
    
    public init(set1: Set1Type, set2: Set2Type) {
        self.set1 = set1;
        self.set2 = set2;
    }
    
    public static func ∈(element: any SetElementProtocol, intersectionSet: IntersectionSet<Set1Type, Set2Type>) -> Bool
    {
        return element ∈ intersectionSet.set1 || element ∈ intersectionSet.set2;
    }
}

public class ComplementSet<SetType: SetProtocol>: SetProtocol
{
    public final var set: SetType;
    
    public init(set: SetType) {
        self.set = set;
    }
    
    public static func ∈(element: any SetElementProtocol, complementSet: ComplementSet<SetType>) -> Bool
    {
        return !(element ∈ complementSet.set);
    }
    
    public static func ==(complementSet: ComplementSet<SetType>, operand: any SetElementProtocol) -> Bool
    {
        return (operand is ComplementSet<SetType>) && ((complementSet.set) == ((operand as? ComplementSet<SetType>)!.set));
    }
    
    public static func ==(operand: any SetElementProtocol, complementSet: ComplementSet<SetType>) -> Bool
    {
        return (operand is ComplementSet<SetType>) && ((operand as? ComplementSet<SetType>)!.set == (complementSet.set));
    }
    
    public static postfix func ∁(operand: ComplementSet<SetType>) -> any SetProtocol
    {
        return operand.set;
    }
}

public class PowerSet<SetType: SetProtocol>: SetProtocol
{
    public final var set: SetType;
    
    public init(set: SetType) {
        self.set = set
    }
    
    public static func ∈(element: any SetElementProtocol, powerSet: PowerSet<SetType>) -> Bool
    {
        let element: (any SetProtocol)? = element as? any SetProtocol;
        return element != nil && element! ⊆ powerSet.set;
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
