//
//  CustomCollectionViewCell.swift
//  Gora Test
//
//  Created by Sergei Krupenikov on 15.02.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    let cache = NSCache<NSString, UIImage>()
    
    override func layoutSubviews() {
        // cell rounded section
        //        self.layer.cornerRadius = 5.0
        //        self.layer.borderWidth = 1.0
        //        self.layer.borderColor = UIColor.lightGray.cgColor
        //        self.layer.masksToBounds = true
        //
        //         cell shadow section
        //                    self.contentView.layer.cornerRadius = 5.0
        //                    self.contentView.layer.borderWidth = 5.0
        //                    self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        //        self.contentView.layer.masksToBounds = true
        //        self.layer.shadowColor = UIColor.lightGray.cgColor
        //        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        //        self.layer.shadowRadius = 6.0
        //        self.layer.shadowOpacity = 0.6
        //        self.layer.cornerRadius = 15.0
        //                    self.layer.masksToBounds = false
        //        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
        
        self.layer.masksToBounds = true
        
        self.layer.shadowRadius = 8
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.5
        
    }
    
    
    func loadImageFrom(url: String) {
        
        NetworkManager.shared.loadImage(from: url) { (image) in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
    }

    
//    func load(from urlString: String) {
//
//        let cacheKey = NSString(string: urlString)
//
//        if let image = cache.object(forKey: cacheKey) {
//            self.imageView.image = image
//            print("cache rules")
//            return
//        }
//
//        DispatchQueue.global().async { [weak self] in
//            guard let self = self else { return }
//            if let data = try? Data(contentsOf: URL(string: urlString)!) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self.cache.setObject(image, forKey: cacheKey)
//                        self.imageView.image = image
//                        print("downloading...")
//                    }
//                }
//            }
//        }
//    }
}
