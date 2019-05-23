//
//  ViewModel.swift
//  Movie Database
//
//  Created by Michael Detrick on 5/23/19.
//  Copyright © 2019 OneSky. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ViewModel {
  
  let api = API()
  
  lazy var movieService: MovieService = { MovieService(api: api) }()
  lazy var tvShowService: TVShowService = { TVShowService(api: api) }()
  lazy var personService: PersonService = { PersonService(api: api) }()
  
  fileprivate let movies = BehaviorRelay<[Movie]>(value: [])
  fileprivate let shows = BehaviorRelay<[TVShow]>(value: [])
  fileprivate let people = BehaviorRelay<[Person]>(value: [])
  // Data structure exposed to the controller
  let items = BehaviorRelay<[Item]>(value: [])
  // Search term
  let query = BehaviorRelay<String?>(value: nil)
  // TODO: Handle errors
  let error = BehaviorRelay<Error?>(value: nil)
  let disposeBag = DisposeBag()
  
  init() {
    // Aggregate the results into a single data structure
    Observable.combineLatest(
      movies.asObservable(),
      shows.asObservable(),
      people.asObservable(),
      resultSelector: { ($0, $1, $2)
    }).map({ result -> [Item] in
      return result.0 + result.1 + result.2
    }).bind(to: self.items).disposed(by: disposeBag)
  }
  
  func search() {
    // Ignore empty queries
    guard let query = self.query.value, !query.isEmpty else {
      return
    }
    
    fetchMovies(for: query)
    fetchShows(for: query)
    fetchPeople(for: query)
  }
  
  fileprivate func fetchMovies(for query: String) {
    movieService.search(query: query) { result in
      switch result {
      case .success(let movies):
        self.movies.accept(movies)
      case .failure(let error):
        self.error.accept(error)
      }
    }
  }
  
  fileprivate func fetchShows(for query: String) {
    tvShowService.search(query: query) { result in
      switch result {
      case .success(let shows):
        self.shows.accept(shows)
      case .failure(let error):
        self.error.accept(error)
      }
    }
  }
  
  fileprivate func fetchPeople(for query: String) {
    personService.search(query: query) { result in
      switch result {
      case .success(let people):
        self.people.accept(people)
      case .failure(let error):
        self.error.accept(error)
      }
    }
  }
}
