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
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        return searchBar
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let screenEmptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "There were no results."
        return label
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
    
    // MARK: Funcs
    
    func setUpUI() {
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        view.addSubview(spinner)
        view.addSubview(screenEmptyLabel)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,  constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            screenEmptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            screenEmptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func showAlert(error: String,completion: (() -> Void)? = nil ) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {
                UIAlertAction in
            completion?()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension MovieListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.spinner.startAnimating()
        if let searchKey = searchBar.text  {
            searchBar.endEditing(true)
            viewModel.searchMovie(movieName: searchKey) { [weak self] movie in
                guard let self = self else { return }
                
                self.spinner.stopAnimating()
                guard let movies = movie?.search else {
                    self.showAlert(error: (movie?.error)!)
                    self.movieListProvider.removeAllMovies()
                    self.collectionView.reloadData()
                    self.screenEmptyLabel.isHidden = false
                    return }
                self.movieListProvider.update(movies: movies)
                self.collectionView.reloadData()
                self.screenEmptyLabel.isHidden = true
            } onError: { error in
                self.showAlert(error: error.localizedDescription)
                print(error)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 , execute: {
                self.movieListProvider.removeAllMovies()
                self.collectionView.reloadData()
                self.screenEmptyLabel.isHidden = false
                searchBar.resignFirstResponder()
            })
        }
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
