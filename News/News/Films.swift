//
//  Films.swift
//  News
//
//  Created by Murat Merekov on 21.09.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import Foundation

struct Detail: Codable{
    var title: String
    var vote_average: Double
    var overview: String
    var release_date: String
    var poster_path: String
    var backdrop_path: String
}

struct TmdbData: Codable{
   
    var results: [Detail]
}
