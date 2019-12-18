//
//  CoreData-Tests.swift
//  TMobile-ProjectTests
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import XCTest
import CoreData
@testable import TMobile_Project

class CoreData_Tests: XCTestCase {
    
    var coreDataManager: CoreDataManager!
    
    override func setUp() {
        coreDataManager = CoreDataManager(storeType: NSInMemoryStoreType)
    }
    
    override func tearDown() {
        coreDataManager = nil
    }


    func test_No_UserInfo() {
        let userInfoArray = coreDataManager.fetchUserInfo()
        XCTAssertEqual(userInfoArray!.count, 0)
    }
    
    func test_UserInfo_Created() {

        var userInfo = coreDataManager.fetchUserInfo()
        XCTAssertEqual(userInfo!.count, 0)

        coreDataManager.saveUserInfo("blabla")
        userInfo = coreDataManager.fetchUserInfo()
        XCTAssertEqual(userInfo!.count, 1)
        
    }
    
    func test_User_Name_Exists() {
        XCTAssertFalse(coreDataManager.isUserInfoSaved("blabla"))
        coreDataManager.saveUserInfo("blabla")
        XCTAssertTrue(coreDataManager.isUserInfoSaved("blabla"))

    }




}
