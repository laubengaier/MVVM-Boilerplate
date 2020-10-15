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
    
    typealias Dependencies = HasMovieService
    
    let steps = PublishRelay<Step>()
    let dependencies: Dependencies
    let disposeBag = DisposeBag()
    
    let movieId: Int
    
    let data = BehaviorRelay<MovieDetail?>(value: nil)
    let cellData = BehaviorRelay<[MovieDetailInfoCell.Model]>(value: [])
    
    init(dependencies: GlobalAppDependencies, movieId: Int) {
        self.dependencies = dependencies
        self.movieId = movieId
        fetchMovie()
    }
    
    func fetchMovie() {
        self.dependencies
        .movieService
        .details(for: movieId)
        .subscribe { [weak self] (movie) in
            guard let self = self else { return }
            self.data.accept(movie)
            
            let cells: [MovieDetailInfoCell.Model?] = [
                MovieDetailInfoCell.Model(
                    title: "Title",
                    info: movie.title == movie.originalTitle ? movie.title : movie.title + " | " + movie.originalTitle
                ),
                MovieDetailInfoCell.Model(title: "Overview", info: movie.overview),
                MovieDetailInfoCell.Model(title: "Tags", info: movie.tagline),
                MovieDetailInfoCell.Model(title: "Genres", info: String(movie.genres.map({ $0.name }).joined(separator: ", "))),
                MovieDetailInfoCell.Model(title: "Rating", info: String(format: "%.1f", movie.voteAverage)),
                MovieDetailInfoCell.Model(title: "Language", info: movie.originalLanguage)
            ]
            self.cellData.accept(cells.compactMap({ $0 }))
            
        } onError: { (error) in
            print(error)
        }
        .disposed(by: disposeBag)
    }
    
}
