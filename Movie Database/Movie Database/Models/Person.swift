//
//  Person.swift
//  Movie Database
//
//  Created by Michael Detrick on 5/23/19.
//  Copyright © 2019 OneSky. All rights reserved.
//

import Foundation

struct Person: Codable {
  let name: String
  let profilePath: String?
  let knownFor: [Media]
}

extension Person: Item {
  var voteAverage: Double {
    return knownFor.reduce(0, { $0 + $1.voteAverage })
  }
}
