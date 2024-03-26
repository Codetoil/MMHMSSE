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
import RealModule
import ComplexModule

prefix operator *

public enum Scalar<RealType> where RealType: Real {
    case real(RealType)
    case complex(Complex<RealType>)
    
    static prefix func *(operand: Scalar) -> Scalar
    {
        switch operand {
        case let .real(operand):
            return Scalar.real(operand);
        case let .complex(operand):
            return Scalar.complex(operand.conjugate);
        }
    }
    
    static func +(operand1: Scalar, operand2: Scalar) -> Scalar
    {
        switch operand1 {
        case let .real(operand1):
            switch operand2 {
            case let .real(operand2):
                return Scalar.real(operand1 + operand2);
            case let .complex(operand2):
                return Scalar.complex(operand2 + Complex(operand1));
            }
        case let .complex(operand1):
            switch operand2 {
            case let .real(operand2):
                return Scalar.complex(operand1 + Complex(operand2));
            case let .complex(operand2):
                return Scalar.complex(operand2 + operand1);
            }
        }
    }
    
    static func -(operand1: Scalar, operand2: Scalar) -> Scalar
    {
        switch operand1 {
        case let .real(operand1):
            switch operand2 {
            case let .real(operand2):
                return Scalar.real(operand1 - operand2);
            case let .complex(operand2):
                return Scalar.complex(operand2 - Complex(operand1));
            }
        case let .complex(operand1):
            switch operand2 {
            case let .real(operand2):
                return Scalar.complex(operand1 - Complex(operand2));
            case let .complex(operand2):
                return Scalar.complex(operand2 - operand1);
            }
        }
    }
    
    static prefix func -(operand: Scalar) -> Scalar
    {
        switch operand {
        case let .real(operand):
            return Scalar.real(-operand);
        case let .complex(operand):
            return Scalar.complex(-operand);
        }
    }
    
    static func *(operand1: Scalar, operand2: Scalar) -> Scalar
    {
        switch operand1 {
        case let .real(operand1):
            switch operand2 {
            case let .real(operand2):
                return Scalar.real(operand1 * operand2);
            case let .complex(operand2):
                return Scalar.complex(operand2 * Complex(operand1));
            }
        case let .complex(operand1):
            switch operand2 {
            case let .real(operand2):
                return Scalar.complex(operand1 * Complex(operand2));
            case let .complex(operand2):
                return Scalar.complex(operand2 * operand1);
            }
        }
    }
    
    static func /(operand1: Scalar, operand2: Scalar) -> Scalar
    {
        switch operand1 {
        case let .real(operand1):
            switch operand2 {
            case let .real(operand2):
                return Scalar.real(operand1 / operand2);
            case let .complex(operand2):
                return Scalar.complex(operand2 / Complex(operand1));
            }
        case let .complex(operand1):
            switch operand2 {
            case let .real(operand2):
                return Scalar.complex(operand1 / Complex(operand2));
            case let .complex(operand2):
                return Scalar.complex(operand2 / operand1);
            }
        }
    }
    
    static func inv(operand: Scalar) -> Scalar
    {
        switch operand {
        case let .real(operand):
            return Scalar.real(1 / operand);
        case let .complex(operand):
            return Scalar.complex(-1 / operand);
        }
    }
    
    static func +=(operand1: inout Scalar, operand2: Scalar) -> Scalar
    {
        operand1 = operand1 + operand2;
        return operand1;
    }
    
    static func -=(operand1: inout Scalar, operand2: Scalar) -> Scalar
    {
        operand1 = operand1 - operand2;
        return operand1;
    }
    
    static func *=(operand1: inout Scalar, operand2: Scalar) -> Scalar
    {
        operand1 = operand1 * operand2;
        return operand1;
    }
    
    static func /=(operand1: inout Scalar, operand2: Scalar) -> Scalar
    {
        operand1 = operand1 / operand2;
        return operand1;
    }
    
    func real() -> Scalar
    {
        switch self {
        case .real(let realType):
            return self;
        case .complex(let complex):
            return Scalar.real(complex.real);
        }
    }
    
    func imag() -> Scalar
    {
        switch self {
        case .real(let realType):
            return Scalar.real(0);
        case .complex(let complex):
            return Scalar.real(complex.imaginary);
        }
    }
}
