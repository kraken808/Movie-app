//
//  NetworkManager.swift
//  News
//
//  Created by Murat Merekov on 21.09.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager{
    private static let endpoint = "https://api.themoviedb.org/3/movie/popular?api_key=8b82f416093cf29ab75ae07cc5b416dd&language=en-US&page=1"
    private static let baseUrl = "https://image.tmdb.org/t/p/w500"
    
    static func getNews(completion: @escaping ([Detail])->Void){
        AF.request(endpoint, method: .get).validate().responseData { (response) in
               
                 switch response.result{
                 case .success(let data):
                     print(data)
                     let jsonDecoder = JSONDecoder()
                     if let listofMovies = try? jsonDecoder.decode(TmdbData.self, from: data){
                     
                        let films = listofMovies.results
                         print(films)
                         completion(films)
                     }else{
                         print("errro")
                     }
                 case .failure(let error):
                     print("salam")
                     print(error.localizedDescription)
                 }
             }
    }
 
        static func getImage(imageURL: String, completion: @escaping (UIImage) -> Void) {
              AF.request(baseUrl + imageURL).validate().responseData { (response) in
                       switch response.result{
                                              case .success(let data):
                                                  if let filmImage = UIImage(data: data){
                                                      completion(filmImage)
                                             }
                                              case .failure(let error):
                                                  print(error.localizedDescription)
                                              }
                     }
              }
    
}
