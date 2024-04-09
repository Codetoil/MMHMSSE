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

import XCTest
@testable import SwiftAlgebraLib

class GenericTestSetElement: SetElementProtocol
{
    public static func ==(operand1: GenericTestSetElement, operand2: any SetElementProtocol) -> Bool
    {
        return operand2 is GenericTestSetElement;
    }
    public static func ==(operand1: any SetElementProtocol, operand2: GenericTestSetElement) -> Bool
    {
        return operand1 is GenericTestSetElement;
    }
}

class GenericTestSet: SetProtocol
{
    public static var instance: GenericTestSet = GenericTestSet();
    
    private init() {}
    
    public static func ∈(element: any SetElementProtocol, set: GenericTestSet) -> Bool
    {
        return false;
    }
    public static func ==(set: GenericTestSet, operand: any SetElementProtocol) -> Bool
    {
        return operand is GenericTestSet;
    }
    public static func ==(operand: any SetElementProtocol, set: GenericTestSet) -> Bool
    {
        return operand is GenericTestSet;
    }
    public static func ∪(set: GenericTestSet, operand: any SetProtocol) -> any SetProtocol
    {
        return operand;
    }
    public static func ∪(operand: any SetProtocol, set: GenericTestSet) -> any SetProtocol
    {
        return operand;
    }
    public static func ∩(set: GenericTestSet, operand: any SetProtocol) -> any SetProtocol
    {
        return EmptySet.instance;
    }
    public static func ∩(operand: any SetProtocol, set: GenericTestSet) -> any SetProtocol
    {
        return EmptySet.instance;
    }
    public static func ⊂(properSubset: any SetProtocol, set: GenericTestSet) -> Bool
    {
        return false;
    }
    public static func ⊃(properSuperset: any SetProtocol, set: GenericTestSet) -> Bool
    {
        return !(properSuperset is EmptySet);
    }
    public static func ⊆(subset: any SetProtocol, set: GenericTestSet) -> Bool
    {
        return false;
    }
    public static func ⊇(superset: any SetProtocol, set: GenericTestSet) -> Bool
    {
        return true;
    }
    public static postfix func ∁(operand: GenericTestSet) -> any SetProtocol
    {
        return ComplementOfGenericTestSet.instance;
    }
}

class ComplementOfGenericTestSet: SetProtocol
{
    public static var instance: ComplementOfGenericTestSet = ComplementOfGenericTestSet();
    
    private init() {}
    
    public static func ∈(element: any SetElementProtocol, set: ComplementOfGenericTestSet) -> Bool
    {
        return false;
    }
    public static func ==(set: ComplementOfGenericTestSet, operand: any SetElementProtocol) -> Bool
    {
        return operand is ComplementOfGenericTestSet;
    }
    public static func ==(operand: any SetElementProtocol, set: ComplementOfGenericTestSet) -> Bool
    {
        return operand is ComplementOfGenericTestSet;
    }
    public static func ∪(set: ComplementOfGenericTestSet, operand: any SetProtocol) -> any SetProtocol
    {
        return operand;
    }
    public static func ∪(operand: any SetProtocol, set: ComplementOfGenericTestSet) -> any SetProtocol
    {
        return operand;
    }
    public static func ∩(set: ComplementOfGenericTestSet, operand: any SetProtocol) -> any SetProtocol
    {
        return EmptySet.instance;
    }
    public static func ∩(operand: any SetProtocol, set: ComplementOfGenericTestSet) -> any SetProtocol
    {
        return EmptySet.instance;
    }
    public static func ⊂(properSubset: any SetProtocol, set: ComplementOfGenericTestSet) -> Bool
    {
        return false;
    }
    public static func ⊃(properSuperset: any SetProtocol, set: ComplementOfGenericTestSet) -> Bool
    {
        return !(properSuperset is EmptySet);
    }
    public static func ⊆(subset: any SetProtocol, set: ComplementOfGenericTestSet) -> Bool
    {
        return false;
    }
    public static func ⊇(superset: any SetProtocol, set: ComplementOfGenericTestSet) -> Bool
    {
        return true;
    }
    public static postfix func ∁(operand: ComplementOfGenericTestSet) -> any SetProtocol
    {
        return GenericTestSet.instance;
    }
}

final class SwiftAlgebraLibTests: XCTestCase {
    var element: GenericTestSetElement? = nil;
    
    override func setUp() async throws {
        self.element = GenericTestSetElement();
    }
    
    func testGenericSetElementMembership() throws {
        XCTAssertNotNil(element, "element was never initialized?!?!");
        XCTAssertFalse(element! ∈ EmptySet.instance, "element is in the empty set");
        XCTAssertTrue(element! ∈ UniverseSet.instance, "element is not in the universal set");
    }
}
