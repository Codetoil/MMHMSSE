//
//  game_visionOSApp.swift
//  game-visionOS
//
//  Created by Anthony Michalek on 2/16/24.
//

import SwiftUI

let VOLUME_SIZE = simd_double3(2.0, 1.0, 1.5)

@main
struct game_visionOSApp: App {
    var body: some Scene {
        WindowGroup {
            MainMenuView()
        }.windowStyle(.plain)
        
        WindowGroup {
            DebugView()
        }.windowStyle(.plain)
        
        ImmersiveSpace(id: "GameWorld") {
            ContentView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
