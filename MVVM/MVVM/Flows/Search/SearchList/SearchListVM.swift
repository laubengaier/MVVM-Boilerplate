//
//  SearchListVM.swift
//  MVVM
//
//  Created by Mario Zimmermann on 14.10.20.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import RxRelay

class SearchListVM : Stepper {
    
    let steps = PublishRelay<Step>()
    let services: AppServices
    let disposeBag = DisposeBag()
    
    let data = BehaviorRelay<[Movie]>(value: [])
    
    init(services: AppServices) {
        self.services = services
        fetchActors()
    }
    
    func fetchActors() {
        services
        .movieService
        .nowPlaying()
        .debug()
        .subscribe { [weak self] (movies) in
            guard let self = self else { return }
            self.data.accept(movies)
        } onError: { (error) in
            print(error)
        }
        .disposed(by: disposeBag)
    }
    
}
