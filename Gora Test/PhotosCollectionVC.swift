//
//  AlbumsCollectionVC.swift
//  Gora Test
//
//  Created by Sergei Krupenikov on 15.02.2021.
//

import UIKit

class PhotosCollectionVC: UICollectionViewController {
    
    var photos = ["1", "2", "3", "4", "5", "6"]
//        [Photo]()
    
    let id = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
//        getPhotos()
    }

    
//    func getPhotos() {
////        showLoadingView()
////        isLoadingMoreFollowers = true
//
//        NetworkManager.shared.getPhotos {[weak self] (result) in
//            guard let self = self else { return }
////            self.dismissLoadingView()
//
//            switch result {
//            case .success(let photos):
//
//                for photo in photos{
//                    if photo.albumId == self.id {
//                        self.photos.append(photo)
//                    }
//                    print(photos)
//                }
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//
//            case .failure(let error):
//                print(error.localizedDescription)
////                present alert
//            }
//
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath)
//                as? PhotoCell else {return UICollectionViewCell()}
    
//        cell.photoImageView.image = UIImage(systemName: "photo")
//            UIImage(imageLiteralResourceName: photos[indexPath.item].thumbnailUrl!)
//
        
//        cell.titleLabel.text = photos[indexPath.item].title
//        cell.titleLabel.numberOfLines = 0
    
        return cell
    }
}
