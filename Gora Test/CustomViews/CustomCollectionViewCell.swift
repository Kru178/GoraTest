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
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func layoutSubviews() {
        
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.clipsToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 1
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = false
        
        loadingView.alpha = 0.5
    }
    
    func loadImageFrom(url: String) {
        loadingView.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkManager.shared.loadImage(from: url) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.imageView.image = image
                self.loadingView.isHidden = true
            }
        }
    }
    
    override func prepareForReuse() {
        self.imageView.image = nil
        
        super.prepareForReuse()
    }
}
