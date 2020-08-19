import 'package:erobot_app/import/importall.dart';
import 'package:flutter/services.dart';
//import 'package:toast/toast.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothList extends StatefulWidget {
  BluetoothList({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  _BluetoothListState createState() => _BluetoothListState();
}

class _BluetoothListState extends State<BluetoothList> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;

  // Track the Bluetooth connection with the remote device
  BluetoothConnection connection;

  int _deviceState;
  bool isDisconnecting = false;

  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection != null && connection.isConnected;

  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice _device;
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() => _bluetoothState = state);
    });

    _deviceState = 0;

    enableBluetooth();

    FlutterBluetoothSerial.instance.onStateChanged().listen(
      (BluetoothState state) {
        setState(
          () {
            _bluetoothState = state;
            getPairedDevices();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Bluetooth List',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Palette.blue_pacific,
            ),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bluetooth',
                  style: TextStyle(color: Colors.white),
                ),
                Switch(
                  activeColor: Colors.white,
                  value: _bluetoothState.isEnabled,
                  onChanged: (_isConnected) {
                    future() async {
                      if (_isConnected)
                        await FlutterBluetoothSerial.instance.requestEnable();
                      else
                        await FlutterBluetoothSerial.instance.requestDisable();

                      // In order to update the devices list
                      await getPairedDevices();

                      // Disconnect from any device before turning off Bluetooth
                      if (_connected) _disconnect();
                    }

                    future().then((_) => setState(() {}));
                  },
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
            child: Text(
              !_bluetoothState.isEnabled
                  ? 'Please turn on Bluetooth'
                  : _devicesList.isNotEmpty
                      ? 'Devices found'
                      : 'Device not found!',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
          Column(
            children: <Widget>[
              for (BluetoothDevice devices in _devicesList)
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(devices.name),
                      FlatButton(
                        color: Palette.blueSplash,
                        child: Text(
                          _connected ? 'Disconnect' : 'Connect',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: _connected ? _disconnect : _connect,
                      ),
                    ],
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Avoid memory leak and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    super.dispose();
  }

  Future<void> enableBluetooth() async {
    // Retrieving the current Bluetooth state
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) {
      return;
    }

    setState(() {
      _devicesList = devices;
    });
  }

  void _connect() async {
    if (_device == null) {
      show('No device selected');
    } else {
      if (!isConnected) {
        await BluetoothConnection.toAddress(_device.address)
            .then((_connection) {
          print('Connected to the device');
          connection = _connection;
          setState(() {
            _connected = true;
          });

          connection.input.listen(null).onDone(() {
            if (isDisconnecting) {
              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
            if (this.mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
        show('Device connected');
      }
    }
  }

  void _disconnect() async {
    setState(() {
      _deviceState = 0;
    });

    await connection.close();
    show('Device disconnected');
    if (!connection.isConnected) {
      setState(() {
        _connected = false;
      });
    }
  }

  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    widget._scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: new Text(
          message,
        ),
        duration: duration,
      ),
    );
  }
}
