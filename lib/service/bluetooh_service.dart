import 'package:erobot_app/import/importall.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothList extends StatefulWidget {
  BluetoothList({Key key}) : super(key: key);
  @override
  _BluetoothListState createState() => _BluetoothListState();
}

class _BluetoothListState extends State<BluetoothList> {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = List<BluetoothDevice>();
  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();
  BluetoothDevice _connectedDevice;
  List<BluetoothService> _services;

  @override
  void initState() {
    super.initState();
    _scanDevices();
  }

  _scanDevices() {
    flutterBlue.startScan();
    flutterBlue.connectedDevices.asStream().listen(
      (List<BluetoothDevice> devices) {
        for (BluetoothDevice device in devices) _addDeviceTolist(device);
      },
    );
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) _addDeviceTolist(result.device);
    });
  }

  _addDeviceTolist(final BluetoothDevice device) {
    if (!devicesList.contains(device)) setState(() => devicesList.add(device));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bluetooth List',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: _buildView(),
    );
  }

  ListView _buildView() {
    if (_connectedDevice != null) {
      return _buildConnectDeviceView();
    }
    return _buildListViewOfDevices();
  }

  ListView _buildConnectDeviceView() {
    List<Container> containers = List<Container>();

    for (BluetoothService service in _services) {
      List<Widget> characteristicsWidget = List<Widget>();

      for (BluetoothCharacteristic characteristic in service.characteristics) {
        characteristicsWidget.add(
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      characteristic.uuid.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Value: ' + readValues[characteristic.uuid].toString(),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        );
      }
      containers.add(
        Container(
          child: ExpansionTile(
            title: Text(service.uuid.toString()),
            children: characteristicsWidget,
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  ListView _buildListViewOfDevices() {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        for (BluetoothDevice device in devicesList)
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        device.name == '' ? '(Unknown device)' : device.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        device.id.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                FlatButton(
                  color: Colors.blue,
                  child: Text(
                    'Connect',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    print("Device name: " + device.name);
                    print("Device ID: " + device.id.toString());
                    flutterBlue.stopScan();
                    try {
                      await device.connect();
                    } catch (e) {
                      if (e.code != 'already_connected') {
                        print("Error: " + e.toString());
                        throw e;
                      }
                    } finally {
                      print('Finally!');
                      _services = await device.discoverServices();
                    }
                    setState(() {
                      _connectedDevice = device;
                      print("Connected device: " + _connectedDevice.toString());
                    });
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
