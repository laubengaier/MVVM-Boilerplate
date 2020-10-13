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
        
        let movieListStepper = MovieListStepper()

        let movieListFlow = MovieListFlow(withServices: self.services, andStepper: movieListStepper)

        Flows.use(movieListFlow, when: .created) { [unowned self] (root1: UINavigationController) in
            let tabBarItem1 = UITabBarItem(title: "MovieList", image: UIImage(systemName: "house"), selectedImage: nil)
            root1.tabBarItem = tabBarItem1
            root1.title = "Movie List"

            self.rootViewController.setViewControllers([root1], animated: false)
        }

        return .multiple(
            flowContributors: [
                .contribute(
                    withNextPresentable: movieListFlow,
                    withNextStepper: CompositeStepper(steppers: [OneStepper(withSingleStep: AppStep.movieList), movieListStepper]))
            ]
        )
    }
}
