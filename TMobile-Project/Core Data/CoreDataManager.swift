//
//  CoreDataManager.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    let storeType: String? //= NSSQLiteStoreType // set to NSInMemoryStoreType in unit tests

    init(storeType: String? = nil) {
        self.storeType = storeType
    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GitHub")
        if let storeType = self.storeType {
            let description = NSPersistentStoreDescription()
            description.type = storeType
            container.persistentStoreDescriptions = [description]
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Could not load persistent store \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func retrieveUserReposCount() -> Int {
        let fetchRequest = NSFetchRequest<Repo>(entityName: "Repo")
        do {
            let repos = try persistentContainer.viewContext.fetch(fetchRequest)
            return repos.count
        }
        catch {
            return 0
        }
    }
    
    func fetchUserInfo(userName: String) -> UserInfo? {
        let fetchRequest = NSFetchRequest<UserInfo>(entityName: "UserInfo")
        let predicate = NSPredicate(format: "login = %@", userName)
        fetchRequest.predicate = predicate
        let userInfos = try? persistentContainer.viewContext.fetch(fetchRequest)
        return userInfos?.first
    }
    

    
    func saveUserInfo(_ userName: String) {
        let context = persistentContainer.viewContext
        let userInfo = UserInfo(context: context)
        userInfo.login = userName
        do {
            try saveContext()
        } catch {}
    }
    
    func isUserInfoSaved(_ userName: String) -> Bool {
        let fetchRequest = NSFetchRequest<UserInfo>(entityName: "UserInfo")
        let predicate = NSPredicate(format: "login = %@", userName)
        fetchRequest.predicate = predicate
        guard let userInfos = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return false
        }
        return userInfos.count != 0
    }
    
    
    func saveContext() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try context.save()
        }
    }
}
