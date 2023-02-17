//
//  ViewController.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import UIKit

class NewsViewController: UIViewController {

    private var articles = [Article]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAuth()
        tuneTableView()
        fetchNews()
    }
    
    private func checkAuth() {
        if FirebaseManager.shared.checkAuth() {
            return
        } else {
            let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "LoginViewController")
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
    }
    
    private func tuneTableView() {
        
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /// Fetching news at launch and after refreshing
    private func fetchNews() {
        NewsManager.shared.getNews { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch news: \(error)")
            }
        }
    }
}

// MARK: - TableView DataSource & Delegate

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            preconditionFailure("Failed to dequeue reusable cell")
        }
        cell.configure(with: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
