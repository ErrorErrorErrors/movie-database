//
//  TVShowService.swift
//  Movie Database
//
//  Created by Michael Detrick on 5/23/19.
//  Copyright © 2019 OneSky. All rights reserved.
//

import Foundation

class TVShowService: API, Service {
  
  typealias Model = TVShow
  
  var api: API
  
  var searchPath: String = "search/tv"
  
  init(api: API) {
    self.api = api
  }
  
}
