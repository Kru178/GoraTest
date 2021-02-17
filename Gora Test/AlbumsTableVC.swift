//
//  AlbumsTableVC.swift
//  Gora Test
//
//  Created by Sergei Krupenikov on 15.02.2021.
//

import UIKit

class AlbumsTableVC: UITableViewController {
    
    var id: Int!
    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAlbums()
    }
    
    
    func getAlbums() {
//        showLoadingView()
//        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getAlbums {[weak self] (result) in
            guard let self = self else { return }
//            self.dismissLoadingView()
            
            switch result {
            case .success(let albums):
                
                for album in albums{
                    if album.userId == self.id {
                        self.albums.append(album)
                    }
                }
                print("albums for user: \(self.albums.count)")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print(self.albums)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)

        cell.textLabel?.text = albums[indexPath.row].title
        cell.textLabel?.numberOfLines = 0

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushPhotosVC(albumId: albums[indexPath.row].id)
    }
    
    func pushPhotosVC(albumId: Int) {
        let vc = storyboard?.instantiateViewController(identifier: "photosVC") as? PhotoCollectionViewController
        vc?.albumId = albumId
        print("id passing: \(albumId)")
        show(vc!, sender: nil)
    }

}
