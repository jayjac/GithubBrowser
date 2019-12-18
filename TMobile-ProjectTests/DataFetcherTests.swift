//
//  DataFetcher.swift
//  TMobile-ProjectTests
//
//  Created by Jay Jac on 12/17/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import XCTest

class DataFetcherTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        var urlComponents = URLComponents(string: "https://api.github.com/search/users")!
        let queryItem = URLQueryItem(name: "q", value: "Tom+in:login")
        urlComponents.queryItems = [queryItem]
        guard let newURL = urlComponents.url else { return }
        print(newURL)
    }


}
