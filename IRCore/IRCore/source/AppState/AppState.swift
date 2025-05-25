//
//  AppState.swift
//  IROnboarding
//
//  Created by Ömer Faruk Öztürk on 25.05.2025.
//

import SwiftUI

@Observable
public final class AppState {
    public private(set) var showDashboard: Bool {
        didSet { UserDefaults.showDashboard = showDashboard }
    }

    public init(showDashboard: Bool = UserDefaults.showDashboard) {
        self.showDashboard = showDashboard
    }

    public func updateDashboardVisibility(to visible: Bool) {
        showDashboard = visible
    }
}

public extension UserDefaults {
    private enum Keys {
        static let showDashboard = "showDashboardKey"
    }

    static var showDashboard: Bool {
        get { standard.bool(forKey: Keys.showDashboard) }
        set { standard.set(newValue, forKey: Keys.showDashboard) }
    }
}
