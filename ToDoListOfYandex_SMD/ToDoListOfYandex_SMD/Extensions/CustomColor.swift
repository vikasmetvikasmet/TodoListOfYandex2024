//
//  CustomColor.swift
//  ToDoListOfYandex_SMD
//
//  Created by Vika on 01.07.2024.
//

import Foundation
import SwiftUI


extension Color{
    var toHex: String{
        guard let components = cgColor?.components else {return ""}
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        let hex = String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        
        return hex
    }
}
