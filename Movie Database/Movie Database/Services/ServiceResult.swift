//
//  ServiceResult.swift
//  Movie Database
//
//  Created by Michael Detrick on 5/23/19.
//  Copyright © 2019 OneSky. All rights reserved.
//

import Foundation

enum ServiceResult<T> {
  case success(T)
  case failure(Error)
}

extension ServiceResult: Equatable {
  public static func == (lhs: ServiceResult<T>, rhs: ServiceResult<T>) -> Bool {
    switch (lhs, rhs) {
    case (.success(_), .success(_)),
         (.failure(_), .failure(_)):
      return String(describing: lhs) == String(describing: rhs)
    default:
      return false
    }
  }
}
