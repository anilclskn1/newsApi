//
//  NewsCustomCell.swift
//  MachinariumTask
//
//  Created by Anil Caliskan on 20.03.2023.
//

import UIKit

class NewsCustomCell: UITableViewCell {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  
            
          
                
                newsImageView.contentMode = .scaleToFill
              
               
                titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
                titleLabel.numberOfLines = 2
              
                
                
                
                dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                dateLabel.textColor = .gray
                dateLabel.numberOfLines = 1
               
                
                
                timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                timeLabel.textColor = .gray
                timeLabel.numberOfLines = 1
              
                
                
            
    
            

            
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

/*//
 //  SourcesCustomCell.swift
 //  MachinariumTask
 //
 //  Created by Anil Caliskan on 18.03.2023.
 //

 import Foundation
 import UIKit

 class NewsCustomCell: UITableViewCell {
     
     var newsImageView: UIImageView!
     
     var titleLabel: UILabel!
     
     var dateLabel: UILabel!
     
     var timeLabel: UILabel!
         
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         
         newsImageView = UIImageView()
         newsImageView.contentMode = .scaleToFill
         newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
         titleLabel = UILabel()
         titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
         titleLabel.numberOfLines = 0
         titleLabel.lineBreakMode = .byWordWrapping
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         
         
         
         dateLabel = UILabel()
         dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
         dateLabel.textColor = .gray
         dateLabel.numberOfLines = 1
         dateLabel.translatesAutoresizingMaskIntoConstraints = false
         
         
         timeLabel = UILabel()
         timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
         timeLabel.textColor = .gray
         timeLabel.numberOfLines = 1
         timeLabel.translatesAutoresizingMaskIntoConstraints = false
         
         
         addSubview(newsImageView)
         addSubview(titleLabel)
         addSubview(dateLabel)
         addSubview(timeLabel)
         
     
         
         NSLayoutConstraint.activate([
             dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
             dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
             
             timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
             timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
             
             titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -10),
             titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
             titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
             
             newsImageView.topAnchor.constraint(equalTo: topAnchor),
             newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
             newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
             newsImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 15),

           
        
         ])


       
               

     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
 }
*/
