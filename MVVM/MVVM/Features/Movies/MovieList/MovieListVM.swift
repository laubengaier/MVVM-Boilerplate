//
//  MovieListVM.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import RxRelay

class MovieListVM : Stepper {
    
    typealias Dependencies = HasMovieService
    
    let steps = PublishRelay<Step>()
    let dependencies: Dependencies
    let disposeBag = DisposeBag()
    
    let data = BehaviorRelay<[Movie]>(value: [])
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        fetchMovies()
    }
    
    func fetchMovies() {
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
    
    func showDetail(index: Int) {
        let movieId = data.value[index].id
        steps.accept(AppStep.movieDetail(id: movieId))
    }
    
}
