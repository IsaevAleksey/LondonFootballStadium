//
//  StadiumsTableViewController.swift
//  LondonFootballStadium
//
//  Created by Алексей Исаев on 18.01.2023.
//

import UIKit

class StadiumsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStadiumslist()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }


    private func fetchStadiumslist() {
        
        var request = URLRequest(
            url: URL(string: "https://v3.football.api-sports.io/venues?city=london")!,
            timeoutInterval: 10.0)
        request.addValue("2d3297ddd732374c7f607d900b0d9c69", forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("v3.football.api-sports.io", forHTTPHeaderField: "x-rapidapi-host")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            do {
                let stadiums = try JSONDecoder().decode(Response.self, from: data)
                print(stadiums)
            } catch let error {
                print(error)
            }
        }.resume()
        
    }
    
}
