//
//  SourcesCustomCell.swift
//  MachinariumTask
//
//  Created by Anil Caliskan on 18.03.2023.
//

import Foundation
import UIKit

class SourcesCustomCell: UITableViewCell{
    
    var sourceTitle: UILabel!
    var sourceContent: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        sourceTitle = UILabel()
        sourceTitle.translatesAutoresizingMaskIntoConstraints = false
        sourceTitle.textColor = .blue
        sourceTitle.font = .boldSystemFont(ofSize: 25)
        addSubview(sourceTitle)
        
        sourceContent = UILabel()
        sourceContent.textColor = .black
        sourceContent.translatesAutoresizingMaskIntoConstraints = false
        sourceContent.font = .systemFont(ofSize: 15)
        sourceContent.numberOfLines = 0
        sourceContent.lineBreakMode = .byWordWrapping
        addSubview(sourceContent)
        
        NSLayoutConstraint.activate([
            sourceTitle.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            sourceTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            
            sourceContent.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            sourceContent.topAnchor.constraint(equalTo: sourceTitle.bottomAnchor, constant: 10),
            sourceContent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            sourceContent.rightAnchor.constraint(equalTo: rightAnchor),
            

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
