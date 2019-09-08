//
//  Films.swift
//  swapi
//
//  Created by Nicolas Desormiere on 8/9/19.
//  Copyright © 2019 Nicolas Desormiere. All rights reserved.
//

import Foundation

// MARK: - Films
struct Films: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var filmResults: [FilmResult]?
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case filmResults = "results"
    }
}

// MARK: - Result
struct FilmResult: Codable {
    var title: String?
    var episodeID: Int?
    var openingCrawl: String?
    var director: String?
    var producer: String?
    var releaseDate: String?
    var characters: [String]?
    var planets: [String]?
    var starships: [String]?
    var vehicles: [String]?
    var species: [String]
    var created: String?
    var edited: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case episodeID = "episode_id"
        case openingCrawl = "opening_crawl"
        case director
        case producer
        case releaseDate = "release_date"
        case characters
        case planets
        case starships
        case vehicles
        case species
        case created
        case edited
        case url
    }
}
