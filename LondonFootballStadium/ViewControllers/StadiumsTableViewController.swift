//
//  StadiumsTableViewController.swift
//  LondonFootballStadium
//
//  Created by Алексей Исаев on 18.01.2023.
//

import UIKit

class StadiumsTableViewController: UITableViewController {

    private var stadiumList: [StadiumInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStadiumList()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stadiumList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let stadium = stadiumList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = stadium.name
        cell.contentConfiguration = content
        
        return cell
    }

 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stadiumInfoVC = segue.destination as? StadiumInfoViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        stadiumInfoVC.stadiumInfo = stadiumList[indexPath.row]
    }
}



extension StadiumsTableViewController {
    
    private func fetchStadiumList() {
        NetworkManager.shared.fetchStadiumList { [weak self] result in
            switch result {
            case .success(let stadiums):
                self?.stadiumList = stadiums.response
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
