//
//  AllMoviesVC.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 22/03/2023.
//

import UIKit

enum RequestTypes {
    case popular
    case top
    case upcoming
}

class AllMoviesVC: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = AllMoviesVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        collectionView.register(UINib(nibName: Constants.allMoviesCollectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: Constants.allMoviesCollectionViewCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
        setupActivityIndicator()
    }
    
    func getModel(request: RequestTypes) {
        switch request {
        case .popular:
            self.viewModel.getPopularMovie()
            title = "Popular"
        case .top:
            self.viewModel.getTopMovie()
            title = "Top rated"
        case .upcoming:
            self.viewModel.getUpcomingMovie()
            title = "Upcoming"
        }
    }
}

extension AllMoviesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.allMoviesCollectionViewCellIdentifier, for: indexPath) as! AllMoviesCVCell
        cell.setCell(movie: viewModel.movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.storyboardIdDetailsMovie) as? DetailsMovieVC {
            guard let movieID = viewModel.movies[indexPath.item].id else { return }
            vc.getID(id: movieID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - (2 * height) {
            self.viewModel.getPopularMovie()
            self.viewModel.getTopMovie()
            self.viewModel.getUpcomingMovie()
        }
    }
}

extension AllMoviesVC: AllMoviesVMDelegate {
    func startActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func success() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func error(error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
