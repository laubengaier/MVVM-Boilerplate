//
//  AppFlow.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation
import UIKit
import RxFlow
import RxCocoa
import RxSwift

class AppFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()        
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()

    private let dependencies: GlobalAppDependencies

    init(dependencies: GlobalAppDependencies) {
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
        case .movieDetail(let id):
            return navigateToMovieDetail(id: id)
        default:
            return .none
        }
    }

    private func navigateToDashboard() -> FlowContributors {
        let dashboardFlow = DashboardFlow(withDependencies: dependencies)
        Flows.use(dashboardFlow, when: .created) { [unowned self] root in
            self.rootViewController.pushViewController(root, animated: false)
        }
        return .one(
            flowContributor: .contribute(
                withNextPresentable: dashboardFlow,
                withNextStepper: OneStepper(withSingleStep: AppStep.dashboard)
            )
        )
    }
    
    private func navigateToMovieDetail(id: Int) -> FlowContributors {
        let vm = MovieDetailVM(dependencies: self.dependencies, movieId: id)
        let vc = MovieDetailVC(viewModel: vm)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(
            flowContributor: .contribute(
                withNextPresentable: vc,
                withNextStepper: vm
            )
        )
    }

}
