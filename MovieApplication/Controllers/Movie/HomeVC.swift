//
//  ViewController.swift
//  MovieApplication
//
//  Created by Oliwia Procyk on 17/03/2023.
//

import UIKit

class HomeVC: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    let viewModel = HomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        title = "Home"
        tableView.register(UINib(nibName: Constants.homeTableViewCellNibName, bundle: nil), forCellReuseIdentifier: Constants.homeTableViewCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        viewModel.getPopularMovie()
        viewModel.getTopMovie()
        viewModel.getUpcomingMovie()
        viewModel.getNowPlayingMovie()
        setupActivityIndicator()
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.homeTableViewCellIdentifier, for: indexPath) as! HomeTVCell
        cell.delegate = self
        
        switch indexPath.section {
        case 0:
            cell.setCell(movies: viewModel.popularMovies, section: 0)
        case 1:
            cell.setCell(movies: viewModel.topMovies, section: 1)
        case 2:
            cell.setCell(movies: viewModel.nowPlayingMovies, section: 2)
        case 3:
            cell.setCell(movies: viewModel.upcomingMovies, section: 3)
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0: return "Popular"
        case 1: return "Top rated"
        case 2: return "Now Playing"
        case 3: return "Upcoming"
        default: return "No more titles"
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
        let allButton = UIButton(frame: .zero)
        allButton.backgroundColor = .white
        allButton.frame = CGRect(x: 330, y: 0, width: 50, height: 20)
        allButton.layer.cornerRadius = allButton.frame.size.height / 10
        allButton.setTitle("All", for: .normal)
        allButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        allButton.setTitleColor(.black, for: .normal)
        allButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        headerView.addSubview(allButton)
        
        allButton.tag = section
        if section == 2 {
            allButton.isHidden = true
        }
        return headerView
    }
    
    @objc func buttonAction(_ sender: UIButton!) {
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.storyboardIdAllMovies) as? AllMoviesVC
        
        switch sender.tag {
        case 0:
            vc?.getModel(request: .popular)
        case 1:
            vc?.getModel(request: .top)
        case 3:
            vc?.getModel(request: .upcoming)
        default:
            break
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .black
            headerView.backgroundView?.backgroundColor = .black
            headerView.textLabel?.textColor = .white
        }
    }
}

extension HomeVC: HomeVMDelegate {
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
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension HomeVC: HomeTVCellDelegate {
    func doPagining() {
        self.viewModel.getPopularMovie()
        self.viewModel.getTopMovie()
        self.viewModel.getUpcomingMovie()
        self.viewModel.getNowPlayingMovie()
    }
    
    func didSelectRow(movie: Movie) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: Constants.storyboardIdDetailsMovie) as? DetailsMovieVC {
            guard let movieID = movie.id else { return }
            vc.getID(id: movieID)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
