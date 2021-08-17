//
//  CoreDataManager.swift
//  PrivateEye
//
//  Created by Mayank Girdhar on 27/04/21.
// This core data structure logic was taken from an article on internet
// Link to the article https://dev.to/fmo91/persistence-with-core-data-and-swiftui-45g5

import Foundation
import SwiftUI
import CoreData
import Combine

final class PersistenceProvider{
    enum StoreType {
        case inMemory, persisted
    }
    
    static var managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle(for: PersistenceProvider.self)
        guard let url = bundle.url(forResource: "PrivateEye", withExtension: "momd") else {
            fatalError("Failed to locate momd file")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to load momd file")
        }
        return model
    }()
    
    let persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    static let `default`: PersistenceProvider = PersistenceProvider()
    init(storeType: StoreType = .persisted) {
        persistentContainer = NSPersistentContainer(name: "PrivateEye", managedObjectModel: Self.managedObjectModel)
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed loading persistent stores with error: \(error.localizedDescription)")
            }
        }
    }
}




extension PersistenceProvider {
    var caseEntityList: NSFetchRequest<CaseEntity> {
        let request: NSFetchRequest<CaseEntity> = CaseEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CaseEntity.date, ascending: false)]
        return request
    }
    
    @discardableResult
    func createCase(name: String, description: String, caseID: Int64, caseLocation: String, caseOffence: String) -> CaseEntity {
        let newCase = CaseEntity(context: context)
        newCase.caseName = name
        newCase.caseDescription = description
        newCase.date = Date()
        newCase.caseID = caseID
        newCase.location = caseLocation
        newCase.offence = caseOffence
        newCase.crimeCommitedDate = Date()
        try? context.save()
        return newCase
    }
    
    func editOffence(_ editEntry: CaseEntity, change: String){
        editEntry.offence = change
        try? context.save()
    }
    
    func editCaseName(_ editEntry: CaseEntity, change: String){
        editEntry.caseName = change
        try? context.save()
    }
    func editCaseDescription(_ editEntry: CaseEntity, change: String){
        editEntry.caseDescription = change
        try? context.save()
    }
    
    func editNote(_ editEntry: CaseEntity, change: String){
        editEntry.notes = change
        try? context.save()
    }

    func editCaseLocation(_ editEntry: CaseEntity, change: String){
        editEntry.location = change
        try? context.save()
    }
    func editDate(_ editEntry: CaseEntity, dateChange: Date){
        editEntry.crimeCommitedDate = dateChange
        try? context.save()
    }
    
    func deleteCase(_ lists: [CaseEntity]) {
        for list in lists {
            context.delete(list)
        }
        try? context.save()
    }
    
}

extension PersistenceProvider {
    func savedMediaRequest(for list: CaseEntity) -> NSFetchRequest<SavedMediaEntity> {
        let request: NSFetchRequest<SavedMediaEntity> = SavedMediaEntity.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(SavedMediaEntity.caseDetail), list)
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \SavedMediaEntity.date, ascending: false)
        ]
        return request
    }
    
    @discardableResult
    func saveMedia(description: String, url: String, in list: CaseEntity) -> SavedMediaEntity {
        let newMedia = SavedMediaEntity(context: context)
        newMedia.url = url
        newMedia.date = Date()
        newMedia.mediaDescription = description
        list.addToSavedMedia(newMedia) // THIS IS IMPORTANT
        try? context.save()
        return newMedia
    }
    
    func editMediaDescription(_ editEntry: SavedMediaEntity, change: String, in list: CaseEntity){
        editEntry.mediaDescription = change
        try? context.save()
    }


    
    func deleteMedia(_ media: [SavedMediaEntity]) {

        for selected in media {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            guard let targetURL = documentsDirectory?.appendingPathComponent(selected.url ?? "") else { return }
            try? FileManager.default.removeItem(at: targetURL)
            context.delete(selected)
            
        }
        try? context.save()
    }
}

//MARK: Suspect

extension PersistenceProvider {
    func suspectRequest(for list: CaseEntity) -> NSFetchRequest<SuspectList> {
        let request: NSFetchRequest<SuspectList> = SuspectList.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(SuspectList.toCaseEntity), list)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \SuspectList.suspectName, ascending: true)]
        return request
    }
    
    @discardableResult
    func saveSuspect(name: String, in list: CaseEntity) -> SuspectList{
        let newSuspect  = SuspectList(context: context)
        newSuspect.suspectName = name
        list.addToToSuspectList(newSuspect)
        try? context.save()
        return newSuspect
    }
    
    func delete(_ suspect: [SuspectList]){
        for suspectName in suspect{
            context.delete(suspectName)
        }
        try? context.save()
    }
    
}


extension FetchedResults {
    func get(_ indexSet: IndexSet) -> [Result] {
        var result = [Result]()
        for index in indexSet {
            result.append(self[index])
            print(self[index])
        }
        return result
    }
}



extension PersistenceProvider {
    var requestPassword: NSFetchRequest<Password> {
        let request: NSFetchRequest<Password> = Password.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Password.passcode, ascending: true)]
        return request
    }
    
    @discardableResult
    func setPassword(pass: String) -> Password{
        let newPass = Password(context: context)
        newPass.passcode = pass
        try? context.save()
        return newPass
    }
    
    func editPass(_ editEntry: Password, change: String){
        editEntry.passcode = change
        try? context.save()
    }
    
} //Pass Code Data Manager
