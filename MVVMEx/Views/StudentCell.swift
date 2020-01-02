
//
//  StudentCell.swift
//  MVVMEx
//
//  Created by User on 12/15/19.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit

class StudentCell: UITableViewCell {

    @IBOutlet weak var lblStudentName :UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var studentListCellViewModel : Student? {
        didSet {
            lblStudentName.text = studentListCellViewModel?.studentName
        }
    }
    
}
