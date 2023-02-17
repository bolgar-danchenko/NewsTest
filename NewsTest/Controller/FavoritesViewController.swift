//
//  FavoritesViewController.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tuneCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    private func tuneCollectionView() {
        collectionView.register(FavoritesCollectionViewCell.nib(), forCellWithReuseIdentifier: FavoritesCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CoreDataManager.shared.favoriteArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCollectionViewCell.identifier, for: indexPath) as? FavoritesCollectionViewCell else {
            preconditionFailure("Failed to dequeue reusable cell")
        }
        cell.configure(with: CoreDataManager.shared.favoriteArticles[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let favoriteArticle = CoreDataManager.shared.favoriteArticles[indexPath.row]
        let article = Article(title: favoriteArticle.title, content: favoriteArticle.content, url: favoriteArticle.url, urlToImage: favoriteArticle.imageUrlString, publishedAt: favoriteArticle.dateString)
        ArticleViewController.show(in: self, with: article)
    }
}
