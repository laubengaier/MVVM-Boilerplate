//
//  DasboardVM.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class DashboardVM : Stepper {
    
    let steps = PublishRelay<Step>()
    
    let data = Observable<[String]>.just(["first element", "second element", "third element"])
    
    init() {
        
    }
    
    func showDetail() {
        steps.accept(AppStep.movieDetail(id: ""))
    }
    
}
