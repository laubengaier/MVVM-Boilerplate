//
//  ActorListVM.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 14.10.20.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import RxRelay

class ActorListVM : Stepper {
    
    typealias Dependencies = HasMovieService
    
    let steps = PublishRelay<Step>()
    let dependencies: Dependencies
    let disposeBag = DisposeBag()
    
    let data = BehaviorRelay<[Movie]>(value: [])
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        fetchActors()
    }
    
    func fetchActors() {
        self.dependencies
        .movieService
        .nowPlaying()
        .subscribe { [weak self] (movies) in
            guard let self = self else { return }
            self.data.accept(movies)
        } onError: { (error) in
            print(error)
        }
        .disposed(by: disposeBag)
    }
    
}
