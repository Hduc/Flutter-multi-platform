import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:severingthing/model/app_state_model.dart';
import 'package:severingthing/res/strings/strings.dart';

class AppManager extends ChangeNotifier {
  AppState _currentState = AppState();
  MqttServerClient? _client;
  late String _identifier;

  String _topic = "";

  void initializeMQTTClient({
    required String username,
    required String password,
    required String identifier,
  }) {
    _identifier = identifier;
    _client = MqttServerClient(AppStrings.mqttBorker, _identifier);
    _client!.port = 1883;
    _client!.keepAlivePeriod = 20;
    _client!.onDisconnected = onDisconnected;
    _client!.secure = false;
    _client!.logging(on: true);

    _client!.onConnected = onConnected;
    _client!.onSubscribed = onSubscribed;
    _client!.onUnsubscribed = onUnsubscribed;

    final connMess = MqttConnectMessage()
        .withClientIdentifier(_identifier)
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .authenticateAs(username, password)
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    _client!.connectionMessage = connMess;
  }

  AppState get currentState => _currentState;

  void connect() async {
    assert(_client != null);
    try {
      print('EXAMPLE::Mosquitto start client connecting....');
      _currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
      updateState();
      await _client!.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('Disconnected');
    _client!.disconnect();
  }

  void publish(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client!.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
    _currentState
        .setAppConnectionState(MQTTAppConnectionState.connectedSubscribed);
    updateState();
  }

  void onUnsubscribed(String? topic) {
    print('EXAMPLE::onUnsubscribed confirmed for topic $topic');
    _currentState.clearText();
    _currentState
        .setAppConnectionState(MQTTAppConnectionState.connectedUnSubscribed);
    updateState();
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (_client!.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    _currentState.clearText();
    _currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
    updateState();
  }

  /// The successful connect callback
  void onConnected() {
    _currentState.setAppConnectionState(MQTTAppConnectionState.connected);
    updateState();
    print('EXAMPLE::Mosquitto client connected....');
    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message!);
      _currentState.setReceivedText(pt);
      updateState();
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }

  void subScribeTo(String topic) {
    // Save topic for future use
    _topic = topic;
    _client!.subscribe(topic, MqttQos.atLeastOnce);
  }

  /// Unsubscribe from a topic
  void unSubscribe(String topic) {
    _client!.unsubscribe(topic);
  }

  /// Unsubscribe from a topic
  void unSubscribeFromCurrentTopic() {
    _client!.unsubscribe(_topic);
  }

  void updateState() {
    //controller.add(_currentState);
    notifyListeners();
  }
}
