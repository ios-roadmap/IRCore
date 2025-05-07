//
//  IRDependencyContainer.swift
//  IRCore
//
//  Created by Ömer Faruk Öztürk on 18.02.2025.
//

import SwiftUI

@MainActor
public final class IRDependencyContainer {
    
    public enum Scope { case module, service }
    private var store: [Scope:[String: () -> Any]] = [.module: [:], .service: [:]]
    public static let shared = IRDependencyContainer(); private init() {}
    
    public func register<T>(_ type: T.Type, scope: Scope, _ factory: @escaping () -> T) {
        store[scope]![String(describing: type)] = factory
    }
    
    public func resolve<T>(_ type: T.Type, scope: Scope) -> T {
        guard let value = store[scope]![String(describing: type)]?() as? T
        else { fatalError("Nothing registered for \(type)") }
        return value
    }
}
