//
//  ViewController.swift
//  MockChat
//
//  Created by kazu on 2024/11/15.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlet
    @IBOutlet weak var inputArea: UIView!
    @IBOutlet weak var messageInputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    
    // MARK: Definition
    private var mockMessage: [Message] = [
        Message(text: "こんにちは！", User: 0),
        Message(text: "ようこそMockChatへ！！", User: 1),
        Message(text: "ユーザーメッセージ_1", User: 0),
        Message(text: "デフォルトメッセージ_1", User: 1),
        Message(text: "ユーザーメッセージ_2", User: 0),
        Message(text: "デフォルトメッセージ_2", User: 1),
        Message(text: "ユーザーメッセージ_3", User: 0),
        Message(text: "デフォルトメッセージ_3", User: 1),
        Message(text: "ユーザーメッセージ_4", User: 0),
        Message(text: "デフォルトメッセージ_4", User: 1),
        Message(text: "ユーザーメッセージ_5", User: 0),
        Message(text: "デフォルトメッセージ_5", User: 1),
        Message(text: "ユーザーメッセージ_6", User: 0),
        Message(text: "デフォルトメッセージ_6", User: 1),
        Message(text: "ユーザーメッセージ_7", User: 0),
        Message(text: "デフォルトメッセージ_7", User: 1),
        Message(text: "ユーザーメッセージ_8", User: 0),
        Message(text: "デフォルトメッセージ_8", User: 1),
        Message(text: "ユーザーメッセージ_9", User: 0),
        Message(text: "デフォルトメッセージ_9", User: 1),
        Message(text: "ユーザーメッセージ_10", User: 0),
        Message(text: "デフォルトメッセージ_10", User: 1),
        Message(text: "ユーザーメッセージ_11", User: 0),
        Message(text: "デフォルトメッセージ_11", User: 1),
        Message(text: "ユーザーメッセージ_12", User: 0),
        Message(text: "デフォルトメッセージ_12", User: 1),
        Message(text: "ユーザーメッセージ_13", User: 0),
        Message(text: "デフォルトメッセージ_13", User: 1),
        Message(text: "ユーザーメッセージ_14", User: 0),
        Message(text: "デフォルトメッセージ_14", User: 1),
        Message(text: "ユーザーメッセージ_15", User: 0),
        Message(text: "デフォルトメッセージ_15", User: 1),
        Message(text: "さようなら🖐️", User: 0),
        Message(text: "さようなら👍", User: 1),
    ]
    
    struct Constants {
        static let EMPTY: String = ""
        static let USER_TYPE_ME: Int = 0
        static let USER_TYPE_OTHER: Int = 1
        static let HEADER_MARGIN: CGFloat = 10
        static let FOOTER_MARGIN: CGFloat = 10
        static let LOW_MARGIN: CGFloat = 70
        static let ARRAY_LAST_ELEMENT_OFFSET = 1
        static let SECONDS: Double = 2
        static let OTHER_MESSAGE_TEXT: String = "メッセージを受け取りました。"
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showkeyboard),name:UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hidekeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // TableViewのセットアップ
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatFrameCell", bundle: nil), forCellReuseIdentifier: "ChatFrameCell")
        
    }
    
    // MARK: Override
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Function
    @objc func showkeyboard(notification:Notification){
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey]as AnyObject).cgRectValue
        
        guard let keyboardMinY = keyboardFrame?.minY else {return}
        let loginButtonMaxY = inputArea.frame.maxY
        let distance = loginButtonMaxY - keyboardMinY
        let transform = CGAffineTransform(translationX: 0, y: -distance)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = transform
        })
        
    }
    
    @objc func hidekeyboard(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            self.view.transform = .identity
        })
    }
    
    private func messageTransform(messageText: String) -> Message {
        return Message(text: messageText, User: Constants.USER_TYPE_ME)
    }
    
    // MARK: Action
    @IBAction func requestButtonAction(_ sender: Any) {
        // デリゲートメソッドを呼び出してメッセージを通知
        let inputText = messageInputTextField.text ?? Constants.EMPTY
        didSendMessage(messageTransform(messageText: inputText))
        messageInputTextField.endEditing(true)
    }
    
    @IBAction func changeInputArea(_ sender: Any) {
        if (messageInputTextField.text?.count == 0) {
            sendButton.isEnabled = false
        } else {
            sendButton.isEnabled = true
        }
    }
}

// MARK: TableViewdatasource
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

// MARK: TableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.HEADER_MARGIN
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let marginView = UIView()
        marginView.backgroundColor = .clear
        return marginView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constants.FOOTER_MARGIN
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let marginView = UIView()
        marginView.backgroundColor = .clear
        return marginView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.LOW_MARGIN
    }
}

// MARK: MessageActionDelegate
extension ViewController: MessageActionDelegate {
    func didSendMessage(_ message: Message) {
        self.sendMessage(message: message)
        messageInputTextField.text = Constants.EMPTY
        sendButton.isEnabled = false
        didMockSendMessage()
    }
    
    func didMockSendMessage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.SECONDS) {
            let message = Message(text: Constants.OTHER_MESSAGE_TEXT, User: Constants.USER_TYPE_OTHER)
            self.sendMessage(message: message)
        }
    }
    
    private func sendMessage(message: Message) {
        self.mockMessage.append(message)
        let newIndexPath = IndexPath(row: self.mockMessage.count - Constants.ARRAY_LAST_ELEMENT_OFFSET, section: 0)
        self.tableView.insertRows(at: [newIndexPath], with: .automatic)
        self.tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
    }
}
