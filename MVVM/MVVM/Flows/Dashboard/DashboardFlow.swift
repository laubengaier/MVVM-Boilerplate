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
    private let services: AppServices

    init(withServices services: AppServices) {
        self.services = services
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
        let movieFlow = MovieFlow(withServices: self.services, andStepper: movieStepper)
        
        let actorsStepper = ActorFlowStepper()
        let actorFlow = ActorFlow(withServices: self.services)

        Flows.use(movieFlow, actorFlow, when: .created) { [unowned self] (root1: UINavigationController, root2: UINavigationController) in
            let tabBarItem1 = UITabBarItem(title: "MovieList", image: UIImage(systemName: "house"), selectedImage: nil)
            root1.tabBarItem = tabBarItem1
            root1.title = "Movie List"
            
            let tabBarItem2 = UITabBarItem(title: "Actors", image: UIImage(systemName: "flame.fill"), selectedImage: nil)
            root2.tabBarItem = tabBarItem2
            root2.title = "Actors"

            self.rootViewController.setViewControllers([root1, root2], animated: false)
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
                )
            ]
        )
    }
}
