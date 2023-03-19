//
//  SourceModel.swift
//  MachinariumTask
//
//  Created by Anil Caliskan on 19.03.2023.
//

import Foundation

struct SourceModel: Decodable{
    let id: String
    let name: String
    let description: String
    let url: URL
    let category: String
    let language: String
    let country: String
}

struct SourceResponse: Decodable {
    let status: String
    var sources: [SourceModel]
}


