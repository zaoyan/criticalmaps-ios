//
//  SettingsInfoTableViewCell.swift
//  CriticalMaps
//
//  Created by Leonard Thomas on 1/31/19.
//

import UIKit

class SettingsInfoTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!

    override var textLabel: UILabel? {
        return titleLabel
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = .settingsForeground
    }
}
