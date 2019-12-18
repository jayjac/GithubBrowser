//
//  LoadMoreTableViewCell.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoadMoreTableViewCell: UITableViewCell {
    
    private let disposeBag = DisposeBag()
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        listenToLoadMoreEvents()
    }
    
    override func prepareForReuse() {
        activityIndicator.startAnimating()
    }

    
    private func listenToLoadMoreEvents() {
        UserSearchManager.hasMoreResults.asDriver().distinctUntilChanged().drive(onNext: { (hasMore) in
            self.activityIndicator.isHidden = !hasMore

        }).disposed(by: disposeBag)
    }

}
