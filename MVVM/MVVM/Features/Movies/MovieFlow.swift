//
//  MovieListFlow.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import UIKit

class MovieFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController: UINavigationController = {
        let nvc = UINavigationController()
        nvc.navigationBar.prefersLargeTitles = true
        return nvc
    }()
    private let movieStepper: MovieStepper
    private let services: AppServices

    init(withServices services: AppServices, andStepper stepper: MovieStepper) {
        self.services = services
        self.movieStepper = stepper
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }

        switch step {
        case .movieList:
            return navigateToMovieLists()
        case .movieDetail(let id):
            return navigateToMovieDetail(id: id)
        default:
            return .none
        }
    }

    private func navigateToMovieLists() -> FlowContributors {
        let vm = MovieListVM(services: services)
        let vc = MovieListVC(viewModel: vm)
        
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(
            flowContributor: .contribute(
                withNextPresentable: vc,
                withNextStepper: vm
            )
        )
    }
    
    private func navigateToMovieDetail(id: Int) -> FlowContributors {
        let vm = MovieDetailVM(services: services, movieId: id)
        let vc = MovieDetailVC(viewModel: vm)
        
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(
            flowContributor: .contribute(
                withNextPresentable: vc,
                withNextStepper: vm
            )
        )
    }

}

class MovieStepper: Stepper {

    let steps = PublishRelay<Step>()

}
