//
//  IRInjectedModels.swift
//  IRCore
//
//  Created by Ömer Faruk Öztürk on 23.02.2025.
//

@MainActor
@propertyWrapper
public struct IRLazyInjected<T> {
    private var cached: T?
    public var wrappedValue: T {
        mutating get {
            if cached == nil { cached = IRDependencyContainer.shared.resolve(T.self, scope: .module) }
            return cached!
        }
    }
    public init() {}
}
