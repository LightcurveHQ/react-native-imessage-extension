//
//  MessagesViewController.swift
//  AwesomeProjectMessageExtension
//

import UIKit
import Messages

protocol MessagesViewControllerDelegate {
  func didSelect(message: MSMessage, conversation: MSConversation)
  func didReceive(message: MSMessage, conversation: MSConversation)
  func didStartSending(message: MSMessage, conversation: MSConversation)
  func didCancelSending(message: MSMessage, conversation: MSConversation)
  func didTransition(to presentationStyle: MSMessagesAppPresentationStyle)
}

class MessagesViewController: MSMessagesAppViewController {
  var delegate: MessagesViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.removeAllChildViewControllers()
  }

  override func willBecomeActive(with conversation: MSConversation) {
    self.presentReactNativeView()
  }

  override func didSelect(_ message: MSMessage, conversation: MSConversation) {
    self.delegate?.didSelect(message: message, conversation: conversation)
  }

  override func didReceive(_ message: MSMessage, conversation: MSConversation) {
    self.delegate?.didReceive(message: message, conversation: conversation)
  }

  override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
    self.delegate?.didStartSending(message: message, conversation: conversation)
  }

  override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
    self.delegate?.didCancelSending(message: message, conversation: conversation)
  }

  override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
    self.delegate?.didTransition(to: presentationStyle)
  }

  private func removeAllChildViewControllers() {
    for child in self.children {
      child.willMove(toParent: nil)
      child.view.removeFromSuperview()
      child.removeFromParent()
    }
  }

  private func presentReactNativeView() {
    self.removeAllChildViewControllers()

    let bundleURL = RCTBundleURLProvider.sharedSettings()?.jsBundleURL(forBundleRoot: "index.message", fallbackResource: nil)

    let rootView = RCTRootView(bundleURL: bundleURL, moduleName: "AwesomeProjectMessageExtension", initialProperties: nil, launchOptions: nil)

    let rootViewController = UIViewController()
    rootViewController.view = rootView

    self.addChild(rootViewController)
    rootViewController.view.frame = self.view.bounds
    rootViewController.view.translatesAutoresizingMaskIntoConstraints = false

    self.view.addSubview(rootViewController.view)

    NSLayoutConstraint.activate([
      rootViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      rootViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      rootViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
      rootViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      ])

    self.didMove(toParent: self)
  }
}
