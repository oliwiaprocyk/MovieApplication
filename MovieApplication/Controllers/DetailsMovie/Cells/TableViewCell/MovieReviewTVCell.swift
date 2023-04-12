//
//  MovieReviewTVCell.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 08/04/2023.
//

import UIKit
protocol MovieReviewTVCellDelegate {
    func buttonTapped()
}

class MovieReviewTVCell: UITableViewCell {
    var delegate: MovieReviewTVCellDelegate?

    @IBAction func reviewButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped()
    }
}
