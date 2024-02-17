//
//  ContentView.swift
//

import SwiftUI
import RealityKit

struct MainMenuView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    func playFunction() async {
        switch await openImmersiveSpace(id: "GameWorld") {
        case .opened:
            immersiveSpaceIsShown = true
        case .error, .userCancelled:
            fallthrough
        @unknown default:
            immersiveSpaceIsShown = false
            showImmersiveSpace = false
        }
    }
    
    func exitFunction() async {
        await dismissImmersiveSpace()
        immersiveSpaceIsShown = false
    }
    
    func displayButtons() -> some View
    {
        if (!immersiveSpaceIsShown)
        {
            return Button("Join Game", systemImage: "play.fill") {
                print("Started")
                Task {
                    await playFunction()
                }
            }.font(.title)
        } else {
            return Button("Leave Game", systemImage: "stop.fill") {
                print("Stopping")
                Task {
                    await exitFunction()
                }
            }.font(.title)
        }
    }
    
    var body: some View {
        VStack {
            VStack (spacing: 12) {
                displayButtons()
            }
            .frame(width: 360)
            .padding(36)
            .glassBackgroundEffect()
        }
    }
}

#Preview(windowStyle: .plain) {
    MainMenuView()
}
