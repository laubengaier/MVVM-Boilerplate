//
//  RxSwift+Extensions.swift
//  MVVM
//
//  Created by Timotheus Laubengaier on 16.10.20.
//

import Foundation
import RxSwift

public extension ObservableType {
    
    func flatMap<A: AnyObject, O: ObservableType>(
        weak obj: A,
        selector: @escaping (A, Self.Element) throws -> O
    ) -> Observable<O.Element> {
        return flatMap { [weak obj] value -> Observable<O.Element> in
            try obj.map { try selector($0, value).asObservable() } ?? .empty()
        }
    }
    
    func flatMapLatestWeak<A: AnyObject, O: ObservableConvertibleType>(
        weak obj: A,
        selector: @escaping (A, Element) throws -> O
    ) -> Observable<O.Element> {
        return flatMapLatest { [weak obj] value -> Observable<O.Element> in
            guard let strongObj = obj else {
                return Observable.empty()
            }
            return try selector(strongObj, value).asObservable()
        }
    }
    
}

class RxSwiftTester {
    
    let stringList = ["lul", "lel", "lol"]
    let disposeBag = DisposeBag()
    
    func test() {
        Observable.just(["lul"])
        .flatMap(weak: self) { (strongSelf, lel) -> Observable<[String]> in
            return .just(strongSelf.stringList)
        }
        .subscribe()
        .disposed(by: disposeBag)
        
        Observable.just(["lul"])
        .flatMapLatestWeak(weak: self, selector: { (strongSelf, stringList) -> Observable<[String]> in
            return .just(strongSelf.stringList)
        })
        .subscribe()
        .disposed(by: disposeBag)
    }
    
}
