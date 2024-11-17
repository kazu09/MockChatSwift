//
//  ChatFrameCell.swift
//  MockChat
//
//  Created by kazu on 2024/11/16.
//

import UIKit

class ChatFrameCell: UITableViewCell {
    @IBOutlet weak var bubbleBackgroundView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var bubbleLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bubbleTrailingConstraint: NSLayoutConstraint!
    
    struct Constants {
        static let RADIUS_SIZE: CGFloat = 15
        static let USER_ME: Int = 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        // 吹き出しの背景設定
        bubbleBackgroundView.layer.cornerRadius = Constants.RADIUS_SIZE
        bubbleBackgroundView.backgroundColor = .azure
        
        // セル全体の背景色を透明にする
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        // メッセージラベルの設定
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.italicSystemFont(ofSize: 12.0) 
    }
    
    func configure(with message: Message) {
        messageLabel.text = message.text
        
        if (message.User == Constants.USER_ME) {
            // 自分
            bubbleTrailingConstraint.priority = .defaultLow
            bubbleLeadingConstraint.priority = .defaultHigh
            bubbleBackgroundView.backgroundColor = .deepskyblue
            messageLabel.textColor = .black
        } else {
            // 相手
            bubbleTrailingConstraint.priority = .defaultHigh
            bubbleLeadingConstraint.priority = .defaultLow
            bubbleBackgroundView.backgroundColor = .gainsboro
            messageLabel.textColor = .black
        }
    }
}
