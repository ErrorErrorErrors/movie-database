//
//  Models.swift
//  Movie Database
//
//  Created by Michael Detrick on 5/23/19.
//  Copyright © 2019 OneSky. All rights reserved.
//

import Foundation

protocol Item {
  var voteAverage: Double { get }
}

struct ModelResult<T: Decodable>: Decodable {
  let results: [T]
}
