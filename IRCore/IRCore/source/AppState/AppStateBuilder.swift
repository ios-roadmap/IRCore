//
//  AppStateBuilder.swift
//  IROnboarding
//
//  Created by Ömer Faruk Öztürk on 25.05.2025.
//

import SwiftUI

public struct AppStateBuilder<DashboardView: View, OnboardingView: View>: View {
    public var showDashboard: Bool
    @ViewBuilder public var dashboardView: DashboardView
    @ViewBuilder public var onboardingView: OnboardingView

    public init(
        showDashboard: Bool,
        @ViewBuilder dashboardView: @escaping () -> DashboardView,
        @ViewBuilder onboardingView: @escaping () -> OnboardingView
    ) {
        self.showDashboard = showDashboard
        self.dashboardView = dashboardView()
        self.onboardingView = onboardingView()
    }

    public var body: some View {
        ZStack {
            if showDashboard {
                dashboardView
                    .transition(.move(edge: .trailing))
            } else {
                onboardingView
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.smooth, value: showDashboard)
    }
}

private struct PreviewView: View {
    @State private var showDashboard: Bool = false
    
    var body: some View {
        AppStateBuilder(
            showDashboard: showDashboard,
            dashboardView: {
                createButton("Dashboard")
                    .background(.red)
            },
            onboardingView: {
                createButton("Onboarding")
            }
        )
    }
    
    private func createButton(_ title: String) -> some View {
        ZStack {
            showDashboard ? Color.green.ignoresSafeArea() : Color.yellow.ignoresSafeArea()
            
            Button(title) {
                showDashboard.toggle()
            }
            .padding()
            .background(.black)
            .foregroundStyle(.white)
            .drawingGroup()
        }
    }
}

#Preview(body: {
    PreviewView()
})
