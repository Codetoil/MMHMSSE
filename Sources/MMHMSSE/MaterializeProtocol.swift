//
//  MaterializeProtocol.swift
//
//
//  Created by Anthony Michalek on 2/18/24.
//

import Foundation

protocol MaterializeProtocol {
    func materialize();
    func dematerialize();
    func isMaterialized() -> Bool;
}
