//
//  TableViewCell.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 06/04/2023.
//

import UIKit
import Kingfisher

class MovieInfoTVCell: UITableViewCell {
    @IBOutlet weak var bigTitleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusTypeLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var revenueAmountLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var viewUnderImage: UIView!
    
    var country = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        posterImageView.layer.cornerRadius = posterImageView.frame.size.height / 15
        viewUnderImage.clipsToBounds = false
        viewUnderImage.layer.shadowColor = UIColor.gray.cgColor
        viewUnderImage.layer.shadowOpacity = 1
        viewUnderImage.layer.shadowOffset = CGSize.zero
        viewUnderImage.layer.shadowRadius = 10
        viewUnderImage.layer.shadowPath = UIBezierPath(roundedRect: viewUnderImage.bounds, cornerRadius: 5).cgPath
    }
    
    func setCell(with model: DetailsModel) {
        setCountry(model)
        self.bigTitleLabel.text = model.title
        self.titleLabel.text = model.originalTitle
        self.movieOverviewLabel.text = model.overview
        if let path = model.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            self.posterImageView.kf.setImage(with: url)
        }
        self.statusLabel.text = "Status"
        self.revenueLabel.text = "Revenue"
        self.originalTitleLabel.text = "Original title"
        self.overviewLabel.text = "Overview"
        self.taglineLabel.text = model.tagline
        self.statusTypeLabel.text = model.status
        self.revenueAmountLabel.text = "$\(model.revenue ?? 0)"
        
        self.rateLabel.text = String(format:"%.1f", model.voteAverage ?? 0.0)
        self.rateLabel.layer.borderColor = UIColor.green.cgColor
        self.rateLabel.layer.borderWidth = 1.0
        self.rateLabel.layer.cornerRadius = rateLabel.frame.width/2
        
        self.languageLabel.text = "\(model.originalLanguage?.uppercased() ?? "")"
        self.languageLabel.layer.borderColor = UIColor.green.cgColor
        self.languageLabel.layer.borderWidth = 1.0
        
        self.dateLabel.text = "\(model.releaseDate?.prefix(4) ?? ""), "
        self.countryLabel.text = self.country
        self.typeLabel.text = getGenresNames(model)
    }
    
    private func setCountry(_ movie: DetailsModel) {
        if let countries = movie.productionCountries {
            for i in countries {
                if let country = i.iso31661 {
                    self.country = "\(country), "
                }
            }
        }
    }
    
    private func getGenresNames(_ movie: DetailsModel) -> String {
        var genresList = [String]()
        var genresString = ""
        if let genres = movie.genres {
            for i in genres {
                genresList.append(i.name ?? "")
            }
            genresString = genresList.joined(separator: ", ")
        }
        return genresString
    }
}
