//
//  ChatsTableViewController.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 14.12.23.
//

import UIKit

class ChatsTableViewController: UITableViewController {

    weak var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .red
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    

}
