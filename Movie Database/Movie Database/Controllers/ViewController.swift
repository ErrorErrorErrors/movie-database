//
//  ViewController.swift
//  Movie Database
//
//  Created by Michael Detrick on 5/23/19.
//  Copyright © 2019 OneSky. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UITableViewController {

  let viewModel = ViewModel()
  let disposeBag = DisposeBag()
  
  // MARK: Outlets
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUIBind()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

  func setupUIBind() {
    // Update the table view anytime our data changes
    viewModel.items.asDriver().drive(
      onNext: { [weak self] _ in
        self?.tableView.reloadData()
      }
    ).disposed(by: disposeBag)
    
    // Store the text entered in the search bar to `viewModel.query`
    searchBar.rx.text
      .bind(to: viewModel.query)
      .disposed(by: disposeBag)
    
    // Perform search and close keyboard
    searchBar.rx.searchButtonClicked.asDriver().drive(
      onNext: { [weak self] in
        self?.viewModel.search()
        self?.searchBar?.resignFirstResponder()
      }
    ).disposed(by: disposeBag)
    
  }
}

