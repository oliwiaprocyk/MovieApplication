//
//  MovieCastCVCell.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 07/04/2023.
//

import UIKit
import Kingfisher

class MovieCastCVCell: UICollectionViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameAndSurname: UILabel!
    @IBOutlet weak var characterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.contentMode = .scaleAspectFit
    }
    
    func setCell(with model: Cast) {
        if let path = model.profilePath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            profileImage.kf.setImage(with: url)
        }
        self.nameAndSurname.text = model.name
        self.characterName.text = model.character
    }
}
