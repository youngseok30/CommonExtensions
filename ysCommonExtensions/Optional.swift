//
//  Optional.swift
//  ysCommonExtensions
//
//  Created by Ethan Lee on 2022/05/11.
//

import Foundation

extension Optional {
    
    func stringValue() -> String? {
        switch(self) {
        case .none:
            return nil
        case .some(let value):
            return value as? String
        }
    }
  
    func intValue() -> Int? {
        switch(self) {
        case .none:
            return 0
        case .some(let value):
            return value as? Int
        }
    }
    
}
