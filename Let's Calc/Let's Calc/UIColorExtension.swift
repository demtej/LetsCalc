//
//  UIColorExtension.swift
//  Let's Calc
//
//  Created by Demian Tejo on 5/20/17.
//  Copyright © 2017 Demian Tejo. All rights reserved.
//

import UIKit

extension UIColor {
    func lighter(by percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage:CGFloat=30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage:CGFloat=30.0) -> UIColor? {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
        if(self.getRed(&r, green: &g, blue: &b, alpha: &a)){
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        }else{
            return nil
        }
    }
    
    class public func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class public func fromHex(_ hexValue: String) -> UIColor {
        var hexInt: UInt32 = 0
        let scanner: Scanner = Scanner(string: hexValue)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)
        return UIColorFromRGB(UInt(hexInt))
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    class public func darkTKColor() -> UIColor{
        return UIColor.fromHex("1D242F")
            //UIColor.fromHex("582A40")
    }
    class public func darkTextTKColor() -> UIColor{
        return UIColor.white
    }
    class public func ultraLightTextTKColor() -> UIColor{
        return UIColor.white.withAlphaComponent(0.8)
            //UIColor.fromHex("94637F")
    }
    class public func lightTextTKColor() -> UIColor{
        return UIColor.white.withAlphaComponent(0.6)
        //UIColor.fromHex("94637F")
    }
    class public func lightBorderTKColor() -> UIColor{
        return UIColor.fromHex("1D242F")
            //UIColor.fromHex("94637F")
    }
    
    class public func elementButton() -> UIColor{
        return  UIColor.fromHex("212937")
    }

    convenience init(netHex: Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }

}
