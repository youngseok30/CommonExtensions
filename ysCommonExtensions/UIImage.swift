//
//  UIImage.swift
//  ysCommonExtensions
//
//  Created by Ethan Lee on 2022/05/11.
//

import UIKit

extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image!.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func overlayWith(image: UIImage?, imageFrame: CGRect, viewFrame: CGRect, position: CGPoint) -> UIImage {
        guard let image = image else { return self }
        let pictureImage = self
        
        let pictureImageSize = pictureImage.size
        UIGraphicsBeginImageContextWithOptions(pictureImageSize, true, scale)
        pictureImage.draw(in: CGRect(origin: CGPoint.zero, size: pictureImageSize))
        
        let realXPos = (position.x - viewFrame.origin.x) * (pictureImageSize.width / viewFrame.size.width)
        let realYPos = (position.y - viewFrame.origin.y) * (pictureImageSize.height / viewFrame.size.height)
        
        let realWidth: CGFloat = pictureImageSize.width * (imageFrame.width / viewFrame.width)
        let realHeight: CGFloat = pictureImageSize.height * (imageFrame.height / viewFrame.height)

        image.draw(in: CGRect(origin: CGPoint(x: realXPos, y: realYPos), size: CGSize(width: realWidth, height: realHeight)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func drawText(drawText text: String, textSize: CGFloat = 80, inImage image: UIImage, atPoint point: CGPoint, textColor: UIColor = .black) -> UIImage {
        let textFont = UIFont.systemFont(ofSize: textSize)

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
