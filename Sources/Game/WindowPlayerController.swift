//
//  WindowPlayerController.swift
//
//
//  Created by Anthony Michalek on 2/18/24.
//

import SwiftGodot;

class WindowPlayerController: WindowPlayerControllerProtocol {
    private final var speed: Float = 5.0;
    private final var friction: Double = 0.1;
    private final var jumpImpulse: Float = 5.0;
    private final var mouseSensitivity: Double = 0.01;
    private final var rollSensitivity: Double = 0.01;
    private final var windowPlayer: WindowPlayer;
    
    init(windowPlayer: WindowPlayer)
    {
        self.windowPlayer = windowPlayer;
    }
    
    func processMovementControls() {
        var cameraPivot: Marker3D = windowPlayer.getNode(path: "CameraPivot") as! Marker3D;
        
        var inputDir: Vector2 = Input.getVector(negativeX: "move_left", positiveX: "move_right",
         negativeY: "move_forward", positiveY: "move_back");
        var yMovement: Float = windowPlayer.isMaterialized() ? 0 :
        Float(Input.getAxis(negativeAction: "move_down", positiveAction: "move_up"));
        var direction: Vector3 = (windowPlayer.transform.basis * Vector3(x: inputDir.x, y: yMovement, z: inputDir.y));
        if (direction != .zero)
        {
            windowPlayer.velocity.x = direction.x * speed;
            windowPlayer.velocity.z = direction.z * speed;
            if (!windowPlayer.isMaterialized())
            {
                windowPlayer.velocity.y = direction.y * speed;
            }
        }
        else
        {
            windowPlayer.velocity.moveToward(to: Vector3(x: 0.0, y: yMovement, z: 0.0), delta: friction);
        }
        if (windowPlayer.isMaterialized() && windowPlayer.isOnFloor() && Input.isActionJustPressed(action: "move_up"))
        {
            windowPlayer.velocity.y = jumpImpulse;
        }
        
        var cameraX = Input.getAxis(negativeAction: "look_down", positiveAction: "look_up");
        var cameraY = Input.getAxis(negativeAction: "look_left", positiveAction: "look_right");
        var cameraZ = Input.getAxis(negativeAction: "roll_left", positiveAction: "roll_right");
        windowPlayer.rotateY(angle: -cameraY * mouseSensitivity);
        cameraPivot.rotateX(angle: cameraX * mouseSensitivity);
        cameraPivot.rotateZ(angle: -cameraZ * rollSensitivity);
    }
    
    func processMouseControls(event: InputEvent) {
        if (((!windowPlayer.isMaterialized() && Input.isActionPressed(action: "holding_right_mouse_button"))
             || (windowPlayer.isMaterialized() && Input.mouseMode == Input.MouseMode.captured))
            && event is InputEventMouseMotion)
        {
            windowPlayer.rotateY(angle: -Double((event as! InputEventMouseMotion).relative.x) * mouseSensitivity);
            (windowPlayer.getNode(path: "CameraPivot") as! Marker3D).rotateX(angle:
            -Double((event as! InputEventMouseMotion).relative.y) * mouseSensitivity)
        }
        
        if (windowPlayer.isMaterialized())
        {
            if (Input.isActionPressed(action: "click") && Input.mouseMode == Input.MouseMode.visible)
            {
                Input.mouseMode = Input.MouseMode.captured;
            }
            
            if (Input.isActionPressed(action: "ui_cancel"))
            {
                Input.mouseMode = Input.MouseMode.visible;
            }
        }
    }
    
}
