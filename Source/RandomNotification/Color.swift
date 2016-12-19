//
//  Color.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 19/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

fileprivate let allowedCharacters = CharacterSet(charactersIn: "AaBbCcDdEeFf0123456789")

public struct Color {
    
    fileprivate let hexString: String
    fileprivate let alpha: Float
    public let strColor: String
    
    public var color: UIColor {
        
        return self.makeColor()
    }
    
    public var cgColor: CGColor {
        
        return makeColor().cgColor
    }
    
    public init(hexString: String, alpha: Float = 1) {
        
        self.hexString = hexString
        self.alpha = alpha
        self.strColor = hexString.trimmingCharacters(in: allowedCharacters.inverted)
    }
}

fileprivate extension Color {
    
    fileprivate func makeColor() -> UIColor {
        
        let hex = convertToRGB()
        
        return UIColor(colorLiteralRed: hex.r / 255, green: hex.g / 255, blue: hex.b / 255, alpha: alpha)
    }
    
    private func convertToRGB() -> (r: Float, g: Float, b: Float) {
        
        let r, g, b: UInt32
        let hexString = strColor
        var hex: UInt32 = 0
        
        Scanner(string: hexString).scanHexInt32(&hex)
        
        switch hexString.characters.count {
            
        case 3:
            (r, g, b) = (((hex & 0xF00) * 17) >> 8, ((hex & 0x0F0) * 17) >> 4, (hex & 0x00F) * 17)
        case 6:
            (r, g, b) = ((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8, hex & 0x0000FF)
        default:
            (r, g, b) = (0, 0, 0)
            print("Color not found.")
        }
        
        return (r: Float(r), g: Float(g), b: Float(b))
    }
}
