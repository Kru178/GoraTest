//
//  AlbumsTableVC.swift
//  Gora Test
//
//  Created by Sergei Krupenikov on 15.02.2021.
//

import UIKit

class AlbumsTableVC: UITableViewController {
    
    var id: Int?
    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAlbums()
    }
    
    func getAlbums() {
        NetworkManager.shared.getAlbums {[weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let albums):
                
                for album in albums{
                    if album.userId == self.id {
                        self.albums.append(album)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushPhotosVC(albumId: albums[indexPath.row].id)
    }
    
    func pushPhotosVC(albumId: Int) {
        let vc = storyboard?.instantiateViewController(identifier: "photosVC") as? PhotoCollectionViewController
        guard let destinationVC = vc else { return }
        
        destinationVC.albumId = albumId

        show(destinationVC, sender: nil)
    }
}
