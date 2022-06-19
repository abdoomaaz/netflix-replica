//
//  HomeViewController.swift
//  Netflix
//
//  Created by AbdooMaaz's playground on 23.04.22.
//

import UIKit

class HomeViewController: UIViewController {
    private let headerTitles = ["Trending Movies", "Trending TV", "Popular", "Upcoming Movies", "Top Rated"]
    
    private let homeFeedTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTableView)
        homeFeedTableView.dataSource = self
        homeFeedTableView.delegate = self
        configureNavbar()
        
        homeFeedTableView.tableHeaderView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
    }
    
    func configureNavbar() {
        let netflixLogo = UIImage(named: "netflixLogo")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: netflixLogo, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTableView.frame = view.bounds
        
    }
    
    // Thanks to github & stackoverflow | Unsticks the navbar and shows it when back up
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
        // TODO: when scrolling up while in middle screen show nav bar
    }
}

// MARK: Tableview
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        headerTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // TODO: use case from array
        guard let headerView = view as? UITableViewHeaderFooterView else {return}
        headerView.textLabel?.font = .systemFont(ofSize: 18, weight:.semibold)
        headerView.textLabel?.text = headerView.textLabel?.text?.capitalizeFirstLetter()
        headerView.textLabel?.frame = CGRect(x: headerView.bounds.origin.x, y: headerView.bounds.origin.y, width: headerView.bounds.width, height: headerView.bounds.height)
        headerView.textLabel?.textColor = .secondaryLabel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {return UITableViewCell()}
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            TmdbApiCaller.shared.getTrendingMovies { results in
                switch results {
                    case .success(let shows): cell.configure(with: shows)
                    case .failure(let error): print(error)
                }
            }
        case Sections.TopRated.rawValue:
            TmdbApiCaller.shared.getTopRatedMovies { results in
                switch results {
                    case .success(let shows): cell.configure(with: shows)
                    case .failure(let error): print(error)
                }
            }
        case Sections.Popular.rawValue:
            TmdbApiCaller.shared.getPopularMovies { results in
                switch results {
                    case .success(let shows): cell.configure(with: shows)
                    case .failure(let error): print(error)
                }
            }
        case Sections.upcoming.rawValue:
            TmdbApiCaller.shared.getUpcomingMovies { results in
                switch results {
                    case .success(let shows): cell.configure(with: shows)
                    case .failure(let error): print(error)
                }
            }
        case Sections.TrendingTv.rawValue:
            TmdbApiCaller.shared.getTrendingTv { results in
                switch results {
                    case .success(let shows): cell.configure(with: shows)
                    case .failure(let error): print(error)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case upcoming = 3
    case TopRated = 4
}
