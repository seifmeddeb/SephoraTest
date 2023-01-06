//
//  UIImageView+Cache.swift
//  sephora1
//
//  Created by Seif Meddeb on 05/01/2023.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        self.image = nil
        
        guard let url = URL(string: urlString) else { return }

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }

        // if not, download image from url
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            guard let data = data else { return }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }

        }).resume()
    }
}
