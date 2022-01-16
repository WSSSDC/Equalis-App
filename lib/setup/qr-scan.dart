import 'package:equalis/data/profile.dart';
import 'package:equalis/setup/passport.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:equalis/elements/rounded_rect.dart';

List<CameraDescription>? cameras;

class QRScan extends StatefulWidget {
  const QRScan({ Key? key }) : super(key: key);

  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  CameraController? controller;
  Barcode? result;
  QRViewController? qrcontroller;
  bool qrfound = false;

  @override
  void initState() {
    initCamera();
    super.initState();
  }

  initCamera() async {
    cameras = await availableCameras();
    print(cameras);
    controller = CameraController(cameras![0], ResolutionPreset.high);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  _onQRViewCreated(QRViewController qrViewController) {
    qrcontroller = qrViewController;
    qrViewController.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (!qrfound) {
          qrfound = true;
          Profile.qrCode = result!.code!;
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Passport()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                RoundedRectangle(
                  child: controller != null
                      ? Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        height: 600,
                        child: QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                          ),
                      )
                      : Container(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 200.0),
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.white,
                            width: 8.0
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(25))
                        ),
                      )
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 20.0),
            Text("Scan the QR Code you received in the mail", style: Theme.of(context).textTheme.subtitle1,)
          ],
        ),
      ),
    );
  }
}