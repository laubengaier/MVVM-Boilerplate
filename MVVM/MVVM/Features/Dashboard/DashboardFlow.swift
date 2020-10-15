//
//  DashboardFlow.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation
import UIKit
import RxFlow

class DashboardFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }

    let rootViewController = UITabBarController()
    private let dependencies: GlobalAppDependencies

    init(withDependencies dependencies: GlobalAppDependencies) {
        self.dependencies = dependencies
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }

        switch step {
        case .dashboard:
            return navigateToDashboard()
        default:
            return .none
        }
    }

    private func navigateToDashboard() -> FlowContributors {
        
        let movieStepper = MovieStepper()
        let movieFlow = MovieFlow(withDependencies: self.dependencies, andStepper: movieStepper)
        
        let actorsStepper = ActorFlowStepper()
        let actorFlow = ActorFlow(withDependencies: self.dependencies)
        
        let searchStepper = SearchFlowStepper()
        let searchFlow = SearchFlow(withDependencies: self.dependencies)

        Flows.use(movieFlow, actorFlow, searchFlow, when: .created) { [unowned self] (root1: UINavigationController, root2: UINavigationController, root3: UINavigationController) in
            let tabBarItem1 = UITabBarItem(title: "MovieList", image: UIImage(systemName: "house"), selectedImage: nil)
            root1.tabBarItem = tabBarItem1
            root1.title = "Movie List"
            
            let tabBarItem2 = UITabBarItem(title: "Actors", image: UIImage(systemName: "flame.fill"), selectedImage: nil)
            root2.tabBarItem = tabBarItem2
            root2.title = "Actors"
            
            let tabBarItem3 = UITabBarItem(title: "Suche", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
            root3.tabBarItem = tabBarItem3
            root3.title = "Suche"

            self.rootViewController.setViewControllers([root1, root2, root3], animated: false)
        }

        return .multiple(
            flowContributors: [
                .contribute(
                    withNextPresentable: movieFlow,
                    withNextStepper: CompositeStepper(steppers: [OneStepper(withSingleStep: AppStep.movieList), movieStepper])
                ),
                .contribute(
                    withNextPresentable: actorFlow,
                    withNextStepper: CompositeStepper(steppers: [OneStepper(withSingleStep: AppStep.actorList), actorsStepper])
                ),
                .contribute(withNextPresentable: searchFlow,
                            withNextStepper: CompositeStepper(steppers: [OneStepper(withSingleStep: AppStep.search), searchStepper])
                ),
            ]
        )
    }
}
