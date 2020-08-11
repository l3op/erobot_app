import 'package:erobot_app/widgets/layerscard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:erobot_app/screens/car_controller/controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StaggeredGridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        children: <Widget>[
          ThreeLayerCard(
              title: 'Farm Assitant',
              desription: 'Make your farming smarter',
              cardIndex: 0,
              path: 'assets/home/arduino_doc.png',
              onPressed: () {
                Navigator.pushNamed(context, '/farm_assistant');
              }),
          ThreeLayerCard(
              title: 'Sender',
              desription: 'to Send text to arduino via Bluetooth',
              cardIndex: 1,
              path: 'assets/home/our_team.png',
              onPressed: () {
                Navigator.pushNamed(context, '/sender');
              }),
          ThreeLayerCard(
              title: 'Ball Shooter',
              desription:
                  'to Control ball shooter arduino car, servo, and speed',
              cardIndex: 2,
              path: 'assets/home/ball_shooter.png',
              onPressed: () {
                buildtoCarController(context, 1);
              }),
          ThreeLayerCard(
              title: 'Arduino Car',
              desription: 'Remoter to Control Arduino Car with speed',
              cardIndex: 3,
              path: 'assets/home/car_runner.png',
              onPressed: () {
                buildtoCarController(context, 2);
              }),
          ThreeLayerCard(
              title: 'IR Remoter',
              desription: 'to Control Light and Buzzer Arduino',
              cardIndex: 4,
              path: 'assets/home/ir_controller.png',
              onPressed: () {
                Navigator.pushNamed(context, '/ir_remote');
              })
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 150),
          StaggeredTile.extent(1, 150),
          StaggeredTile.extent(1, 150),
          StaggeredTile.extent(1, 150),
          StaggeredTile.extent(1, 150),
        ],
      ),
    );
  }

  Future buildtoCarController(BuildContext context, int _cardIndex) {
    return Navigator.push(context,
        MaterialPageRoute(builder: (context) => Controller(_cardIndex)));
  }
}
