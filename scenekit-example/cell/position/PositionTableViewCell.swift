//
//  PositionTableViewCell.swift
//  scenekit-example
//
//  Created by MacBook on 3/8/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

class PositionTableViewCell: UITableViewCell {

    @IBOutlet weak var sliderX: UISlider!
    @IBOutlet weak var sliderY: UISlider!
    @IBOutlet weak var sliderZ: UISlider!
    @IBOutlet weak var xPositionLabel: UILabel!
    @IBOutlet weak var yPositionLabel: UILabel!
    @IBOutlet weak var zPositionLabel: UILabel!
    
    private var callback: UpdatePositionCallback?
    
    @IBAction func sliderXChanged(_ sender: Any) {
        xPositionLabel.text = "X = (\(sliderX.value))"
        updatePosition()
    }
    
    @IBAction func sliderYChanged(_ sender: Any) {
        yPositionLabel.text = "Y = (\(sliderY.value))"
        updatePosition()
    }
    
    @IBAction func sliderZChanged(_ sender: Any) {
        zPositionLabel.text = "Z = (\(sliderZ.value))"
        updatePosition()
    }
    
    func updatePosition() {
        guard let callback = callback else { return }
        callback(sliderX.value, sliderY.value, sliderZ.value)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCallback(_ callback: @escaping UpdatePositionCallback) {
        self.callback = callback
    }
    
}
