//
//  CoreDataService.swift
//  YalantisTest
//
//  Created by Vitaliy Yefimchuk on 24.11.2021.
//

import UIKit
import CoreData

protocol DBServiceProtocol {
    func saveData(answer: PresentableAnswer)
    
    func loadData() -> [SavedAnswer]
    
    func updateData()
    
    func deleteData(for indexPath: Int)
    
    func subscribeOnEventsForDB()
}

class CoreDataService: DBServiceProtocol {
    
    private var tokens: [NSObjectProtocol] = []
    
    private let defaults = UserDefaults.standard
    
    lazy private var backgroundContext = persistentContainer.newBackgroundContext()
    
    func saveData(answer: PresentableAnswer) {
        
        let newAnswer = SavedAnswer(context: backgroundContext)
        newAnswer.title = answer.answerTitle
        newAnswer.message = answer.answerSubtitle
        newAnswer.date = .now
        newAnswer.isLocal = defaults.bool(forKey: DefaultsKey.straightPredictions)
        
        var savedAnswers = loadData()
        savedAnswers.append(newAnswer)
        
        do {
            try backgroundContext.save()
        } catch {
            print("error saving data: \(error)")
        }
    }
    
    func loadData() -> [SavedAnswer] {
        let request: NSFetchRequest<SavedAnswer> = SavedAnswer.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: backgroundContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        do {
            try fetchedResultsController.performFetch()
            let savedAnswerArray = fetchedResultsController.fetchedObjects ?? []
            return savedAnswerArray
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
        
    }
    
    func updateData() {
        //
    }
    
    func deleteData(for indexPath: Int) {
        let items = loadData()
        backgroundContext.delete(items[indexPath])
        
        saveContext()
    }
    
    deinit {
        tokens.forEach {
            NotificationCenter.default.removeObserver($0)
        }
    }
    
    // Core Data stack
    lazy private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DBService")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    // Core Data Saving support
    func saveContext () {
        if self.backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
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
        tokens.append(NotificationCenter.default.addObserver(
            forName: UIApplication.didEnterBackgroundNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let self = self else { return }
                
                if self.backgroundContext.hasChanges {
                    do {
                        try self.backgroundContext.save()
                    } catch {
                        print(error)
                    }
                }
            })
        )
    }
}
