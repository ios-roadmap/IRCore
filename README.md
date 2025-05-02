# IRCore

*A concise, opinionated **core‑operations** layer for the **iOSRoadmap** ecosystem*

---

<!-- Outline -->
1. Overview
2. Features
3. Installation
4. Quick‑Start Examples
5. Architectural Principles
6. Prerequisites & Compatibility
7. Ecosystem
8. Documentation Status
9. Contributing
10. Roadmap
11. Licence
12. Changelog

---

## 1. Overview
`IRCore` provides the **runtime backbone** for every application and module in iOSRoadmap.  
It orchestrates dependency injection, service discovery, configuration, logging, and task scheduling so that higher‑level code remains clear, composable, and testable.

> **Why another core library?**  
> Because simplicity, zero external dependencies, and predictable behaviour trump fancy DSLs and reflection‑heavy magic.

## 2. Features
* **🧩 DependencyContainer** – lightweight, type‑safe service registration & resolution (`scoped`, `singleton`, `transient`).  
* **🗄️ ServiceLocator** – zero‑cost façade when you really *must* access global services.  
* **📝 IRLog** – centralised, pluggable logging with log‑level filters & OSLog integration.  
* **🗂️ Environment** – runtime configuration for dev / staging / production with secure secrets injection.  
* **⏱️ TaskScheduler** – serial & concurrent job queues with automatic cancellation on deinit.  
* **🛡️ ErrorKit** – expressive domain‑specific errors, unified `Result` helpers, retry policies.  
* **🔒 Thread‑safe by design** – value semantics + actors where it matters.  
* **0 external dependencies** – pure Swift 6 code base, 100 % unit‑tested.

## 3. Installation
IRCore is distributed exclusively via **Swift Package Manager**.

### Xcode
1. **File ▸ Add Packages…**
2. Paste the repo URL:
   ```text
   https://github.com/ios-roadmap/IRCore.git
   ```
3. Select **Up to Next Major Version** (starting from **0.0.1**).

### Package.swift
```swift
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    // …
    dependencies: [
        .package(url: "https://github.com/ios-roadmap/IRCore.git", from: "0.0.1")
    ],
    targets: [
        .target(
            name: "YourApp",
            dependencies: ["IRCore"]
        )
    ]
)
```

## 4. Quick‑Start Examples

### Register & resolve a service

```swift
import IRCore

protocol Analytics { func track(_ event: String) }

final class FirebaseAnalytics: Analytics {
    func track(_ event: String) { print("📊", event) }
}

// Register
DependencyContainer.global.register(scope: .singleton) { FirebaseAnalytics() as Analytics }

// Resolve
let analytics = DependencyContainer.global.resolve(Analytics.self)
analytics.track("onboarding_completed")
```

### Scoped container for unit tests

```swift
let testContainer = DependencyContainer()
testContainer.register { MockAnalytics() as Analytics }

withDependencies(from: testContainer) {
    // Code under test sees mocks only
}
```

### Task scheduling

```swift
TaskScheduler.shared.schedule(label: "image.prefetch") {
    await prefetchImages()
}
```

### Environment switching

```swift
let api = Environment.current.apiBaseURL
print(api) // https://api.staging.iosroadmap.dev
```

## 5. Architectural Principles
* **Dependency inversion first** – higher layers depend on abstractions, never concrete types.
* **Pure Swift** – no Obj‑C runtime tricks; easy to debug, easy to trust.
* **Explicit over implicit** – you *see* what you get (`register`, `resolve`), no hidden magic.
* **Immutable defaults** – mutability is opt‑in, concurrency issues are opt‑out.
* **British English naming** – e.g. `initialise()`.

## 6. Prerequisites & Compatibility

|                      | Minimum |
|----------------------|---------|
| iOS deployment target| **18.0**|
| Swift                | **6.0** |
| Xcode                | **16**  |

IRCore has **no** UIKit / SwiftUI dependencies; it is UI‑agnostic.

## 7. Ecosystem
All iOSRoadmap packages layer as follows:

```
┌────────────────────┐
│     Your App       │
├────────────────────┤
│  Feature Modules   │
├────────────────────┤
│   IRFoundation     │
├────────────────────┤
│      IRCore        │ ← you are here
└────────────────────┘
```

* **IRFoundation** offers view helpers, design tokens, etc.  
* **IRCore** focuses on runtime, configuration, and orchestration.

## 8. Documentation Status
Full DocC documentation and a sample playground are **on the way**.  
In the interim, explore the public headers and unit tests.

## 9. Contributing
We 💜 community input.

1. **Fork** → branch (`feature/xyz`)  
2. Run `swift test` + `swiftformat .`  
3. Open a PR — we review within 24 h.

### Commit convention
* `feat:` new feature
* `fix:` bug fix
* `chore:` infra / tooling
* `docs:` documentation

## 10. Roadmap
- [ ] `ServiceGraph` visualiser (SPM plugin)
- [ ] AsyncSequence‑based `TaskScheduler`
- [ ] Structured concurrency metrics
- [ ] Config encryption at rest

## 11. Licence
Released under the **MIT Licence** — see `LICENCE`.

## 12. Changelog
### 0.0.1 – *2025‑05‑02*
* 🎉 Initial release.
* DependencyContainer, ServiceLocator, IRLog, Environment, TaskScheduler, ErrorKit.
* 100 % unit‑tested, CI via GitHub Actions.
