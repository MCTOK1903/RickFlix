//
//  MovieListViewController.swift
//  LoodosFlix
//
//  Created by Celal Tok on 12.05.2021.
//

import UIKit
import Alamofire

class MovieListViewController: UIViewController {
    
    // MARK: Properties
    
    private var viewModel: MovielistProtocol = MovieListViewModel(service: Services())
    
    // MARK: View
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        return searchBar
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        setUpUI()
    }
    
    
    func setUpUI() {
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UISearchBarDelegate
extension MovieListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchKey = searchBar.text  {
            viewModel.searchMovie(movieName: searchKey) { [weak self] movie in
                guard let self = self else { return }
                print(movie)
            } onError: { error in
                print(error)
            }
        }
    }
}
