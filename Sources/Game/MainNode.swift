//
//  Main.swift
//  
//
//  Created by Anthony Michalek on 2/17/24.
//

import SwiftGodot

@Godot
class MainNode: Node {
    private var xrInterface: XRInterface?;
    private var player: PlayerProtocol?;

    override func _ready() {
        xrInterface = XRServer.findInterface(name: "OpenXR");
        if (xrInterface != nil && xrInterface!.isInitialized()) {
            GD.print("OpenXR initialized successfully");
            
            // Turn off v-sync!
            DisplayServer.windowSetVsyncMode(DisplayServer.VSyncMode.disabled);
            
            getViewport()?.useXr = true;
            
            player = createXrPlayer();
        } else {
            GD.print("OpenXR failed to initialized, reverting to backup player node");
            
            player = createWindowPlayer();
        }
    }
    
    override func _process(delta: Double) {
        // Do nothing, for now
    }
    
    public func createXrPlayer() -> XrPlayer {
        var playerScene: PackedScene = ResourceLoader.load(path: "res://XrPlayer.tscn") as! PackedScene;
        var xrPlayer: XrPlayer = playerScene.instantiate() as! XrPlayer;
        xrPlayer.position = Vector3(x: 0, y: 6, z: 0);
        addChild(node: xrPlayer);
        return xrPlayer;
    }
    
    public func createWindowPlayer() -> WindowPlayer {
        var playerScene: PackedScene = ResourceLoader.load(path: "res://WindowPlayer.tscn") as! PackedScene;
        var windowPlayer: WindowPlayer = playerScene.instantiate() as! WindowPlayer;
        windowPlayer.position = Vector3(x: 0, y: 6, z: 0);
        addChild(node: windowPlayer);
        return windowPlayer;
    }
}
