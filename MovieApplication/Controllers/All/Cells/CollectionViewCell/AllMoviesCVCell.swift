//
//  CVCell3.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 22/03/2023.
//

import UIKit
import Kingfisher

class AllMoviesCVCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        movieImageView.layer.cornerRadius = movieImageView.frame.size.height / 20
    }
    
    func setCell(movie: Movie) {
        self.titleLabel.text = movie.title
        if let path = movie.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            self.movieImageView.kf.setImage(with: url)
        }
    }
}
