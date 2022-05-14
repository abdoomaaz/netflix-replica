//
//  UpcomingViewController.swift
//  Netflix
//
//  Created by AbdooMaaz's playground on 23.04.22.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var contentTable: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    private var shows = [Show]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        //navigationController?.navigationItem.largeTitleDisplayMode = .always
      
        view.addSubview(contentTable)
        fetchUpcomingShows()
        contentTable.delegate = self
        contentTable.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentTable.frame = view.bounds
    }
    
    private func fetchUpcomingShows(){
        TmdbApiCaller.shared.getUpcomingMovies { [weak self] results in
            switch results {
            case .success(let returnedShows):
                self?.shows = returnedShows
                DispatchQueue.main.async {
                    self?.contentTable.reloadData()
            }
                case .failure(let err):
                    print(err)
            }
                
        }
    }
}


//MARK: tableview Delegation and datasouring
extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = shows[indexPath.row].original_title ?? shows[indexPath.row].original_name ??  "Unknown"
        return cell
    }
    
    
}
