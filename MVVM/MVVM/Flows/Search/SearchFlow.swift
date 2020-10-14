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
        case .search:
            return navigateToSearch()
        default:
            return .none
        }
    }

    private func navigateToSearch() -> FlowContributors {
        let vm = SearchListVM(services: services)
        let vc = SearchListVC(viewModel: vm)
        
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
