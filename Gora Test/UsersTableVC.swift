//
//  UsersTableVC.swift
//  Gora Test
//
//  Created by Sergei Krupenikov on 15.02.2021.
//

import UIKit

class UsersTableVC: UITableViewController {
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Users"
        getUsers()
    }
    
    func getUsers() {
//        showLoadingView()
//        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getUsers {[weak self] (result) in
            guard let self = self else { return }
//            self.dismissLoadingView()
            
            switch result {
            case .success(let users):
                
                self.users = users
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
        return users.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)

        cell.textLabel?.text = users[indexPath.row].name

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        pushAlbumsVC(title: users[indexPath.row].name, id: users[indexPath.row].id)
    }
    
    func pushAlbumsVC(title: String, id: Int) {
        let vc = storyboard?.instantiateViewController(identifier: "albumsVC") as? AlbumsTableVC
        vc?.id = id
        vc?.title = title
        show(vc!, sender: nil)
    }
}
