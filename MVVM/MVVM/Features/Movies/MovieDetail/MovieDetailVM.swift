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
    let services: AppServices
    let disposeBag = DisposeBag()
    
    let movieId: Int
    
    let data = BehaviorRelay<MovieDetail?>(value: nil)
    
    init(services: AppServices, movieId: Int) {
        self.services = services
        self.movieId = movieId
        fetchMovie()
    }
    
    func fetchMovie() {
        services
        .movieService
        .details(for: movieId)
        .subscribe { [weak self] (movie) in
            guard let self = self else { return }
            self.data.accept(movie)
        } onError: { (error) in
            print(error)
        }
        .disposed(by: disposeBag)
    }
    
}
