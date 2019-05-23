//
//  MovieService.swift
//  Movie Database
//
//  Created by Michael Detrick on 5/23/19.
//  Copyright © 2019 OneSky. All rights reserved.
//

import Foundation

class MovieService: API, Service {

  typealias Model = Movie
  
  var api: API
  
  var searchPath: String = "search/movie"
  
  init(api: API) {
    self.api = api
  }

}
