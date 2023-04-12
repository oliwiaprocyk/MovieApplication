//
//  ReviewTVCell.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 10/04/2023.
//

import UIKit

class ReviewTVCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var smallUserNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        let cornerRadius: CGFloat = 5.0
        self.view.layer.cornerRadius = cornerRadius
        self.view.layer.masksToBounds = true
        self.contentView.backgroundColor = .clear
        self.starsLabel.layer.cornerRadius = cornerRadius
        self.starsLabel.layer.masksToBounds = true
    }
    
    func setCell(with model: Review) {
        self.userNameLabel.text = model.author
        self.starsLabel.text = "☆ \(model.authorDetails?.rating ?? 0)"
        self.smallUserNameLabel.text = model.author
        self.dateLabel.text = "\(model.createdAt?.prefix(10) ?? "")"
        self.reviewLabel.text = model.content
    }
}
