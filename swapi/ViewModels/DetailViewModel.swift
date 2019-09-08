//
//  DetailViewModel.swift
//  swapi
//
//  Created by Nicolas Desormiere on 8/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import RxSwift
import RxCocoa

class DetailViewModel: ViewModelType {
    
    struct Input {
        let refresh: AnyObserver<Void>
        let peopleURLs: AnyObserver<[String]>
    }
    
    struct Output {
        let peopleResult: Driver<[People]>
        let isLoading: Driver<Bool>
    }
    
    private struct Subject {
        let refresh = PublishSubject<Void>()
        let peopleURLs = BehaviorSubject<[String]>(value: [])

        let peopleResult = BehaviorSubject<[People]>(value: [])
        let isLoading = BehaviorSubject<Bool>(value: false)
    }
    
    private let subject = Subject()
    private let disposeBag = DisposeBag()
    
    let output: Output
    let input: Input
    
    // Life cycle
    
    init() {
        
        input = Input(
            refresh: subject.refresh.asObserver(),
            peopleURLs: subject.peopleURLs.asObserver()
        )
        
        output = Output(
            peopleResult: subject.peopleResult.asDriver(onErrorJustReturn: []),
            isLoading: subject.isLoading.asDriver(onErrorJustReturn: false)
        )
        
        setup()
    }
    
    private func setup() {
        Observable.combineLatest(subject.peopleURLs, subject.refresh)
            .do(onNext: { [weak self] (ulrs, _) in
                guard let `self` = self else { return }
                self.subject.isLoading.onNext(true)
            })
            .flatMap({ (urls, _) in
                ServiceManager.loadPeople(with: urls)
            })
            .subscribe(onNext: { [weak self] result in
                guard let `self` = self else { return }
                self.subject.isLoading.onNext(false)
                self.subject.peopleResult.onNext(result)
            })
            .disposed(by: self.disposeBag)
    }
    
}
