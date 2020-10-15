//
//  SceneDelegate.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import UIKit
import RxSwift
import RxFlow

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let disposeBag = DisposeBag()
    var window: UIWindow?
    var coordinator = FlowCoordinator()
    var dependencies: GlobalAppDependencies?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        guard let window = scene.windows.first else { return }
        
        // UI Madness
        window.overrideUserInterfaceStyle = .dark
        
        
        if ProcessInfo.processInfo.environment["TEST"] == "1" {
            // Add Mock Deps here
            print("Should use mock dependencies")
        } else {
            let factory = DependencyFactory()
            self.dependencies = factory.create()
        }
        
        
        
        self.coordinator.rx.willNavigate.subscribe(onNext: { (flow, step) in
            print("will navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)

        self.coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
            print("did navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)

        guard let dependencies = self.dependencies else { return }
        
        let appFlow = AppFlow(dependencies: dependencies)

        self.coordinator.coordinate(flow: appFlow, with: AppStepper(withDependencies: dependencies))

        UINavigationBar.appearance().tintColor = .white
        UITabBar.appearance().tintColor = .white
        
        Flows.use(appFlow, when: .created) { root in
            window.rootViewController = root
            window.makeKeyAndVisible()
        }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }

}

