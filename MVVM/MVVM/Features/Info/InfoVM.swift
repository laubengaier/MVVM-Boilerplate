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

class InfoVM : Stepper {
    
    let steps = PublishRelay<Step>()
    typealias Dependencies = HasMovieService
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}
