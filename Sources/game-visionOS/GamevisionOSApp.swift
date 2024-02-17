//
//  App.swift
//

import SwiftUI

let VOLUME_SIZE = simd_double3(2.0, 1.0, 1.5)

@main
struct GamevisionOSApp: App {
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
