//
//  StadiumInfoViewController.swift
//  LondonFootballStadium
//
//  Created by Алексей Исаев on 20.01.2023.
//

import UIKit

class StadiumInfoViewController: UIViewController {
    
    var stadiumInfo: StadiumInfo!

    @IBOutlet var activitiIndicator: UIActivityIndicatorView!
    @IBOutlet var imageStadium: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var capacityLabel: UILabel!
    @IBOutlet var adressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activitiIndicator.startAnimating()
        activitiIndicator.hidesWhenStopped = true
        fetchImage()
        nameLabel.text = stadiumInfo.name
        capacityLabel.text = "Capacity: \(stadiumInfo.capacity)"
        adressLabel.text = "Adress: \(stadiumInfo.address)"
    }
    
    
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: stadiumInfo.image) { [weak self] result in
            switch result {
            case.success(let imageData):
                self?.imageStadium.image = UIImage(data: imageData)
                self?.activitiIndicator.stopAnimating()
            case.failure(let error):
                print(error)
            }
        }
    }
}
