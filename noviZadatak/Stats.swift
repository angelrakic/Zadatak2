//
//  Stats.swift
//  noviZadatak
//
//  Created by Andjela Rakic on 9/30/21.
//

import Foundation

struct Stats: Decodable {
    let name: String
    let city: String
    let storeLogoURL: String
    
}

struct Stores: Decodable {
    
    let stores: [Stats]
}

