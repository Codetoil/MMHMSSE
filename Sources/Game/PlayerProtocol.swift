//
//  PlayerProtocol.swift
//
//
//  Created by Anthony Michalek on 2/18/24.
//

protocol PlayerProtocol: MaterializeProtocol {
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
