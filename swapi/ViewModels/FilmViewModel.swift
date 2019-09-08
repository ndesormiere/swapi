//
//  FilmViewModel.swift
//  swapi
//
//  Created by Nicolas Desormiere on 8/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import RxSwift
import RxCocoa

enum FilmFilter {
    case recent
    case none
}

class FilmViewModel: ViewModelType {
    
    struct Input {
        let refresh: AnyObserver<Void>
        let filter: AnyObserver<FilmFilter>
    }
    
    struct Output {
        let filmResult: Driver<[FilmResult]>
        let isLoading: Driver<Bool>
    }
    
    private struct Subject {
        let refresh = PublishSubject<Void>()
        let filter = BehaviorSubject<FilmFilter>(value: .recent)

        let filmResult = BehaviorSubject<[FilmResult]>(value: [])
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
            filter: subject.filter.asObserver()
        )
        
        output = Output(
            filmResult: subject.filmResult.asDriver(onErrorJustReturn: []),
            isLoading: subject.isLoading.asDriver(onErrorJustReturn: false)
        )
        
        setup()
    }
    
    private func setup() {
        Observable.combineLatest(subject.filter, subject.refresh)
            .do(onNext: { [weak self] (filter, _) in
                guard let `self` = self else { return }
                self.subject.isLoading.onNext(true)
            })
            .flatMap { (filter, _) in
                ServiceManager.loadFilms(with: filter)
            }
            .subscribe(onNext: { [weak self] result in
                guard let `self` = self else { return }
                self.subject.isLoading.onNext(false)
                self.subject.filmResult.onNext(result)
            })
            .disposed(by: self.disposeBag)
    }
    
}
