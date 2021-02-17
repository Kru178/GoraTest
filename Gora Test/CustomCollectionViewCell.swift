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
    
    
    override func layoutSubviews() {
        
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.clipsToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 1
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = false
        
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
