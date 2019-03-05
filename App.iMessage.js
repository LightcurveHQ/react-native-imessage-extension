//
// App.iMessage.js
//

import React, { Component } from 'react';
import {
  Text,
  View,
  NativeModules,
  NativeEventEmitter,
  Button,
} from 'react-native';
import DevMenu from './DevMenu';

const { MessagesManager, MessagesEventEmitter } = NativeModules;
const MessagesEvents = new NativeEventEmitter(MessagesEventEmitter);

export default class App extends Component {
  state = {
    presentationStyle: '',
  }

  componentDidMount() {
    MessagesManager
      .getPresentationStyle(presentationStyle => this.setState({ presentationStyle }))

    MessagesEvents
      .addListener('onPresentationStyleChanged', ({ presentationStyle }) => this.setState({ presentationStyle }));
  }

  onTogglePresentationStyle = () => {
    MessagesManager
      .updatePresentationStyle(this.state.presentationStyle === 'expanded' ? 'compact' : 'expanded')
      .then(presentationStyle => this.setState({ presentationStyle }))
  }

  onComposeMessage = () => {
    MessagesManager.composeMessage({
      layout: {
        imageName: 'zebra.jpg',
        imageTitle: 'Image Title',
        imageSubtitle: 'Image Subtitle',
      },
      summaryText: 'Sent a message from AwesomeMessageExtension',
      url: ''
    })
    .then(message => console.log('Successfully composed a message: ', message))
    .catch(error => console.log('An error occurred while composing the message: ', error))
  }

  onOpenURL = () => {
    MessagesManager.openURL('url://test')
      .then(() => console.log('Successfully opened url!'))
      .catch(error => console.log('An error occurred while opening the URL: ', error))
  }

  render() {
    return (
      <View>
        {__DEV__ && <DevMenu />}

        <Text>
          Welcome to React Native iMessage Extension!
        </Text>

        <Button
          title="Toggle the Presentation Style"
          onPress={this.onTogglePresentationStyle}
          disabled={!this.state.presentationStyle}
        />

        <Button
          title="Compose Message"
          onPress={this.onComposeMessage}
        />

        <Button
          title="Open URL"
          onPress={this.onOpenURL}
        />
      </View>
    );
  }
}
