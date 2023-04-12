//
//  CVCell5.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 28/03/2023.
//

import UIKit
protocol MovieInfoCVCellDelegate {
    func pushVC(url: String)
}

class MovieTrailersCVCell: UICollectionViewCell {
    @IBOutlet weak var backGroundImageView: UIImageView!
    
    var trailer: Trailer?
    var delegate: MovieInfoCVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        backGroundImageView.contentMode = .scaleAspectFit
        addTapGesture(view: backGroundImageView)
    }
    
    func setCell(with model: Trailer) {
        if let link = model.key {
            let url = URL(string: "https://img.youtube.com/vi/\(link)/hqdefault.jpg")
            backGroundImageView.kf.setImage(with: url)
        }
        self.trailer = model
    }
    
    func addTapGesture(view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action:  #selector(MovieTrailersCVCell.imageTapped(sender:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer){
        guard let trailer = trailer else { return }
        DispatchQueue.main.async {
            guard let key = trailer.key else { return }
            self.delegate?.pushVC(url: "http://www.youtube.com/watch?v=\(key)")
        }
    }
}
