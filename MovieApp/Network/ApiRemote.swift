//
//  ApiRemote.swift
//  MovieApp
//
//  Created by Murat Merekov on 04.02.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit

class ApiRemote{
   static let shared = ApiRemote()
   private  let baseUrl = "https://api.themoviedb.org"
   private  let pathMovie = "/3/movie/popular"
   private  let pathImage = "/t/p/w500"
   private  let apiKey = "?api_key=8b82f416093cf29ab75ae07cc5b416dd"
   private let som = "https://image.tmdb.org/t/p/w500"
    func urlMovie()->String{
        return (baseUrl + pathMovie)
    }
    func urlPoster(path: String)->String{
        return (som + path)
    }
}
