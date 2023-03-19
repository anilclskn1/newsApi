//
//  SourceViewModel.swift
//  MachinariumTask
//
//  Created by Anil Caliskan on 19.03.2023.
//

import Foundation

struct SourceViewModel{
    
    let source: SourceModel
    
    var title: String{
        return self.source.name
    }
    
    var description: String{
        return self.source.description
    }
    
    var category: String{
        return self.source.category
    }
}

struct SourceViewModelList{
    
    var sourceList: SourceResponse
    
    var categories: Set<String> {
        return Set(sourceList.sources.map { $0.category })
    }
}

extension SourceViewModelList{
    func numberOfRowsInSection() -> Int{
        return sourceList.sources.count
    }
    
    func sourceAtIndex(_ index: Int) -> SourceViewModel{
        let source = self.sourceList.sources[index]
        return SourceViewModel(source: source)
    }
    
    mutating func removeAll(){
        sourceList.sources.removeAll()
    }
    
}





