//
//  SubjectsTableViewCell.swift
//  LearningApp
//
//  Created by Busha Ltd on 06/11/2018.
//  Copyright © 2018 Codegene. All rights reserved.
//

import UIKit

class SubjectsTableViewCell: UITableViewCell {

    @IBOutlet weak var listItemLabel: UILabel!
    
    func setSubject(subject:Subject) {
        listItemLabel.text = subject.title
    }

}
