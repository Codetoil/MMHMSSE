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

public protocol HilbertManifoldProtocol 
{
    associatedtype ScalarType: CStarAlgebra;
}

public protocol HilbertManifoldChartProtocol<HilbertManifold>
{
    associatedtype ScalarType: CStarAlgebra;
    associatedtype HilbertManifold: HilbertManifoldProtocol;
    
    func forward(point: HilbertManifold) -> (any HilbertSpaceProtocol)?;
    func backwards(point: any HilbertSpaceProtocol) -> HilbertManifold?;
}

public protocol Bundle<TotalSpace, BaseSpace> 
{
    associatedtype ScalarType: CStarAlgebra;
    associatedtype TotalSpace: HilbertManifoldProtocol;
    associatedtype BaseSpace: HilbertManifoldProtocol;
    static func projection(totalPoint: TotalSpace) -> BaseSpace;
}

public protocol PrincipleBundle<TotalSpace, BaseSpace, GroupType>: Bundle 
{
    associatedtype GroupType: Group;
    static func apply(totalPoint: TotalSpace, groupValue: GroupType) -> TotalSpace;
}

public protocol SmoothHilbertManifoldProtocol: HilbertManifoldProtocol
{
    associatedtype TangentBundleTotalSpace: SmoothHilbertManifoldProtocol;
    associatedtype TangentBundle: Bundle<TangentBundleTotalSpace, Self>;
    static func tangentBundle() -> TangentBundle;
    
    associatedtype TangentFrameBundleTotalSpace: SmoothHilbertManifoldProtocol;
    associatedtype LinearOperatorGroup: Group;
    associatedtype TangentFrameBundle: PrincipleBundle<TangentFrameBundleTotalSpace, Self, LinearOperatorGroup>;
    static func tangentFrameBundle() -> TangentFrameBundle;
}
