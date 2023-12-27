//
//  ChatsTableViewController.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 14.12.23.
//

import UIKit

class ChatsTableViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    var userMessages = UserMessages(messageType: .send)
    var messageCount = [String]()
    
    var sendButtonImage =  UIImage(systemName: "arrow.up",
                                   withConfiguration: UIImage.SymbolConfiguration(scale: .large)
                                )?.withTintColor(.green, renderingMode: .alwaysOriginal)
    var backgroundColor = UIColor(red: 25/256, green: 25/256, blue: 27/256, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.isNavigationBarHidden = true
        hideKeyboard()
        setViews()
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.becomeFirstResponder()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = backgroundColor
        textView.tintColor       = UIColor(red: 136/255, green: 249/255, blue: 57/255, alpha: 1.0)
        textView.textColor       = UIColor(red: 136/255, green: 249/255, blue: 57/255, alpha: 1.0)
        return textView
    }()
    
    private lazy var sendButton: UIButton = {
        let sendButton = UIButton()
        sendButton.setImage(sendButtonImage, for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(sendUserText), for: .touchUpInside)
        return sendButton
    }()
    
    @objc func sendUserText() {
        if !textView.text.isEmpty {
            userMessages.text = textView.text
            messageCount.append(textView.text)
            textView.attributedText = nil
            tableView.reloadData()
        }

    }
}
                        // MARK: - TableViewDataSource, TableViewDelegate
extension ChatsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messageCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let data = messageCount[indexPath.row]
        cell.userTextLabel.text = data
        cell.selectionStyle = .none
        switch userMessages.messageType {
        case .send:
            cell.userTextLabel.textAlignment = .right
        case .received:
            cell.userTextLabel.textAlignment = .left
        }
        return cell
    }

}
                            // MARK: - UIView
extension ChatsTableViewController {
    private func hideKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    private func setViews() {
        view.backgroundColor = backgroundColor
        view.addSubview(textView)
        view.addSubview(sendButton)
        view.addSubview(tableView)
        
        layoutTextView()
        layoutSendButton()
        layoutTableView()
    }
    
    private func layoutTableView()  {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            tableView.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -10.0),
        ])
    }
    
    private func layoutTextView()   {
        NSLayoutConstraint.activate([
            textView.heightAnchor.constraint(  equalToConstant: 50),
            textView.leadingAnchor.constraint( equalTo: view.leadingAnchor,  constant: 10.0),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80.0),
            textView.bottomAnchor.constraint(  equalTo: view.bottomAnchor),
            
        ])
    }
    
    private func layoutSendButton() {
        NSLayoutConstraint.activate([
            sendButton.heightAnchor.constraint(  equalToConstant: 50),
            sendButton.bottomAnchor.constraint(  equalTo: textView.bottomAnchor),
            sendButton.leadingAnchor.constraint( equalTo: textView.trailingAnchor, constant: 10 ),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,     constant: -10),
        ])
    }
}
