//
//  InfoFlow.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 16.10.20.
//

import Foundation
import UIKit
import RxFlow
import RxSwift
import RxCocoa
import UIKit

class InfoFlow: Flow {

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
        case .info:
            return navigateToInfo()
        case .infoAlert(let message):
            return navigateToInfoAlert(message)
        default:
            return .none
        }
    }

    private func navigateToInfo() -> FlowContributors {
        let vm = InfoVM(dependencies: dependencies)
        let vc = InfoVC(viewModel: vm)
        
        self.rootViewController.setViewControllers([vc], animated: false)
        return .one(
            flowContributor: .contribute(
                withNextPresentable: vc,
                withNextStepper: vm
            )
        )
    }
    
    private func navigateToInfoAlert(_ message: String) -> FlowContributors {
        let alertVc = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        rootViewController.present(alertVc, animated: true, completion: nil)
        return .none
    }
    
}

class InfoFlowStepper: Stepper {

    let steps = PublishRelay<Step>()

}
