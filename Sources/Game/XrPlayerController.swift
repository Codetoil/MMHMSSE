//
//  XrPlayerController.swift
//
//
//  Created by Anthony Michalek on 2/18/24.
//

import SwiftGodot;

class XrPlayerController: XrPlayerControllerProtocol {
    private final var speed: Float = 5.0;
    private final var friction: Double = 5.0;
    private final var jumpImpulse: Float = 5.0;
    private final var xrPlayer: XrPlayer;
    
    init(xrPlayer: XrPlayer)
    {
        self.xrPlayer = xrPlayer;
    }
    
    func processControls() {
        var playerBody: CharacterBody3D = xrPlayer.getNode(path: "XROrigin/PlayerBody") as! CharacterBody3D;
        var xrCamera: XRCamera3D = xrPlayer.getNode(path: "XROrigin3D/XRCamera3D") as! XRCamera3D;
        
        var xMovement: Float = Float(Input.getJoyAxis(device: 0, axis: JoyAxis.leftX));
        var yMovement: Float = xrPlayer.isMaterialized() ? 0 : Float(Input.getAxis(negativeAction: "move_down",
        positiveAction: "move_up"));
        var zMovement: Float = Float(Input.getJoyAxis(device: 0, axis: JoyAxis.leftY));
        var direction: Vector3 = (xrPlayer.transform.basis * Vector3(x: xMovement, y: yMovement, z: zMovement));
        if (direction != .zero)
        {
            playerBody.velocity.x = direction.x * speed;
            playerBody.velocity.z = direction.z * speed;
            if (!xrPlayer.isMaterialized())
            {
                playerBody.velocity.y = direction.y * speed;
            }
        }
        else
        {
            playerBody.velocity.moveToward(to: Vector3(x: 0, y: yMovement, z: 0), delta: friction);
        }
        if (xrPlayer.isMaterialized() && playerBody.isOnFloor() && Input.isActionJustPressed(action: "move_up"))
        {
            playerBody.velocity.y = jumpImpulse;
        }
    }
    
}
