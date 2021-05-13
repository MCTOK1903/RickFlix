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
    
    private let viewModel: MovielistProtocol = MovieListViewModel(service: Services())
    private let movieListProvider: MovieListCollectionViewProvider = MovieListCollectionViewProvider()
    
    // MARK: View
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
//        searchBar.isTranslucent = false
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = movieListProvider
        collectionView.dataSource = movieListProvider
        
        movieListProvider.delegate = self
        searchBar.delegate = self
        
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,  constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - UISearchBarDelegate
extension MovieListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchKey = searchBar.text  {
            searchBar.endEditing(true)
            viewModel.searchMovie(movieName: searchKey) { [weak self] movie in
                guard let self = self, let movies = movie?.search else { return }
                self.movieListProvider.update(movies: movies)
                self.collectionView.reloadData()
            } onError: { error in
                print(error)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let movies: [Search] = []
        self.movieListProvider.update(movies: movies)
        self.collectionView.reloadData()
    }
}

// MARK: - MovieListCollectionViewOutput
extension MovieListViewController: MovieListCollectionViewOutput {
    func getHight() -> CGFloat {
        return view.bounds.height
    }
    
    func onSelected(movieID: String) {
        viewModel.getMovieDetail(movieID: movieID) { movieDetail in
            guard let movieDetail = movieDetail else { return }
            self.navigationController?.pushViewController(MovieDetailViewController(movie: movieDetail), animated: true)
        } onError: { error in
            //alert
        }
    }
}
