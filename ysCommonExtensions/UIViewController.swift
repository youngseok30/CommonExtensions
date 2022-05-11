//
//  UIViewController.swift
//  ysCommonExtensions
//
//  Created by Ethan Lee on 2022/05/11.
//

import UIKit

extension UIViewController {
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }    
    
}
