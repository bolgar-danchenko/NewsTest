//
//  CoreDataManager.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 17.02.2023.
//

import Foundation
import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    public var favoriteArticles = [FavoriteArticle]()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var viewContext: NSManagedObjectContext {
        if let context = self.appDelegate?.persistentContainer.viewContext {
            return context
        } else {
            preconditionFailure()
        }
    }
    
    public func isSaved(article: Article) -> Bool {
        fetchSavedArticles()
        
        var isSaved = false
        
        for i in favoriteArticles {
            if i.url == article.url {
                isSaved = true
            }
        }
        return isSaved
    }
    
    public func saveArticle(article: Article) {
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "FavoriteArticle", in: viewContext) else { return }
        
        appDelegate?.persistentContainer.performBackgroundTask({ [weak self] context in
            
            let newValue = NSManagedObject(entity: entityDescription, insertInto: self?.viewContext)
            
            newValue.setValue(article.url, forKey: "url")
            newValue.setValue(article.title, forKey: "title")
            newValue.setValue(article.content, forKey: "content")
            newValue.setValue(article.urlToImage, forKey: "imageUrlString")
            newValue.setValue(article.publishedAt, forKey: "dateString")
            newValue.setValue(Date(), forKey: "timestamp")
            
            do {
                try self?.viewContext.save()
                self?.fetchSavedArticles()
            } catch {
                print("Failed to save article: \(error)")
            }
        })
    }
    
    public func fetchSavedArticles() {
        favoriteArticles.removeAll()
        
        let fetchRequest = NSFetchRequest<FavoriteArticle>(entityName: "FavoriteArticle")
        fetchRequest.fetchBatchSize = 1
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            for result in results {
                favoriteArticles.append(result)
            }
        } catch {
            print("Failed to fetch articles from CoreData: \(error)")
        }
    }
    
    public func removeArticle(article: Article) {
        let fetchRequest = NSFetchRequest<FavoriteArticle>(entityName: "FavoriteArticle")
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            for object in results {
                if object.url == article.url {
                    viewContext.delete(object)
                    try viewContext.save()
                    self.fetchSavedArticles()
                }
            }
        } catch {
            print("Failed to delete article: \(error)")
        }
    }
    
    public func removeAllFromCoreData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteArticle")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
