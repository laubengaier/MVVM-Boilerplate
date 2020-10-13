//
//  MovieDetailVM.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class MovieDetailVM : Stepper {
    
    let steps = PublishRelay<Step>()
    
    let data = Observable<[String]>.just(
        ["Movie Info 1", "Movie Info 2", "Movie Info 3"]
    )
    
    init() {
        
    }
    
}
