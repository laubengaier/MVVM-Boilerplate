//
//  AppStep.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 13.10.20.
//

import RxFlow

enum AppStep: Step {
    
    case dashboard
    
    // MARK: Movies
    case movieList
    case movieDetail(id: Int)
    
    // MARK: Actors
    case actorList

}
