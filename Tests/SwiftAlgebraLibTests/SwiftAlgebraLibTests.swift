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

class TestSetElement: SetElementProtocol
{
    public static func ==(operand1: TestSetElement, operand2: any SetElementProtocol) -> Bool
    {
        
    }
    public static func ==(operand1: any SetElementProtocol, operand2: TestSetElement) -> Bool
    {
        
    }
}

class TestSet: SetProtocol
{
    
}
