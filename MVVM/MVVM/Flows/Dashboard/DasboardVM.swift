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
import RxRelay

class DashboardVM : Stepper {
    
    let steps = PublishRelay<Step>()
    let services: AppServices
    
    let data = BehaviorRelay<[Movie]>(value: [
        Movie(title: "Se7en", overview: "Goiler Film"),
        Movie(title: "Mulan", overview: "Nice Film")
    ])
    
    init(services: AppServices) {
        self.services = services
        fetchMovies()
    }
    
    func fetchMovies() {
//        services
//        .movieService
//        .nowPlaying()
//        .bind(to: data)
    }
    
    func showDetail() {
        steps.accept(AppStep.movieDetail(id: ""))
    }
    
}
