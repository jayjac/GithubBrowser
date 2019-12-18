//
//  GitHubUserTests.swift
//  TMobile-ProjectTests
//
//  Created by Jay Jac on 12/17/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import XCTest
@testable import TMobile_Project

class GitHubUserTests: XCTestCase {


    
    func test_GitHubUser_is_decoded() {
        let json: String =
        """
        {
            "id": 12345678,
            "login": "my_login",
            "avatar_url": "www.avatar.com"
        }
        """
        let data = json.data(using: .utf8)
        XCTAssertNotNil(data)
        let decoder = JSONDecoder()
        let user = try? decoder.decode(GitHubUser.self, from: data!)
        XCTAssertNotNil(user)
        XCTAssertEqual(user!.avatarUrl, "www.avatar.com")
        XCTAssertEqual(user!.login, "my_login")
        XCTAssertEqual(user!.id, 12345678)
        XCTAssertNil(user!.repoCount)
    }


}
