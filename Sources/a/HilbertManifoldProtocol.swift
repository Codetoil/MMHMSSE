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

public protocol HilbertManifoldProtocol 
{
    associatedtype ScalarType: CStarAlgebraProtocol;
}

public protocol HilbertManifoldChartProtocol<HilbertManifold>
{
    associatedtype ScalarType: CStarAlgebraProtocol;
    associatedtype HilbertManifold: HilbertManifoldProtocol;
    
    func forward(point: HilbertManifold) -> (any HilbertSpaceProtocol)?;
    func backwards(point: any HilbertSpaceProtocol) -> HilbertManifold?;
}

public protocol Bundle<TotalSpace, BaseSpace> 
{
    associatedtype ScalarType: CStarAlgebraProtocol;
    associatedtype TotalSpace: HilbertManifoldProtocol;
    associatedtype BaseSpace: HilbertManifoldProtocol;
    static func projection(totalPoint: TotalSpace) -> BaseSpace;
}

public protocol PrincipleBundle<TotalSpace, BaseSpace, GroupType>: Bundle 
{
    associatedtype GroupType: GroupProtocol;
    static func apply(totalPoint: TotalSpace, groupValue: GroupType) -> TotalSpace;
}

public protocol SmoothHilbertManifoldProtocol: HilbertManifoldProtocol
{
    associatedtype TangentBundleTotalSpace: SmoothHilbertManifoldProtocol;
    associatedtype TangentBundle: Bundle<TangentBundleTotalSpace, Self>;
    static func tangentBundle() -> TangentBundle;
    
    associatedtype TangentFrameBundleTotalSpace: SmoothHilbertManifoldProtocol;
    associatedtype LinearOperatorGroup: GroupProtocol;
    associatedtype TangentFrameBundle: PrincipleBundle<TangentFrameBundleTotalSpace, Self, LinearOperatorGroup>;
    static func tangentFrameBundle() -> TangentFrameBundle;
}
