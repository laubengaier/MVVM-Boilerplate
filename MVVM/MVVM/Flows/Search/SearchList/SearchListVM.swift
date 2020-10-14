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
    }
    
    func search(query: String) {
        self.services
            .movieService
            .search(query: query)
            .subscribe { (result) in
                self.data.accept(result)
            } onError: { (error) in
                print(error)
            }
            .disposed(by: self.disposeBag)
    }
    
    func showDetail(index: Int) {
        let movieId = data.value[index].id
        steps.accept(AppStep.movieDetail(id: movieId))
    }
    
}
