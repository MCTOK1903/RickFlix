//
//  MovieDetailViewController.swift
//  LoodosFlix
//
//  Created by Celal Tok on 13.05.2021.
//

import UIKit
import Kingfisher
class MovieDetailViewController: UIViewController {
    
    // MARK: Properties
    
    private var movie: MovieDetail
    
    // MARK: View
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private let movieImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.backgroundColor = .white
        return image
    }()
    
    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var movieYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var movieReleasedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var ratedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var awardsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var directorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var wtiterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    private var actorsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .white
        return label
    }()
    
    // MARK: init
    
    init(movie: MovieDetail) {
        self.movie = movie
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setConstraints()
        setUpContent()
    }
    
    // MARK: funcs
    
    func setUpUI() {
        self.navigationController?.isNavigationBarHidden = false
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(movieImage)
        scrollView.addSubview(movieNameLabel)
        scrollView.addSubview(movieYearLabel)
        scrollView.addSubview(movieReleasedLabel)
        scrollView.addSubview(ratedLabel)
        scrollView.addSubview(awardsLabel)
        scrollView.addSubview(directorLabel)
        scrollView.addSubview(wtiterLabel)
        scrollView.addSubview(actorsLabel)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            movieImage.topAnchor.constraint(equalTo: scrollView.topAnchor,  constant: padding),
            movieImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            movieImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            movieImage.heightAnchor.constraint(equalToConstant: view.frame.height/2),
            
            movieNameLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: padding * 2),
            movieNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            movieNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            
            movieYearLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: padding * 2),
            movieYearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            movieYearLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            
            movieReleasedLabel.topAnchor.constraint(equalTo: movieYearLabel.bottomAnchor, constant: padding * 2),
            movieReleasedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            movieReleasedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            
            ratedLabel.topAnchor.constraint(equalTo: movieReleasedLabel.bottomAnchor, constant: padding * 2),
            ratedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            ratedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            
            awardsLabel.topAnchor.constraint(equalTo: ratedLabel.bottomAnchor, constant: padding * 2),
            awardsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            awardsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            
            directorLabel.topAnchor.constraint(equalTo: awardsLabel.bottomAnchor, constant: padding * 2),
            directorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            directorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            
            wtiterLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: padding * 2),
            wtiterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            wtiterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            
            actorsLabel.topAnchor.constraint(equalTo: wtiterLabel.bottomAnchor, constant: padding * 2),
            actorsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding * 2),
            actorsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding * 2),
            actorsLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding * 2)
        ])
    }
    
    func setUpContent() {
        title = movie.title
        let urlImage = URL(string: movie.poster)
        self.movieImage.kf.setImage(with: urlImage)
        self.movieNameLabel.text = "Movie Name: " + movie.title
        self.movieYearLabel.text = "Year: " +  movie.year
        self.movieReleasedLabel.text = "Released: " + movie.released
        self.ratedLabel.text = "Rated: " + movie.rated
        self.awardsLabel.text = "Awards: " + movie.awards
        self.directorLabel.text = "Director: " + movie.director
        self.wtiterLabel.text = "Writer: " + movie.writer
        self.actorsLabel.text = "Actors: " + movie.actors
    }
}
