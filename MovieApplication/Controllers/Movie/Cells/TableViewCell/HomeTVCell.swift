//
//  TVCell.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 17/03/2023.
//

import UIKit
import Kingfisher

protocol HomeTVCellDelegate{
    func didSelectRow(movie: Movie)
}

class HomeTVCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [Movie] = []
    var section: Int?
    var delegate: HomeTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        collectionView.register(UINib(nibName: Constants.homeCollectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: Constants.homeCollectionViewCellIdentifier)
        collectionView.register(UINib(nibName: Constants.nowPlayingCollectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: Constants.nowPlayingCollectionViewCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setCell(movies: [Movie], section: Int) {
        self.movies = movies
        self.section = section
        collectionView.reloadData()
    }
}

extension HomeTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movies[indexPath.row]
        
        switch section {
        case 2:
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.nowPlayingCollectionViewCellIdentifier, for: indexPath) as! NowPlayingCVCell
            cell2.setCell(with: movie)
            return cell2
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeCollectionViewCellIdentifier, for: indexPath) as! HomeCVCell
            cell.setCell(with: movie)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch section {
        case 2:
            return CGSize(width: 330, height: 200)
        default:
            return CGSize(width: 100, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch section {
        case 0, 1, 3:
            delegate?.didSelectRow(movie: movies[indexPath.row])
        default:
            break
        }
    }
}
