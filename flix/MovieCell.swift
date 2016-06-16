//
//  MovieCell.swift
//  flix
//
//  Created by Andrés Arbeláez on 6/15/16.
//  Copyright © 2016 Andrés Arbeláez. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ratingView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
