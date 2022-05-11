//
//  UIView.swift
//  ysCommonExtensions
//
//  Created by Ethan Lee on 2022/05/11.
//

import UIKit

extension UIView {
    
    func makeRoundCorners(cornerRadius: Double) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
    }
    
    func makeBorder(color: UIColor?, borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color?.cgColor
    }
    
    func addSubViewWithAnimation(view: UIView, subView: UIView, duration: CGFloat = 0.25) {
        subView.alpha = 0
        subView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: duration) {
            subView.alpha = 1
            subView.transform = CGAffineTransform(scaleX: 1, y: 1)
            view.addSubview(subView)
            view.bringSubviewToFront(subView)
        }
    }
    
    func removeViewWithAnimation(view: UIView, subView: UIView, duration: CGFloat = 0.25, completion: (()->Void)? = nil) {
        view.alpha = 1
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 0
        }) { _ in
            completion?()
            view.removeFromSuperview()
        }
    }
    
    func captureScreenShot() -> UIImage? {
        return UIGraphicsImageRenderer(size: self.frame.size).image {
            ctx in self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }
    
    func getSafeAreaLayoutGuideSize() -> CGSize {
        return self.safeAreaLayoutGuide.layoutFrame.size
    }
    
    func addGradient(_ colors: [CGColor], frame: CGRect = .zero, startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0), endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0), locaions: [NSNumber]? = nil) {
        self.layer.sublayers?.filter { $0.name == "gradient" }.forEach { $0.removeFromSuperlayer() }
        
        let gradient = CAGradientLayer()
        gradient.frame = frame == .zero ? self.bounds : frame
        gradient.colors = colors
        gradient.name = "gradient"
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.locations = locaions
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func loadViewFromNib(nib: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nib, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
        
    func fillToSuperview(withPadding padding: UIEdgeInsets = .zero) {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, padding: padding)
    }

    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }

        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }

        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func removeAllConstraints() {
        constraints.forEach { removeConstraint($0) }
    }
}


