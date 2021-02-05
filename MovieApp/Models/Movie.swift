//
//  Movie.swift
//  MovieApp
//
//  Created by Murat Merekov on 04.02.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation

struct Movie: Codable{
    var title: String
    var vote_average: Double
    var overview: String
    var release_date: String
    var poster_path: String
    var backdrop_path: String
}

struct Data: Codable{
    var results: [Movie]
}
