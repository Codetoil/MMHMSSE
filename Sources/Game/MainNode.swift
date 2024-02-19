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
            
            player = createPlayer();
        }
    }
    
    override func _process(delta: Double) {
        // Do nothing, for now
    }
    
    public func createXrPlayer() -> XrPlayer {
        
    }
    
    public func createPlayer() -> WindowPlayer {
        
    }
}
