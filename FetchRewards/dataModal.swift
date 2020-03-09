//
//  dataModal.swift
//  FetchRewards
//
//  Created by tejasree vangapalli on 3/5/20.
//  Copyright © 2020 tejasree vangapalli. All rights reserved.
//

import Foundation

// Decoder //Stuct will be faster than class
// Codable protocol to confirm the decodable or encodable. If we don't confirm the protocol we don't get the data from JSONDecoder
struct dataModal: Codable {
    // json data keys 
    var id: Int?
    var listId: Int?
    var name: String?
}

