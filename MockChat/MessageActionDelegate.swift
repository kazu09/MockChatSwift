//
//  MessageActionDelegate.swift
//  MockChat
//
//  Created by kazu on 2024/11/17.
//

protocol MessageActionDelegate: AnyObject {
    func didSendMessage(_ message: Message)
    func didMockSendMessage()
}
