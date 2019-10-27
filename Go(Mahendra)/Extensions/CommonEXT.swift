//
//  CommonEXT.swift
//  Go(Mahendra)
//
//  Created by Mahendra Vishwakarma on 26/10/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation
import UIKit

//MARK: for gradient
extension CAGradientLayer {
    
    enum Point {
        case bottomTop
        
        var point: CGPoint {
            switch self {
            case .bottomTop: return CGPoint(x: 0, y: 0)
            }
            
        }
        
    }
    
    convenience init(point:Point) {
        self.init()
        
        self.colors = [UIColor.white.cgColor, UIColor(red: 217.0/255.0, green: 245.0/255.0, blue: 239.0/255.0, alpha: 1).cgColor]
        
        self.startPoint = CGPoint(x: 1.0, y: 0.0)
        self.endPoint = CGPoint(x: 1.0, y: 1.0)
        
    }
    
}


//MARK: for image download
let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func downloadImage(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                     self.image = UIImage(named: "placeholder_photo")
                }
               
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
}


extension UIViewController{
    func showToast(message : String)
    {
        DispatchQueue.main.async {
            let toastLabel = UILabel(frame: CGRect(x: 50, y: UIScreen.main.bounds.height-100, width:UIScreen.main.bounds.width - 100, height: 40))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font = UIFont(name: "Helvetica-Regular", size: 12.0)
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.window?.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
        
        
    }
}
