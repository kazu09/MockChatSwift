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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showkeyboard),name:UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hidekeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
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

