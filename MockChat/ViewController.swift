//
//  ViewController.swift
//  MockChat
//
//  Created by kazu on 2024/11/15.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputArea: UIView!
    
    @IBOutlet weak var messageInputTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let mockMessage: [Message] = [
        Message(text: "こんにちは！", User: 0),
        Message(text: "テスト２", User: 1),
        Message(text: "さようなら🖐️", User: 0),
        Message(text: "テスト３", User: 1),
        Message(text: "こんにちは！", User: 0),
        Message(text: "テスト２", User: 1),
        Message(text: "さようなら🖐️", User: 0),
        Message(text: "テスト３", User: 1),
        Message(text: "こんにちは！", User: 0),
        Message(text: "テスト２", User: 1),
        Message(text: "さようなら🖐️", User: 0),
        Message(text: "テスト３", User: 1),
        Message(text: "こんにちは！", User: 0),
        Message(text: "テスト２", User: 1),
        Message(text: "さようなら🖐️", User: 0),
        Message(text: "テスト３", User: 1),
        Message(text: "こんにちは！", User: 0),
        Message(text: "テスト２", User: 1),
        Message(text: "さようなら🖐️", User: 0),
        Message(text: "テスト３", User: 1),
        Message(text: "こんにちは！", User: 0),
        Message(text: "テスト２", User: 1),
        Message(text: "さようなら🖐️", User: 0),
        Message(text: "テスト３", User: 1),
        Message(text: "こんにちは！", User: 0),
        Message(text: "テスト２", User: 1),
        Message(text: "さようなら🖐️", User: 0),
        Message(text: "テスト３", User: 1),
        Message(text: "こんにちは！", User: 0),
        Message(text: "テスト２", User: 1),
        Message(text: "さようなら🖐️", User: 0),
        Message(text: "テスト３", User: 1),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showkeyboard),name:UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hidekeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // TableViewのセットアップ
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatFrameCell", bundle: nil), forCellReuseIdentifier: "ChatFrameCell")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func showkeyboard(notification:Notification){
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey]as AnyObject).cgRectValue
        
        guard let keyboardMinY = keyboardFrame?.minY else {return}
        let loginButtonMaxY = inputArea.frame.maxY
        let distance = loginButtonMaxY - keyboardMinY + 20
        let transform = CGAffineTransform(translationX: 0, y: -distance)
        UIView.animate(withDuration: 0.5, delay:0, usingSpringWithDamping:1, initialSpringVelocity:1, options:[], animations: {
            self.view.transform = transform
        })
        
    }
    
    @objc func hidekeyboard(){
        UIView.animate(withDuration: 0.5, delay:0, usingSpringWithDamping:1, initialSpringVelocity:1, options:[], animations: {
            self.view.transform = .identity
        })
    }
    
    @IBAction func requestButtonAction(_ sender: Any) {
        messageInputTextField.endEditing(true)
    }
    
}

// MARK: TableView datasource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockMessage.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatFrameCell", for: indexPath) as! ChatFrameCell
        cell.configure(with: mockMessage[indexPath.row])
        return cell
    }
}

// MARK: TableView Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let marginView = UIView()
        marginView.backgroundColor = .clear
        return marginView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let marginView = UIView()
        marginView.backgroundColor = .clear
        return marginView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
