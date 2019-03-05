//
// DevMenu.js
//

import React from 'react';
import { NativeModules, View, TouchableHighlight, Text, StyleSheet } from 'react-native';

const styles = StyleSheet.create({
  wrapper: {
    backgroundColor: 'rgba(0, 0, 0, 0.95)',
    alignItems: 'center',
    justifyContent: 'center',
    width: '100%',
    padding: 2,
    flexDirection: 'row',
    marginBottom: 10,
  },
  button: {
    alignItems: 'center',
    padding: 6,
    borderRadius: 4,
  },
  buttonText: {
    fontSize: 12,
    color: 'white',
  },
});

class DevMenu extends React.Component {
  state = {
    liveReloadEnabled: false,
    remoteDebuggingEnabled: false,
  }

  onToggleRemoteDebugging = () => {
    const remoteDebuggingEnabled = !this.state.remoteDebuggingEnabled;

    NativeModules.DevSettings.setIsDebuggingRemotely(remoteDebuggingEnabled);

    this.setState({
      remoteDebuggingEnabled,
    });
  }

  onToggleLiveReload = () => {
    const liveReloadEnabled = !this.state.liveReloadEnabled;

    NativeModules.DevSettings.setLiveReloadEnabled(liveReloadEnabled);

    this.setState({
      liveReloadEnabled,
    });
  }

  render() {
    const { liveReloadEnabled, remoteDebuggingEnabled } = this.state;

    return (
      <View style={styles.wrapper}>
        <TouchableHighlight style={styles.button} onPress={this.onToggleRemoteDebugging}>
          <Text style={styles.buttonText}>
            {remoteDebuggingEnabled ? 'Disable' : 'Enable'} Remote Debugging
          </Text>
        </TouchableHighlight>

        <TouchableHighlight style={styles.button} onPress={this.onToggleLiveReload}>
          <Text style={styles.buttonText}>
            {liveReloadEnabled ? 'Disable' : 'Enable'} Live Reload
          </Text>
        </TouchableHighlight>
      </View>
    );
  }
}

export default DevMenu;
