//
//  RemoteDataUtils-Tests.swift
//  TMobile-ProjectTests
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import XCTest
@testable import TMobile_Project


class RemoteDataUtils_Tests: XCTestCase {

    func test_searchURLFor_Returns_Correct_URL() {
        let url = RemoteDataUtils.searchURLFor(userName: "john")
        XCTAssertNotNil(url)
        let outputURL = "https://api.github.com/search/users?q=john+in:login"
        XCTAssertEqual(url!.absoluteString, outputURL)
    }


    func test_extractGitHubUsers_works() {
        let json: String =
        """
        {
            "items": [
                {
                    "id": 12345678,
                    "login": "my_login",
                    "avatar_url": "www.avatar.com"
                }
            ]
        }
        """
        let data = json.data(using: .utf8)
        XCTAssertNotNil(data)
        let users = RemoteDataUtils.extractGitHubUsers(from: data!)
        XCTAssertNotNil(users)
        XCTAssertEqual(users!.count, 1)
    }
    
    func test_extractGitHubUsers_returns_nil_when_bad_json() {
        let badJSON: String =
        """
        {
            "items": [
                {
                    "id": 12345678
                    "login": "my_login",
                    "avatar_url": "www.avatar.com"
                }
            ]
        }
        """
        let data = badJSON.data(using: .utf8)
        XCTAssertNotNil(data)
        let users = RemoteDataUtils.extractGitHubUsers(from: data!)
        XCTAssertNil(users)
    }



}
