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

public protocol PlayerProtocol: MaterializeProtocol {
    var velocityX: Float { get set };
    var velocityY: Float { get set };
    var velocityZ: Float { get set };

    func getController() -> PlayerControllerProtocol;
    func isOnFloor() -> Bool;
    func moveAndSlide();
    func fallAcceleration() -> Float;
    func tick(delta: Double);
}

extension PlayerProtocol {
    mutating func tick(delta: Double) {
        if (isMaterialized() && isOnFloor())
        {
            velocityY -= fallAcceleration() * Float(delta);
        }
        moveAndSlide();
    }

    func fallAcceleration() -> Float {
        return 9.8;
    }
}
