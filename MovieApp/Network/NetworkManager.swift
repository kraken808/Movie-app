//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Murat Merekov on 04.02.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit


typealias JSON = [String: Any]

class NetworkManager:NSObject, URLSessionTaskDelegate, URLSessionDataDelegate {

    static let shared = NetworkManager()
  
    func get<T: Codable>(url: String, params: JSON = [:], completion: @escaping (Result<T,Error>) -> Void) {
        var queryItems = [] as [URLQueryItem]
        
        for (key,value) in params {
                       let item = URLQueryItem(name: key, value: String(describing: value))
                       queryItems.append(item)
        }
        var endpoint = URLComponents(string: url)
        endpoint?.queryItems = queryItems
        print(endpoint?.url)
        let request = URLRequest(url: (endpoint?.url!)!)
        let session = URLSession(configuration: .default,delegate: self, delegateQueue: nil)
      
         session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(ApiError.connectionEror))
                print(error!)
                return
            }
            guard let data = data else {
                completion(.failure(ApiError.errorFetchingdata))
                return
            }
            
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            
            guard status == 200 else {
                let statusResonse: ApiResponse
                
                do{
                    statusResonse = try JSONDecoder().decode(ApiResponse.self, from: data)
                    completion(.failure(ApiError.message(statusResonse.status_message)))
                } catch _ {
                    statusResonse = ApiResponse(status_code: -1, status_message: "Error fetching data!")
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        
        }.resume()
        session.finishTasksAndInvalidate()
    }
    

    
}
