//
//  EmployeeListCell.swift
//  CoreDataDemo
//
//  Created by unthinkable-mac-0025 on 07/07/21.
//

import UIKit

class EmployeeListCell: UITableViewCell {

    @IBOutlet private weak var employeeImage: UIImageView!
    @IBOutlet private weak var employeeName: UILabel!
    @IBOutlet private weak var employeeEmailid: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(employeeImage : UIImage, employeeName : String, employeeEmailid : String){
        self.employeeImage.image = employeeImage
            //UIImage(named: employeeImageName)
        self.employeeName.text = employeeName
        self.employeeEmailid.text = employeeEmailid
    }
    
}
