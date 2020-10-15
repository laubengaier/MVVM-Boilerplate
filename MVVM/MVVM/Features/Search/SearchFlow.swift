//
//  SearchFlow.swift
//  MVVM
//
//  Created by Mario Zimmermann on 14.10.20.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import UIKit

class SearchFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController: UINavigationController = {
        let nvc = UINavigationController()
        nvc.navigationBar.prefersLargeTitles = true
        return nvc
    }()
    
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
        case .search:
            return navigateToSearch()
        case .movieDetail(let id):
            return self.navigateToMovieDetail(id: id)
        default:
            return .none
        }
    }

    private func navigateToSearch() -> FlowContributors {
        let vm = SearchListVM(dependencies: self.dependencies)
        let vc = SearchListVC(viewModel: vm)
        
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(
            flowContributor: .contribute(
                withNextPresentable: vc,
                withNextStepper: vm
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

class SearchFlowStepper: Stepper {

    let steps = PublishRelay<Step>()

}
