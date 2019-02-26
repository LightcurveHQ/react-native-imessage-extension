//
//  MessagesViewController.swift
//  AwesomeProjectMessageExtension
//
//  Created by Altay Aydemir on 22.02.19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
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

  override func didResignActive(with conversation: MSConversation) {
  }

  override func didReceive(_ message: MSMessage, conversation: MSConversation) {
  }

  override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
  }

  override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
  }

  override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
  }

  override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
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
