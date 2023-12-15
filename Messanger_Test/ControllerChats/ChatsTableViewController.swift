//
//  ChatsTableViewController.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 14.12.23.
//

import UIKit

class ChatsTableViewController: UITableViewController {

    weak var coordinator: AppCoordinator?
    var appearance = Appearance()
    
    var testCell = ["123", "321"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: .zero, style: .grouped)
//        self.navigationItem.hidesBackButton = true
        view.backgroundColor = Appearance.backgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChatsCell.self, forCellReuseIdentifier: "Cell")
    }
    

}

extension ChatsTableViewController {
                                    // MARK: - Cells Settings
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChatsCell
        
        return cell
    }
}

extension ChatsTableViewController {
                                    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        testCell.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


extension ChatsTableViewController {
    struct Appearance {
        static let  backgroundColor = UIColor(
            cgColor: CGColor(red: 110/256, green: 132/256, blue: 126/256, alpha: 1))
    }
}
