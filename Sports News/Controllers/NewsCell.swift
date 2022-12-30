//
//  NewsCell.swift
//  Sports News
//
//  Created by Ahmed on 30/12/2022.
//

import UIKit

class NewsCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var NewsTitle: UILabel!
    @IBOutlet weak var NewsPoster: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated) 
    }

}
