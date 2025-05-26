//
//  Coordinator.swift
//  IRCore
//
//  Created by Ömer Faruk Öztürk on 18.02.2025.
//

import SwiftUI

@MainActor
public protocol CoordinatorProtocol: ObservableObject {
    func start() -> AnyView
}
