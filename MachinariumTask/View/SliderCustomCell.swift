//
//  SliderCustomCell.swift
//  MachinariumTask
//
//  Created by Anil Caliskan on 20.03.2023.
//

import UIKit

class SliderCustomCell: UICollectionViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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

}

/*//
 //  SourcesCustomCell.swift
 //  MachinariumTask
 //
 //  Created by Anil Caliskan on 18.03.2023.
 //

 import Foundation
 import UIKit

 class SliderCustomCell: UICollectionViewCell {
     
     var newsImageView: UIImageView!
     
     var titleLabel: UILabel!
     
     var dateLabel: UILabel!
     
     var timeLabel: UILabel!
         
     override init(frame: CGRect) {
         super.init(frame: frame)

         newsImageView = UIImageView()
         newsImageView.contentMode = .scaleAspectFill
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
         addSubview(timeLabel)
         addSubview(titleLabel)
         addSubview(dateLabel)
         
         NSLayoutConstraint.activate([
             dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
             dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
             
             timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
             timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
             
            
             
             newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
             newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
             newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
             newsImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.7),
             
             titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: contentView.frame.height * 0.75),
             titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
             titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
             
             
             
           
             

         ])
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
 }
*/
