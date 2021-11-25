//
//  CoreDataService.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 24.11.2021.
//

import Foundation
import CoreData

protocol DBServiceProtocol {
    func saveData(answer: PresentableAnswer)
        
    func loadData() -> [SavedAnswer]
    
    func updateData()
    
    func deleteData()
}

class CoreDataService: DBServiceProtocol {
    
    let defaults = UserDefaults.standard
    
    var savedAnswerArray = [SavedAnswer]()
    
    lazy var context = persistentContainer.viewContext
    
    func saveData(answer: PresentableAnswer) {
        
        let newAnswer = SavedAnswer(context: context)
        newAnswer.title = answer.answerTitle
        newAnswer.message = answer.answerSubtitle
        newAnswer.date = .now
        newAnswer.isLocal = defaults.bool(forKey: DefaultsKey.straightPredictions)
        
        savedAnswerArray.append(newAnswer)
        do {
            try context.save()
        } catch {
            print("error saving data: \(error)")
        }
    }
    
    func loadData() -> [SavedAnswer] {
        let request: NSFetchRequest<SavedAnswer> = SavedAnswer.fetchRequest()
        do {
            self.savedAnswerArray = try context.fetch(request)
            return savedAnswerArray
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
        
    }
    
    func updateData() {
        //
    }
    
    func deleteData() {
        //
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DBService")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
