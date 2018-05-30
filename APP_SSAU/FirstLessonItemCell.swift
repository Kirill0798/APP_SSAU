//
//  FirstLessonItemCell.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 08.04.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit

class FirstLessonItemCell: UITableViewCell {

    @IBOutlet weak var labelTeacher: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelDiscipline: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
