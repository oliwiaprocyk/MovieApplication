//
//  DetailsMovieVC.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 24/03/2023.
//

import UIKit
import Kingfisher

class DetailsMovieVC: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var viewModel = DetailsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setup() {
        backgroundImage.layer.opacity = 0.3
        backgroundImage.contentMode = .scaleAspectFill
        tableView.register(UINib(nibName: Constants.movieDetailsTableViewCellNibName, bundle: nil), forCellReuseIdentifier: Constants.movieDetailsTableViewCellIdentifier)
        tableView.register(UINib(nibName: Constants.movieInfoTableViewCellNibName, bundle: nil), forCellReuseIdentifier: Constants.movieInfoTableViewCellIdentifier)
        tableView.register(UINib(nibName: Constants.movieReviewTableViewCellNibName, bundle: nil), forCellReuseIdentifier: Constants.movieReviewTableViewCellIdentifier)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        view.backgroundColor = .black
        setupActivityIndicator()
        if let movieID = viewModel.movieID {
            viewModel.getMovieDetail(movieID: movieID)
            viewModel.getTrailers(movieID: movieID)
            viewModel.getCast(movieID: movieID)
            viewModel.getSimilarMovies(movieID: movieID)
        }
    }
    
    func getID(id: Int) {
        viewModel.movieID = id
    }
}

extension DetailsMovieVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: Constants.movieDetailsTableViewCellIdentifier) as! MovieDetailsTVCell
        tableCell.delegate = self
        
        switch indexPath.section {
        case 0:
            let tableCell = tableView.dequeueReusableCell(withIdentifier: Constants.movieInfoTableViewCellIdentifier, for: indexPath) as! MovieInfoTVCell
            tableCell.backgroundColor = .clear
            if let movie = viewModel.movie {
                tableCell.setCell(with: movie)
            }
            return tableCell
        case 1:
            tableCell.reloadCollectionView(trailers: viewModel.trailers, section: 1)
            return tableCell
        case 2:
            tableCell.reloadCollectionView(cast: viewModel.cast, section: 2)
            tableCell.delegate = self
            return tableCell
        case 3:
            tableCell.reloadCollectionView(similarMovies: viewModel.similarMovies, section: 3)
            return tableCell
        case 4:
            let tableCell = tableView.dequeueReusableCell(withIdentifier: Constants.movieReviewTableViewCellIdentifier, for: indexPath) as! MovieReviewTVCell
            tableCell.reviewButtonTapped(UIButton())
            tableCell.delegate = self
            return tableCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 4:
            return 70
        default:
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Trailers"
        case 2:
            return "Top Billed Cast"
        case 3:
            return "Similar movies"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 0, y: 0, width: 300, height: 20)
        myLabel.font = UIFont.boldSystemFont(ofSize: 20)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        myLabel.textColor = .white
        let headerView = UIView()
        headerView.addSubview(myLabel)
        return headerView
    }
}

extension DetailsMovieVC: DetailsVMDelegate {
    func startActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func success() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func successDetails() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.backgroundImage.contentMode = .scaleAspectFill
            if let backPath = self.viewModel.movie?.backdropPath {
                let urlBackground = URL(string: "https://image.tmdb.org/t/p/w500\(backPath)")
                self.backgroundImage.kf.setImage(with: urlBackground)
            }
        }
    }
    
    func error(error: String) {
        let alert = UIAlertController(title: "Alert", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension DetailsMovieVC: MovieDetailsTVCellDelegate {
    func didSelectItemAt(movie: Movie) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.storyboardIdDetailsMovie) as? DetailsMovieVC {
            guard let movieID = movie.id else { return }
            vc.getID(id: movieID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func pushVC(url: String) {
        let youtubeUrl = NSURL(string:url)!
        if UIApplication.shared.canOpenURL(youtubeUrl as URL) {
            UIApplication.shared.open(youtubeUrl as URL)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Video could not be load", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension DetailsMovieVC: MovieReviewTVCellDelegate {
    func buttonTapped() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.storyboardIdReviewMovie) as? ReviewVC {
            guard let movieID = viewModel.movieID else { return }
            vc.getID(movieID: movieID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
