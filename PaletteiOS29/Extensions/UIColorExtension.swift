//
//  UIColorExtensio.swift
//  PaletteiOS29
//
//  Created by Devin Singh on 2/11/20.
//  Copyright © 2020 Darin Armstrong. All rights reserved.
//

import UIKit.UIColor

extension UIColor {
    convenience init (_ imaggaColor: ImaggaColor) {
        let red = CGFloat(imaggaColor.red) / 255
        let green = CGFloat(imaggaColor.green) / 255
        let blue = CGFloat(imaggaColor.blue) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
