//
//  CVCell2.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 21/03/2023.
//

import UIKit

class NowPlayingCVCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewUnderImage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        imageView.layer.cornerRadius = imageView.frame.size.height / 10
        imageView.clipsToBounds = true
        backgroundImage.layer.cornerRadius = backgroundImage.frame.size.height / 10
        backgroundImage.clipsToBounds = true
        viewUnderImage.clipsToBounds = false
        viewUnderImage.layer.shadowColor = UIColor.black.cgColor
        viewUnderImage.layer.shadowOpacity = 1
        viewUnderImage.layer.shadowOffset = CGSize.zero
        viewUnderImage.layer.shadowRadius = 10
        viewUnderImage.layer.shadowPath = UIBezierPath(roundedRect: viewUnderImage.bounds, cornerRadius: 10).cgPath
    }
    
    func setCell(with model: Movie) {
        self.textLabel.text = model.overview
        self.titleLabel.text = model.title
        if let path = model.posterPath, let backPath = model.backdropPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            self.imageView.kf.setImage(with: url)
            let urlBackground = URL(string: "https://image.tmdb.org/t/p/w500\(backPath)")
            self.backgroundImage.kf.setImage(with: urlBackground)
        }
    }
}
