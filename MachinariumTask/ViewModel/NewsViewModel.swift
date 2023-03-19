//
//  NewsViewModel.swift
//  MachinariumTask
//
//  Created by Anil Caliskan on 19.03.2023.
//

import Foundation

struct NewsViewModel{
    
    let new: NewsModel
    
    var title: String{
        return self.new.title ?? ""
    }
    
    var date: String{
        return self.new.publishedAt ?? ""
    }
    
    var image: URL{
        return self.new.urlToImage
    }
}

struct NewsViewModelList{
    
    var newsList: NewsResponse
    
}

extension NewsViewModelList{
    func numberOfRowsInSection() -> Int{
        return newsList.articles.count
    }
    
    func newAtIndex(_ index: Int) -> NewsViewModel{
        let new = self.newsList.articles[index]
        return NewsViewModel(new: new)
    }
    
    
    mutating func removeAll(){
        newsList.articles.removeAll()
    }
    
}

