//  Created by Kevin Watters on 12/27/23 and modified by Anthony Michalek on 2/16/24.

import SwiftUI
import RealityKit
import GodotVision

struct ContentView: View {
    @StateObject private var coordinator = GodotVisionCoordinator()
    
    var body: some View {
        VStack {
            RealityView { content in
                // Initialize Godot
                let rkEntityGodotRoot = coordinator.setupRealityKitScene(content, volumeSize: VOLUME_SIZE)
                print("All Godot nodes going into \(rkEntityGodotRoot)")
                coordinator.changeSceneToFile(atResourcePath: "res://Main.tscn")
            }
        }
        .modifier(GodotVisionRealityViewModifier(coordinator: coordinator))
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
