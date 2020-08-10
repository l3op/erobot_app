# Erobot-App

Start date: 24 July, 2020

Welcome to Open Source Project.<br>
Erobot is designed to control Arduino robot via Bluetooth. The app is developing using Flutter.
<br>
<img src="./assets/5screen.png"><br><br>
Functions of the app are:<br>

* Farm Assistant : (in planning)
* Arduino Documents : Document of how to build robots
* Login, Sign up on the app
* Sender : Send string or character to Arduino via bluetooth
* Ball Shooter : A controller to control ball shooter robot, servo, and speed
* Arduino Car : A controller to controll Arduino car and spead
* IR Remote : Vitual IR Remote via Bluetooth.

<br>
<img src="./assets/4screen.png"><br>
Prototype and design here: https://www.figma.com/file/x1edWP3L1by9QWuI5EVUiP/E-Robot-App?node-id=0%3A1
<br>
<img src="./assets/2screen.png"><br>
Build release to test:<br>
@Method1:<br>
:~/erobot_app$ flutter build apk --release<br>
:~/erobot_app$ build/app/outputs/flutter-apk/app-release.apk
<br><br>
@Method2: this produce 3 apk, choose 1 for your device<br>
:~/erobot_app$ flutter build apk --target-platform android-arm, android-arm64, android-x64 --split-per-abi
<br>
:~/erobot_app$ flutter install build/app/outputs/apk/release/app-arm64-v8a-release.apk
<br><br>
@Method3:<br>
:~/erobot_app$ flutter build appbundle --target-platform android-arm, android-arm64, android-x64
<br>
:~/erobot_app$ flutter install build/app/outputs/bundle/release/app-release.aab

 
 
 
