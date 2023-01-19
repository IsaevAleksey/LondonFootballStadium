//
//  Stadium.swift
//  LondonFootballStadium
//
//  Created by Алексей Исаев on 18.01.2023.
//

import Foundation

struct Stadium: Decodable {

    let name: String
    let address: String
    let city: String
    let capacity: Int
    let image: String

}

struct Response: Decodable {
    let response: [Stadium]
}
