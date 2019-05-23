//
//  Movie.swift
//  Movie Database
//
//  Created by Michael Detrick on 5/23/19.
//  Copyright © 2019 OneSky. All rights reserved.
//

import Foundation

struct Movie: Codable {
  let title: String
  let backdropPath: String?
  let releaseDate: Date?
  let voteAverage: Double
}

extension Movie: Item {
  
}
