//
//  MovieListCollectionViewProvider.swift
//  LoodosFlix
//
//  Created by Celal Tok on 13.05.2021.
//

import UIKit

protocol MovieListCollectionViewProtocol {
    func update(movies: [Search])
}
protocol MovieListCollectionViewOutput: AnyObject {
    func onSelected(movieID: String)
    func getHight() -> CGFloat
}

final class MovieListCollectionViewProvider: NSObject {
    
    private lazy var movies: [Search] = []
    
    weak var delegate: MovieListCollectionViewOutput?
    
    var parentViewHeight: CGFloat = 0.0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(movies.count)
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MovieListCollectionViewCell else { return  UICollectionViewCell() }
        cell.movie = movies[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onSelected(movieID: movies[indexPath.item].imdbID)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let colums: CGFloat = 2
        let collectioViewWith = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (colums - 1)
        let adjustedWith = collectioViewWith - spaceBetweenCells
        let width: CGFloat = floor(adjustedWith / colums)
        let height = (delegate?.getHight() ?? 300.0 ) / 4
        return CGSize(width: width, height: height)
    }
}

extension MovieListCollectionViewProvider: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {}
extension MovieListCollectionViewProvider: MovieListCollectionViewProtocol {
    func update(movies: [Search]) {
        self.movies = movies
    }
}
