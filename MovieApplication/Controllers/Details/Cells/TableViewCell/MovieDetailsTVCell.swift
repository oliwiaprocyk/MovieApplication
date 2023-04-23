//
//  TVCell2.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 24/03/2023.
//

import UIKit
protocol MovieDetailsTVCellDelegate {
    func pushVC(url: String)
    func didSelectItemAt(movie: Movie)
}

class MovieDetailsTVCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movie: DetailsModel?
    var trailers: [Trailer] = []
    var cast: [Cast] = []
    var similarMovies: [Movie] = []
    var url: String?
    var delegate: MovieDetailsTVCellDelegate?
    var sections: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        collectionView.register(UINib(nibName: Constants.movieTrailersCollectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: Constants.movieTrailersCollectionViewCellIdentifier)
        collectionView.register(UINib(nibName: Constants.movieCastCollectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: Constants.movieCastCollectionViewCellIdentifier)
        collectionView.register(UINib(nibName: Constants.homeCollectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: Constants.homeCollectionViewCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
    }
    
    func reloadCollectionView(trailers: [Trailer], section: Int?) {
        self.trailers = trailers
        self.sections = section
        self.collectionView.reloadData()
    }
    
    func reloadCollectionView(cast: [Cast], section: Int?) {
        self.cast = cast
        self.sections = section
        self.collectionView.reloadData()
    }
    
    func reloadCollectionView(similarMovies: [Movie], section: Int?) {
        self.similarMovies = similarMovies
        self.sections = section
        self.collectionView.reloadData()
    }
}

extension MovieDetailsTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections {
        case 1:
            return trailers.count
        case 2:
            return cast.count
        case 3:
            return similarMovies.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.movieTrailersCollectionViewCellIdentifier, for: indexPath) as! MovieTrailersCVCell
            cell.setCell(with: trailers[indexPath.item])
            cell.delegate = self
            return cell
        case 2:
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.movieCastCollectionViewCellIdentifier, for: indexPath) as! MovieCastCVCell
            cell2.setCell(with: cast[indexPath.item])
            return cell2
        case 3:
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeCollectionViewCellIdentifier, for: indexPath) as! HomeCVCell
            cell3.setCell(with: similarMovies[indexPath.item])
            return cell3
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch sections {
        case 1:
            return CGSize(width: 265, height: 200)
        case 2:
            return CGSize(width: 90, height: 200)
        default:
            return CGSize(width: 100, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if sections == 3 {
            self.delegate?.didSelectItemAt(movie: similarMovies[indexPath.item])
        }
    }
}

extension MovieDetailsTVCell: MovieInfoCVCellDelegate {
    func pushVC(url: String) {
        delegate?.pushVC(url: url)
    }
}
