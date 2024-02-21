//
//  WindowPlayer.swift
//  
//
//  Created by Anthony Michalek on 2/18/24.
//

import SwiftGodot;

@Godot
class WindowPlayer: CharacterBody3D, PlayerProtocol {
    private final var fallAcceleration: Float = 9.8;
    private var controller: WindowPlayerControllerProtocol?;
    private var mesh: Mesh?;
    private var materialized: Bool = true;
    
    override func _ready() {
        super._ready();
        // dematerialize();
        controller = WindowPlayerController(windowPlayer: self);
    }
    
    override func _process(delta: Double) {
        super._process(delta: delta);
        controller?.processMovementControls();
    }
    
    override func _physicsProcess(delta: Double) {
        if Engine.isEditorHint() { return }
        if (materialized && isOnFloor())
        {
            velocity.y -= fallAcceleration * Float(delta);
        }
        
        moveAndSlide();
        super._physicsProcess(delta: delta);
        
    }
    
    override func _input(event: InputEvent) {
        super._input(event: event);
        controller?.processMouseControls(event: event);
    }
    
    func materialize() {
        materialized = true;
        (getNode(path: "CollisionShape3D") as! CollisionShape3D).disabled = false;
        (getNode(path: "Pivot/MeshInstance3D") as! MeshInstance3D).mesh = mesh;
        Input.mouseMode = Input.MouseMode.captured;
    }
    
    func dematerialize() {
        materialized = false;
        (getNode(path: "CollisionShape3D") as! CollisionShape3D).disabled = true;
        mesh = (getNode(path: "Pivot/MeshInstance3D") as! MeshInstance3D).mesh;
        (getNode(path: "Pivot/MeshInstance3D") as! MeshInstance3D).mesh = nil;
        Input.mouseMode = Input.MouseMode.visible;
    }
    
    func isMaterialized() -> Bool {
        return materialized;
    }
    
    func getController() -> PlayerControllerProtocol {
        return controller!;
    }
    
}
