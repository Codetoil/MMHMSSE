//
//  XrPlayer.swift
//
//
//  Created by Anthony Michalek on 2/18/24.
//

import SwiftGodot;

@Godot
class XrPlayer: Node3D, PlayerProtocol {
    private final var fallAcceleration: Float = 9.8;
    private var controller: XrPlayerControllerProtocol?;
    private var mesh: Mesh?;
    private var playerBody: CharacterBody3D?;
    private var materialized: Bool = true;
    
    override func _ready() {
        super._ready();
        // dematerialize();
        // controller = new XrPlayerController(self);
        playerBody = getNode(path: "XROrigin3D/PlayerBody") as! CharacterBody3D;
    }
    
    override func _process(delta: Double) {
        super._process(delta: delta);
        controller?.processControls();
    }
    
    override func _physicsProcess(delta: Double) {
        if Engine.isEditorHint() { return }
        if (materialized && playerBody!.isOnFloor())
        {
            playerBody!.velocity.y -= fallAcceleration * Float(delta);
        }
        
        playerBody!.moveAndSlide();
        super._physicsProcess(delta: delta);
        
    }
    
    func materialize() {
        materialized = true;
        (getNode(path: "XROrigin3D/PlayerBody/CollisionShape3D") as! CollisionShape3D).disabled = false;
        (getNode(path: "XROrigin3D/PlayerBody/Pivot/MeshInstance3D") as! MeshInstance3D).mesh = mesh;
    }
    
    func dematerialize() {
        materialized = false;
        (getNode(path: "XROrigin3D/PlayerBody/CollisionShape3D") as! CollisionShape3D).disabled = true;
        mesh = (getNode(path: "XROrigin3D/PlayerBody/Pivot/MeshInstance3D") as! MeshInstance3D).mesh;
        (getNode(path: "XROrigin3D/PlayerBody/Pivot/MeshInstance3D") as! MeshInstance3D).mesh = nil;
    }
    
    func isMaterialized() -> Bool {
        return materialized;
    }
    
    func getController() -> PlayerControllerProtocol {
        return controller!;
    }
    
}
