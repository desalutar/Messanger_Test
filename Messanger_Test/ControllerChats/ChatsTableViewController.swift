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
    
    var testCell = ["123"]
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.hidesBackButton = true
        view.backgroundColor = appearance.backgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ChatsCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        testCell.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

}

extension ChatsTableViewController {
    struct Appearance {
        var backgroundColor = UIColor(
            cgColor: CGColor(red: 110/256, green: 132/256, blue: 126/256, alpha: 1))
        
    }
}

extension ChatsTableViewController {
                                                // MARK: - Cells Settings
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChatsCell
        cell.textLabel?.text = "Hello BOSS"
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = CGFloat()
        
        if indexPath.row == 0 {
            height = 80
        } else if indexPath.row == 1 {
            height = self.view.frame.size.height - 44 - 64
            print(height)
        }
        return height
    }
}

extension ChatsTableViewController {
    
}
