//
//  AlbumsTableVC.swift
//  Gora Test
//
//  Created by Sergei Krupenikov on 15.02.2021.
//

import UIKit

class AlbumsTableVC: UITableViewController {
    
//    let albums = ["1", "2", "3"]
    
    var id: Int!
    var albums = [Album]()
    
//    init(username: String ,id: Int) {
//        super.init(nibName: nil, bundle: nil)
//        self.id = id
//        title = username
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
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
                }
                
            case .failure(let error):
                print(error.localizedDescription)
//                present alert
            }
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)

        cell.textLabel?.text = albums[indexPath.row].title
        cell.textLabel?.numberOfLines = 0

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let title = albums[indexPath.row].title else { return }
        pushPhotosVC(title: title)
    }
    
    func pushPhotosVC(title: String) {
        let vc = storyboard?.instantiateViewController(identifier: "photosVC") as? PhotoCollectionViewController
        vc?.id = self.id
        show(vc!, sender: nil)
    }

}
