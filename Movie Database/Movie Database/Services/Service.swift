//
//  Service.swift
//  Movie Database
//
//  Created by Michael Detrick on 5/23/19.
//  Copyright © 2019 OneSky. All rights reserved.
//

import Foundation

protocol Service {
  associatedtype Model: Decodable
  
  typealias Completion = (ServiceResult<[Model]>) -> Void
  
  var api: API { get }
  var searchPath: String { get }
  
  func search(query: String, completion: @escaping Completion)
}

extension Service {
  func search(query: String, completion: @escaping Completion) {
    do {
      let request = try api.request(method: .get, path: searchPath, query: "query=\(query)")

      let task = api.client.dataTask(with: request) { (data, response, error) in
        if let error = error {
          completion(ServiceResult.failure(error))
          return
        }
        
        guard let data = data else {
          completion(ServiceResult.failure(ResponseError.invalidData("No data")))
          return
        }
        
        do {
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd"
          decoder.dateDecodingStrategy = .formatted(formatter)
          let obj = try decoder.decode(ModelResult<Model>.self, from: data)
          completion(ServiceResult.success(obj.results))
        } catch {
          completion(ServiceResult.failure(error))
        }
      }
      
      task.resume()
    } catch {
      completion(ServiceResult.failure(error))
    }
  }
}
