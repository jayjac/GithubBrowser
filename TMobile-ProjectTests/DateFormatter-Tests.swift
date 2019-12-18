//
//  DateFormatter-Tests.swift
//  TMobile-ProjectTests
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import XCTest
@testable import TMobile_Project

class DateFormatter_Tests: XCTestCase {



    func testExample() {
        let dateString = "2014-03-02T13:31:35Z"
        let formattedDateString = GitHubDateFormatter.formatDate(string: dateString)
        
    }



}
