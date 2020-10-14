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
    private let appServices: AppServices
    private let disposeBag = DisposeBag()

    init(withServices services: AppServices) {
        self.appServices = services
    }

    var initialStep: Step {
        return AppStep.dashboard
    }

}
