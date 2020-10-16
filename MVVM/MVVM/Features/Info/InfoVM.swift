//
//  InfoViewModel.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 16.10.20.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Combine

class InfoVM : Stepper {
    
    let steps = PublishRelay<Step>()
    
    typealias Dependencies = HasMovieService
    let dependencies: Dependencies
    
    // SwiftUI
    @Published var alertMessage: String = ""
    let showDetail = PassthroughSubject<Void, Never>()
    private var disposables = Set<AnyCancellable>()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        
        $alertMessage
        .sink { [weak self] (text) in
            guard let self = self else { return }
            self.steps.accept(AppStep.infoAlert(message: text))
        }
        .store(in: &disposables)
        
        showDetail
        .sink { [weak self] () in
            guard let self = self else { return }
            self.steps.accept(AppStep.infoDetail)
        }
        .store(in: &disposables)
    }
}
class InfoFlowStepper: Stepper {
    let steps = PublishRelay<Step>()
}
