//
//  ListBooksTableViewCell.swift
//  loginTimeTonicInterview
//
//  Created by Sergio Luis Noriega Pita on 15/04/24.
//

import UIKit

class ListBooksTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var tapOnCell: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapOnContenView))
        gesture.numberOfTapsRequired = 1
        contentView.addGestureRecognizer(gesture)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        super.setSelected(selected, animated: animated)
        self.photoImageView.layer.cornerRadius = 8
        self.photoImageView.layer.shadowOpacity = 0.5
        
    }
    
    @objc func tapOnContenView() {
         if let tapOnCell = self.tapOnCell {
             tapOnCell()
         }
     }
    
}
