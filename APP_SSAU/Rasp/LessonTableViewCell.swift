//
//  LessonTableViewCell.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 20.05.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit

class LessonTableViewCell: UITableViewCell {
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var disciplineLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
