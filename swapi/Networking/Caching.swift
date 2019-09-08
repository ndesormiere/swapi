//
//  Caching.swift
//  swapi
//
//  Created by Nicolas Desormiere on 9/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import Foundation
import Cache

class Caching {
    
    static var shared = Caching()
    private init() {}
    
    private var filmsKey = "films"
    
    private var filmStorage = try! Storage(
        diskConfig: DiskConfig(name: "Films"),
        memoryConfig: MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10),
        transformer: TransformerFactory.forCodable(ofType: Films.self)
    )
    private var peopleStorage = try! Storage(
        diskConfig: DiskConfig(name: "People"),
        memoryConfig: MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10),
        transformer: TransformerFactory.forCodable(ofType: People.self)
    )
    
    func saveFilms(_ films: Films) {
        do {
            try filmStorage.setObject(films, forKey: filmsKey)
        } catch {
            print(error)
        }
    }
    
    func fetchFilms(completion: ((Films?) -> Void)?) {
        filmStorage.async.object(forKey: filmsKey) { result in
            switch result {
            case .value(let films):
                completion?(films)
            case .error:
                completion?(nil)
            }
        }
    }
    
    func savePeople(_ people: People, for key: String) {
        do {
            try peopleStorage.setObject(people, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func fetchPeople(for key: String, completion: ((People?) -> Void)?) {
        peopleStorage.async.object(forKey: key) { result in
            switch result {
            case .value(let people):
                completion?(people)
            case .error:
                completion?(nil)
            }
        }
    }
}
