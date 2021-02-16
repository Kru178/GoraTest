//
//  PhotoCollectionViewController.swift
//  Gora Test
//
//  Created by Sergei Krupenikov on 15.02.2021.
//

import UIKit

private let reuseIdentifier = "cell"

class PhotoCollectionViewController: UICollectionViewController {
    
    var id: Int?
    var photos = [Photo]()
    var images = [UIImage]()
    
    private let sectionInsets = UIEdgeInsets(
        top: 10.0,
        left: 20.0,
        bottom: 10.0,
        right: 20.0)
    
    private let itemsPerRow: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotos()
//        downloadPhotos()
    }
    
    func getPhotos() {
        
        NetworkManager.shared.getPhotos { [weak self] result in
            
            guard let self = self else { return }
            //            self.dismissLoadingView()
            
            switch result {
            case .success(let photos):
                
                for photo in photos{
                    if photo.albumId == self.id {
                        self.photos.append(photo)
//                        self.downloadPhoto(with: photo.url!)
                    }
                }
                print("photos in album: \(self.photos.count)")
//                print("images: \(self.images.count)")
                                DispatchQueue.main.async {
                                    self.collectionView.reloadData()
                                }

                
            case .failure(let error):
                print(error.localizedDescription)
            //                present alert
            }
        }
        
    }
    
    func downloadPhoto(with url: String) {
        
        
           
                NetworkManager.shared.downloadImage(from: url) { [weak self] (image) in
                    guard let self = self, let image = image else { return }
                    self.images.append(image)
                }
            
        
        
        
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        
        // Configure the cell
        
        //
        
        cell.load(from: photos[indexPath.item].url!)
        cell.label.text = photos[indexPath.item].title
        
        return cell
    }
    
    
}

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    // 1
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // 2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem + 50)
    }
    
    // 3
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
}