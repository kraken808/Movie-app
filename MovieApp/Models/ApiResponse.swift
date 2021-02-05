//
//  ApiResponse.swift
//  MovieApp
//
//  Created by Murat Merekov on 04.02.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation


struct ApiResponse: Codable{
    var status_code: Int
    var status_message: String
}
