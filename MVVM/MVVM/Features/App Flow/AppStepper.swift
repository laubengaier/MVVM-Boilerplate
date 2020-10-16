//
//  AppStepper.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

class AppStepper: Stepper {

    let steps = PublishRelay<Step>()
    private let dependencies: GlobalAppDependencies
    private let disposeBag = DisposeBag()

    init(withDependencies dependencies: GlobalAppDependencies) {
        self.dependencies = dependencies
    }

    var initialStep: Step {
        return AppStep.dashboard
    }

}
