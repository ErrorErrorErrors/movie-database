//
//  PersonService.swift
//  Movie Database
//
//  Created by Michael Detrick on 5/23/19.
//  Copyright © 2019 OneSky. All rights reserved.
//

import Foundation

class PersonService: API, Service {
  
  typealias Model = Person
  
  var api: API
  
  var searchPath: String = "search/person"
  
  init(api: API) {
    self.api = api
  }
  
}
