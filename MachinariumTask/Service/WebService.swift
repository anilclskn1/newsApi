//
//  WebService.swift
//  MachinariumTask
//
//  Created by Anil Caliskan on 19.03.2023.
//

import Foundation

class WebService{
    
    func downloadSources(url: String, apiKey: String, completion: @escaping (SourceResponse) -> ()) {
        let urlForSources = URL(string: url+"?language=en&apiKey="+apiKey)!
        URLSession.shared.dataTask(with: urlForSources) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    let sourcesList = try JSONDecoder().decode(SourceResponse.self, from: data)
                    completion(sourcesList)
                } catch {
                    print("Error decoding sources list: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func downloadNews(url: String, apiKey: String, source: String, completion: @escaping (NewsResponse) -> ()){
        let urlForNews = URL(string: url+"?sources="+source+"&apiKey="+apiKey)!
        URLSession.shared.dataTask(with: urlForNews) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    let newsList = try JSONDecoder().decode(NewsResponse.self, from: data)
                    completion(newsList)
                } catch {
                    print("Error decoding sources list: \(error)")
                }
            }
        }.resume()
    }

}
