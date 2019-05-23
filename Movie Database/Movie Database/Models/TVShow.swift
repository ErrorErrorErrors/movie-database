//
//  TVShow.swift
//  Movie Database
//
//  Created by Michael Detrick on 5/23/19.
//  Copyright © 2019 OneSky. All rights reserved.
//

import Foundation

struct TVShow: Codable {
  let name: String
  let backdropPath: String?
  let releaseDate: Date?
  let voteAverage: Double
}

extension TVShow: Item {
  
}
