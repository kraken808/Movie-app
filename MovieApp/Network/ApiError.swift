//
//  ApiError.swift
//  MovieApp
//
//  Created by Murat Merekov on 04.02.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation

enum ApiError: Error,LocalizedError {
    case connectionEror
    case message(String)
    case other
    case errorFetchingdata
    
    var errorDescription: String? {
        switch self {
        case .connectionEror:
            return "No Internet connection"
        case .other:
            return "Something went wrong"
        case .errorFetchingdata:
                return "Did not receive data"
        case .message(let message):
            return message
        }
    }
   
    
}
