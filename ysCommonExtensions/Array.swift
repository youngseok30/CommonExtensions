//
//  Array.swift
//  ysCommonExtensions
//
//  Created by Ethan Lee on 2022/05/11.
//

import Foundation

extension Array {
    
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
}
