import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryPage extends StatefulWidget {
  @override
  createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  static const methodChannel = const MethodChannel('ucoon.tech/battery');
  static const eventChannel = const EventChannel('ucoon.tech/charging');
  
  String _batteryLevel = 'Battery level: unknown.';
  String _chargingStatus = 'Battery status: unknown';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try{
      final String result = await methodChannel.invokeMethod('getBatteryLevel', {
        'key' : 'value_from_flutter',
      });
      batteryLevel = 'Battery level at $result % .';
    }on PlatformException {
      batteryLevel = 'Failed to get battery level.';
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  void _onEvent(Object event){
    setState(() {
      _chargingStatus = 'Battery status: ${event == 'charging' ? '' : 'dis'}charging.';
    });
  }

  void _onError(Object error){
    setState(() {
      _chargingStatus = 'Battery status: unknown.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('get battery level')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
                child: Text('Get Battery Level'), onPressed: _getBatteryLevel),
            Text(_batteryLevel),
            Text(_chargingStatus)
          ],
        ),
      ),
    );
  }
}
