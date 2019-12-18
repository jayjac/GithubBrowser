//
//  SearchManager.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


/**
 * Abstract class that listens to changes in a SearchBar
 */
class SearchManager {
    
    private let searchBar: UISearchBar
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(searchBar: UISearchBar) {
        self.searchBar = searchBar
        listenToTextChanges()
    }
    
    private func listenToTextChanges() {
        searchBar.rx.text.asDriver()
            .throttle(.milliseconds(1000))
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (text) in
            guard let strongSelf = self, let text = text else { return }
            strongSelf.performSearchRequest(with: text)
        }).disposed(by: disposeBag)
    }
    
    func performSearchRequest(with text: String) {
        fatalError("Not implemented")
    }
}
