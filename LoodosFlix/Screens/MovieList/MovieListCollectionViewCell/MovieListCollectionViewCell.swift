//
//  MovieListCollectionViewCell.swift
//  LoodosFlix
//
//  Created by Celal Tok on 13.05.2021.
//

import UIKit
import Kingfisher

class MovieListCollectionViewCell: UICollectionViewCell {
    
    var movie: Search? {
        didSet {
            configureCellContent()
        }
    }
    
    private let movieImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        return iv
    }()
    
    private let verticalStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .vertical
        return sv
    }()
    
    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var movieYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.gray.cgColor
        
        configureCell()
    }
    
    private func configureCell() {
        contentView.addSubview(movieImage)
        contentView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(movieNameLabel)
        verticalStack.addArrangedSubview(movieYearLabel)
        
        movieImage.layer.cornerRadius = 16
        configureAutoLayoutConstraints()
    }
    
    private func configureAutoLayoutConstraints() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding ),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieImage.heightAnchor.constraint(equalToConstant: contentView.frame.height / 1.75),
            movieImage.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            
            verticalStack.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: padding),
            verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            verticalStack.widthAnchor.constraint(equalToConstant: contentView.frame.width - padding * 2),
            
            movieNameLabel.topAnchor.constraint(equalTo: verticalStack.topAnchor),
            movieNameLabel.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor),
            movieNameLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor),
            
            movieYearLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor),
            movieYearLabel.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor),
            movieYearLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor),
            movieYearLabel.bottomAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: -padding)
        ])
    }
    
    private func configureCellContent() {
        guard let movie = self.movie else { return }
        movieNameLabel.text = movie.title
        movieYearLabel.text = movie.year
        movieImage.kf.setImage(with: URL(string: movie.poster))
    }
}
