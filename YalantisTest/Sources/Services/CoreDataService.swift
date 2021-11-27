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
    
    func subscribeOnEventsForDB()
}

class CoreDataService: DBServiceProtocol {
    
    var tokens: [NSObjectProtocol] = []
    
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
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        do {
            try fetchedResultsController.performFetch()
            self.savedAnswerArray = fetchedResultsController.fetchedObjects ?? []
            return savedAnswerArray
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
        
    }
    
    func updateData() {
        // TODO
    }
    
    func deleteData() {
        // TODO
    }
    

    
    deinit {
        tokens.forEach {
            print("deinit")
            NotificationCenter.default.removeObserver($0)
        }
    }
    
    // Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "DBService")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        print(container)
        return container
    }()
    
    // Core Data Saving support
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

// MARK: - Notifications
extension CoreDataService {
    func subscribeOnEventsForDB() {
        tokens.append(NotificationCenter.default.addObserver(forName: UIEventsEnum.didEnterBackground, object: nil, queue: .main, using: { [weak self] _ in
            print("Saved on persistance: \(self?.persistentContainer)")
            do {
                try self?.context.save()
            } catch {
                print(error)
            }
        }))
    }
}
