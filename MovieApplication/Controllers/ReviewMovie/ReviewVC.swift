//
//  ReviewVC.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 08/04/2023.
//

import UIKit

class ReviewVC: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var movieID: Int?
    let viewModel = ReviewVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        tableView.register(UINib(nibName: Constants.reviewTableViewCellNibName, bundle: nil), forCellReuseIdentifier: Constants.reviewTableViewCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        viewModel.delegate = self
        setupActivityIndicator()
        title = "Reviews"
        if let movieID = movieID {
            viewModel.getReview(movieID: movieID)
        }
    }
    
    func getID(movieID: Int) {
        self.movieID = movieID
    }
}

extension ReviewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reviewTableViewCellIdentifier, for: indexPath) as! ReviewTVCell
            cell.setCell(with: viewModel.review[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - (2 * height) {
            if let movieID = movieID {
                self.viewModel.getReview(movieID: movieID)
            }
        }
    }
}

extension ReviewVC: ReviewVMDelegate {
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
    
    func error(error: String) {
        let alert = UIAlertController(title: "Alert", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
