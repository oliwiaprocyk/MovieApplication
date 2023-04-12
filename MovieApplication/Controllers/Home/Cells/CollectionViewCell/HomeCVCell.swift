//
//  CVCell.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 17/03/2023.
//

import UIKit
import Kingfisher

class HomeCVCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        movieImage.layer.cornerRadius = movieImage.frame.size.height / 10
    }
    
    func setCell(with model: Movie) {
        self.textLabel.text = model.title
        if let path = model.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            self.movieImage.kf.setImage(with: url)
        }
    }
}
