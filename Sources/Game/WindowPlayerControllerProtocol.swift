//
//  WindowPlayerControllerProtocol.swift
//
//
//  Created by Anthony Michalek on 2/18/24.
//

import SwiftGodot;

protocol WindowPlayerControllerProtocol: PlayerControllerProtocol {
    func processMovementControls();
    func processMouseControls(event: InputEvent);
}
