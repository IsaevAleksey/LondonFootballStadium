//
//  Stadium.swift
//  LondonFootballStadium
//
//  Created by Алексей Исаев on 18.01.2023.
//

import Foundation

struct Response: Decodable {
    let response: [StadiumInfo]
}

struct StadiumInfo: Decodable {

    let name: String
    let address: String
    let capacity: Int
    let image: String

}


