//
//  NewsManager.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import Foundation

class NewsManager {
    
    static let shared = NewsManager()
    
    private let urlString = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=4284fbbf091e43c9b535d40c10d778bd&pageSize=20"
    
    public func getNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error {
                completion(.failure(error))
            } else if let data {
                do {
                    let result = try JSONDecoder().decode(ApiResponse.self, from: data)
                    let newArticles = result.articles
                    completion(.success(newArticles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
