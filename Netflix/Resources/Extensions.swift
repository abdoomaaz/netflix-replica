//
//  Extensions.swift
//  Netflix
//
//  Created by AbdooMaaz's playground on 01.05.22.
//

import Foundation


extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
}
