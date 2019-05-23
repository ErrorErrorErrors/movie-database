//
//  API.swift
//  Movie Database
//
//  Created by Michael Detrick on 5/23/19.
//  Copyright © 2019 OneSky. All rights reserved.
//

import Foundation

// https://api.themoviedb.org/3/search/movie?api_key=&language=en-US&query=goodfellas&page=1&include_adult=false

enum HTTPMethod: String {
  case get = "GET"
}

enum RequestError: Error {
  typealias RawValue = String
  case invalidURL(String)
}

enum ResponseError: Error {
  typealias RawValue = String
  case invalidData(String)
}

class API {
  let scheme: String = "https"
  let host: String = "api.themoviedb.org"
  let version: String = "3"
  let apiKey: String = "c352da303cecea898250194bd5cc0dc5"
  
  var defaultQuery: String {
    return "api_key=\(apiKey)&language=en-US&include_adult=false"
  }
  
  var baseURL: URL? {
    return URL(string: "\(scheme)://\(host)/\(version)")
  }
  
  var client: URLSession {
    return URLSession.shared
  }
 
  func urlBuilder(path: String, query: String) -> URL? {
    guard let baseURLString = baseURL?.absoluteString else {
      return nil
    }
    
    return URL(string: "\(baseURLString)/\(path)?\(defaultQuery)&\(query)")
  }
  
  func request(method: HTTPMethod, path: String, query: String = "") throws -> URLRequest {
    guard let url = urlBuilder(path: path, query: query) else {
      throw RequestError.invalidURL("")
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    
    return request
  }
}
