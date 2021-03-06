//
//  ActorFlow.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 14.10.20.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import UIKit

class ActorFlow: Flow {

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
        case .actorList:
            return navigateToActorList()
        default:
            return .none
        }
    }

    private func navigateToActorList() -> FlowContributors {
        let vm = ActorListVM(dependencies: self.dependencies)
        let vc = ActorListVC(viewModel: vm)
        
        self.rootViewController.pushViewController(vc, animated: false)
        return .one(
            flowContributor: .contribute(
                withNextPresentable: vc,
                withNextStepper: vm
            )
        )
    }
    
}

class ActorFlowStepper: Stepper {

    let steps = PublishRelay<Step>()

}
