//
//  SourceModel.swift
//  MachinariumTask
//
//  Created by Anil Caliskan on 19.03.2023.
//

import Foundation

struct  NewsModel: Decodable{
    let source: SourceModelForNews?
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL
    let publishedAt: String?
    let content: String?
}

struct SourceModelForNews: Decodable{
    let id: String?
    let name: String
}

struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int?
    var articles: [NewsModel]
}


