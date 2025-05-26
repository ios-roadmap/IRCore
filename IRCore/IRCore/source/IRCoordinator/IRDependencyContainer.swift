//
//  IRDependencyContainer.swift
//  IRCore
//
//  Created by Ömer Faruk Öztürk on 18.02.2025.
//

import SwiftUI

@MainActor
public final class IRDependencyContainer {
    
    private var store: [String: () -> Any] = [:]
    public static let shared = IRDependencyContainer(); private init() {}
    
    /// Registers a factory closure for the given type.
    public func register<T>(_ type: T.Type, _ factory: @escaping () -> T) {
        store[String(describing: type)] = factory
    }
    
    /// Resolves an instance of the given type.
    public func resolve<T>(_ type: T.Type) -> T {
        guard let value = store[String(describing: type)]?() as? T else {
            fatalError("Nothing registered for \(type)")
        }
        return value
    }
}
