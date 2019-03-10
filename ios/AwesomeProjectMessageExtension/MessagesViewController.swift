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
  var moduleInitializer: ModuleInitializer?
  var bridge: RCTBridge?
  var loadingView: UIView?

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
    self.moduleInitializer = ModuleInitializer(messagesVC: self)
    self.bridge = RCTBridge(delegate: self.moduleInitializer, launchOptions: nil)

    let rootView = RCTRootView(
      bridge: self.bridge,
      moduleName: "AwesomeProjectMessageExtension",
      initialProperties: nil
    )

    let rootViewController = UIViewController()
    rootViewController.view = rootView

    self.loadingView = Bundle.main.loadNibNamed("LoadingView", owner: nil, options: nil)![0] as? UIView
    self.loadingView?.bounds = self.view.bounds

    self.addChild(rootViewController)
    rootViewController.view.frame = self.view.bounds
    rootViewController.view.translatesAutoresizingMaskIntoConstraints = false

    self.view.addSubview(rootViewController.view)
    self.view.addSubview(self.loadingView!)

    NSLayoutConstraint.activate([
      rootViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      rootViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      rootViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
      rootViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ])

    self.didMove(toParent: self)
  }
}
