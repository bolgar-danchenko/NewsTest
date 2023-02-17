//
//  FavoritesCollectionViewCell.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 17.02.2023.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {

    static let identifier = "FavoritesCollectionViewCell"
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "FavoritesCollectionViewCell", bundle: nil)
    }
    
    func configure(with article: FavoriteArticle) {
        titleLabel.text = article.title
        
        if let dateString = article.dateString {
            dateLabel.text = setupDate(dateString: dateString)
        }
        
        if let urlString = article.imageUrlString {
            setupImage(urlString: urlString)
        }
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
}
