//
//  MessagesEventEmitter.swift
//  AwesomeProjectMessageExtension
//

import Foundation
import Messages

enum Events: String {
  // UI - Remote
  case DID_RECEIVE_MESSAGE = "didReceiveMessage"

  // UI - Interaction
  case DID_SELECT_MESSAGE = "didSelectMessage"
  case DID_START_SENDING_MESSAGE = "didStartSendingMessage"
  case DID_CANCEL_SENDING_MESSAGE = "didCancelSendingMessage"

  // UI - Layout
  case PRESENTATION_STYLE_CHANGED = "onPresentationStyleChanged"
}

@objc(MessagesEventEmitter)
class MessagesEventEmitter: RCTEventEmitter {
  var hasListeners: Bool = false

  override static func moduleName() -> String! {
    return "MessagesEventEmitter"
  }

  override static func requiresMainQueueSetup() -> Bool {
    return false
  }

  override func startObserving() {
    self.hasListeners = true
  }

  override func stopObserving() {
    self.hasListeners = false
  }

  override func supportedEvents() -> [String]! {
    return [
      Events.PRESENTATION_STYLE_CHANGED.rawValue,
      Events.DID_SELECT_MESSAGE.rawValue,
      Events.DID_RECEIVE_MESSAGE.rawValue,
      Events.DID_START_SENDING_MESSAGE.rawValue,
      Events.DID_CANCEL_SENDING_MESSAGE.rawValue,
    ]
  }
}

extension MessagesEventEmitter: MessagesViewControllerDelegate {
  func didSelect(message: MSMessage, conversation: MSConversation) {
    guard self.hasListeners else { return }

    self.sendEvent(withName: Events.DID_SELECT_MESSAGE.rawValue, body: [
      "message": Mappers.messageToObject(message: message),
      "conversation": Mappers.conversationToObject(conversation: conversation)
    ])
  }

  func didReceive(message: MSMessage, conversation: MSConversation) {
    guard self.hasListeners else { return }

    self.sendEvent(withName: Events.DID_RECEIVE_MESSAGE.rawValue, body: [
      "message": Mappers.messageToObject(message: message),
      "conversation": Mappers.conversationToObject(conversation: conversation)
    ])
  }

  func didStartSending(message: MSMessage, conversation: MSConversation) {
    guard self.hasListeners else { return }

    self.sendEvent(withName: Events.DID_START_SENDING_MESSAGE.rawValue, body: [
      "message": Mappers.messageToObject(message: message),
      "conversation": Mappers.conversationToObject(conversation: conversation)
    ])
  }

  func didCancelSending(message: MSMessage, conversation: MSConversation) {
    guard self.hasListeners else { return }

    self.sendEvent(withName: Events.DID_CANCEL_SENDING_MESSAGE.rawValue, body: [
      "message": Mappers.messageToObject(message: message),
      "conversation": Mappers.conversationToObject(conversation: conversation)
    ])
  }

  func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
    guard self.hasListeners else { return }

    self.sendEvent(withName: Events.PRESENTATION_STYLE_CHANGED.rawValue, body: [
      "presentationStyle": Mappers.presentationStyleToString(style: presentationStyle)
    ])
  }
}
