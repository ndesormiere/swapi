//
//  ServiceManager.swift
//  swapi
//
//  Created by Nicolas Desormiere on 8/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import RxSwift

class ServiceManager: NSObject {
    class func loadFilms(with filter: FilmFilter) -> Single<[FilmResult]> {
        return Single.create(subscribe: { (observer) -> Disposable in
            Caching.shared.fetchFilms() { films in
                if let films = films, let result = films.filmResults {
                    observer(.success(result))
                }
            }
            NetworkManger.requestForType(serviceType: .serviceLoadFilms, params: nil) { (response) in
                switch response.result {
                case .success:
                    if let data = response.data {
                        let res = try? JSONDecoder().decode(Films.self, from: data)
                        if let films = res, let filmResults = films.filmResults {
                            switch filter {
                            case .recent:
                                Caching.shared.saveFilms(films)
                                observer(.success(orderingRecent(filmResults)))
                            case .none:
                                observer(.success(filmResults))
                            }
                        } else {
                            observer(.success([]))
                        }
                    }
                case .failure(let error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        })
    }
    
    // ordering should be done by server by specifying a param
    static func orderingRecent(_ films: [FilmResult]) -> [FilmResult] {
        return films.sorted(by: { $0.created ?? "" < $1.created ?? "" })
    }
    
    class func loadPeople(with urls: [String]) -> Single<[People]> {
        return Observable
            .from(urls.compactMap { loadPeople(with: $0) })
            .merge()
            .flatMap { Single.just($0) }
            .toArray()
    }
    
    static private func loadPeople(with url: String) -> Single<People> {
        return Single.create(subscribe: { (observer) -> Disposable in
            Caching.shared.fetchPeople(for: url) { people in
                if let people = people {
                    observer(.success(people))
                }
            }
            NetworkManger.requestForType(serviceType: .serviceLoadPeople(url: url), params: nil) { (response) in
                switch response.result {
                case .success:
                    if let data = response.data {
                        let res = try? JSONDecoder().decode(People.self, from: data)
                        if let character = res, let key = character.url {
                            Caching.shared.savePeople(character, for: key)
                            observer(.success(character))
                        }
                    }
                case .failure(let error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        })
    }
}
