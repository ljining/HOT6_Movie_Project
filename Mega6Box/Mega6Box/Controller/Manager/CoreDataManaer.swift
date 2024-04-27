//
//  CoreDataManager.swift
//  Mega6Box
//
//  Created by 김태담 on 4/24/24.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()  // 싱글톤 인스턴스 생성

    private init() {}  // private 초기화 방지 외부 생성

    // Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Mega6Box")  // 데이터 모델 이름
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    // Context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data CRUD Operations

    // Create
    func createMega6Box(date: Date, personnel: Int16, Id: Int64) {
        let newMega6Box = Mega6Box(context: context)
        newMega6Box.date = date
        newMega6Box.personnel = personnel
        newMega6Box.id = Id

        saveContext()
    }

    // Read
    func fetchMega6Boxes() -> [Mega6Box] {
        let fetchRequest: NSFetchRequest<Mega6Box> = Mega6Box.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }

    // Update
    func updateMega6Box(mega6Box: Mega6Box, newDate: Date, newPersonnel: Int16, Id: Int64) {
        mega6Box.date = newDate
        mega6Box.personnel = newPersonnel
        mega6Box.id = Id
        saveContext()
    }

    // Delete
    func deleteMega6Box(mega6Box: Mega6Box) {
        context.delete(mega6Box)
        saveContext()
    }

    // Save Context
    private func saveContext () {
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
