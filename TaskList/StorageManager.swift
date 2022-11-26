//
//  StorageManager.swift
//  TaskList
//
//  Created by Buba on 19.11.2022.
//

import CoreData

final class StorageManager {
    static let shared = StorageManager()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
    func fetchData(complition: (Result<[Task], Error>) -> Void) {
        let fetchRequest = Task.fetchRequest()
        do {
            let taskList = try context.fetch(fetchRequest)
            complition(.success(taskList))
        } catch let error {
            print(error.localizedDescription)
            complition(.failure(error))
        }
    }
    
    func save(_ taskTitle: String, complition: (Result<Task, Error>) -> Void) {
        let task = Task(context: context)
        task.title = taskTitle
        complition(.success(task))
        saveContext()
    }
    
    func update(_ task: Task, newTitle: String) {
        task.title = newTitle
        saveContext()
    }
    
    func delete(_ task: Task) {
        context.delete(task)
        saveContext()
    }
    
    func saveContext() {
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
