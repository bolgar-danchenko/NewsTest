//
//  NewsTableViewCell.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewsTableViewCell"
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    static func nib() -> UINib {
        return UINib(nibName: "NewsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeButton.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        contentLabel.text = article.content
        
        if let dateString = article.publishedAt {
            dateLabel.text = setupDate(dateString: dateString)
        }
        
        if let urlString = article.urlToImage {
            setupImage(urlString: urlString)
        }
        
//        if let isFavorite = article.isFavorite {
//            setupLikeButton(isFavorite: isFavorite)
//        }
    }
    
    @IBAction func didTapLikeButton(_ sender: UIButton) {
        
        
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
    
//    private func setupLikeButton(isFavorite: Bool) {
//        if isFavorite {
//            likeButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(UIColor(red: 1, green: 0.392, blue: 0.51, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
//        } else {
//            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
//        }
//    }
}
