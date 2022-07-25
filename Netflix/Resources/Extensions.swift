//
//  Extensions.swift
//  Netflix
//
//  Created by Omar Tharwat on 7/17/22.
//  Copyright © 2022 Omar Tharwat. All rights reserved.
//

import Foundation

extension String {
    
    func capitalizedFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
}
