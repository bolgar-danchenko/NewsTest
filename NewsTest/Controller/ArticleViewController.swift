//
//  ArticleViewController.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 17.02.2023.
//

import UIKit

class ArticleViewController: UIViewController {

    var article: Article?
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreDataManager.shared.fetchSavedArticles()
        configure()
    }
    
    @IBAction func didTapLikeButton(_ sender: UIButton) {
        if let article {
            if !CoreDataManager.shared.isSaved(article: article) {
                CoreDataManager.shared.saveArticle(article: article)
                likeButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(UIColor(red: 1, green: 0.392, blue: 0.51, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
            } else {
                CoreDataManager.shared.removeArticle(article: article)
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    static func show(in viewController: UIViewController, with article: Article) {
        if let articleController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController {
            articleController.article = article
            viewController.navigationController?.pushViewController(articleController, animated: true)
        }
    }
    
    private func configure() {
        
        if let article {
            titleLabel.text = article.title
            contentLabel.text = article.content
            
            if let dateString = article.publishedAt {
                dateLabel.text = setupDate(dateString: dateString)
            }
            
            if let urlString = article.urlToImage {
                setupImage(urlString: urlString)
            }
        }
        
        likeButton.setTitle("", for: .normal)
        setupLikeButton()
        
//        articleImageView.layer.cornerRadius = 22
//        articleImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//        articleImageView.layer.masksToBounds = true
    }
    
    private func setupImage(urlString: String) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    self?.articleImageView.image = UIImage(data: data)
                }
            }
            .resume()
        } else {
            articleImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
    }
    
    private func setupDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let date = dateFormatter.date(from: dateString) else { return "" }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        
        guard let finalDate = calendar.date(from: components) else { return "" }
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: finalDate)
    }
    
    private func setupLikeButton() {
        
        if let article {
            if !CoreDataManager.shared.isSaved(article: article) {
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            } else {
                likeButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(UIColor(red: 1, green: 0.392, blue: 0.51, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
            }
            
        }
    }

}
