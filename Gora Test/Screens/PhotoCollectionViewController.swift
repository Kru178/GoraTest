//
//  PhotoCollectionViewController.swift
//  Gora Test
//
//  Created by Sergei Krupenikov on 15.02.2021.
//

import UIKit

private let reuseIdentifier = "cell"

class PhotoCollectionViewController: UICollectionViewController {
    
    var userId : Int?
    var albums = ""
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
        getAlbums()
    }
    
    func getAlbums() {

        guard let id = userId else {return}
        NetworkManager.shared.getAlbums(for: id) { (result) in
            
            switch result {
            case .success(let albums):
                for i in 0..<albums.count {
                    self.albums += "albumId=\(albums[i].id)&"
                }
                self.albums.removeLast()
                print(self.albums)
                self.getPhotos(for: self.albums)
            case .failure(let error):
            print(error.localizedDescription)
            }
        }
        
    }
    
    func getPhotos(for albums: String) {
        
        NetworkManager.shared.getPhotos(for: albums) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let photos):
                
                        self.photos = photos

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        
        cell.loadImageFrom(url: photos[indexPath.item].url)
        cell.label.text = photos[indexPath.item].title
        
        return cell
    }
}


extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem + 50)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
}
