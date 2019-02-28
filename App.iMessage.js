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

  render() {
    return (
      <View>
        <Text>
          Welcome to React Native iMessage Extension!
        </Text>

        <Button
          title="Toggle the Presentation Style"
          onPress={this.onTogglePresentationStyle}
          disabled={!this.state.presentationStyle}
        />
      </View>
    );
  }
}
