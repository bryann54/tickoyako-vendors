import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tickoyakovendors/core/colors.dart';
import 'package:tickoyakovendors/core/commons/bg-widget.dart';
import 'package:tickoyakovendors/core/strings.dart';
import 'package:tickoyakovendors/features/home_screen/presentation/widgets/custom_drawer_widget.dart';

class TicketScanningScreen extends StatefulWidget {
  final bool fromDrawer;

  const TicketScanningScreen({super.key, this.fromDrawer = false});

  @override
  State<TicketScanningScreen> createState() => _TicketScanningScreenState();
}

class _TicketScanningScreenState extends State<TicketScanningScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _qrController;
  String? scannedResult;
  bool isScanning = true;

  @override
  void reassemble() {
    super.reassemble();
    if (mounted) {
      _qrController?.pauseCamera();
      _qrController?.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    _qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedResult = scanData.code;
        isScanning = false;
      });
      controller.pauseCamera(); // Pause to prevent multiple scans
    }, onError: (error) {
      setState(() {
        scannedResult = 'Error scanning QR code';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: AnimatedBackgroundWidget(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120.0,
              floating: false,
              pinned: true,
              stretch: true,
              backgroundColor: AppColors.primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [AppColors.accentColor, Colors.white],
                      ).createShader(bounds),
                      child: const Text(
                        qr_scanner,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primaryColor,
                        AppColors.primaryColor.withOpacity(0.8),
                        AppColors.secondaryColor,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -30,
                        right: -30,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -20,
                        left: -20,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              leading: widget.fromDrawer
                  ? IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                    )
                  : IconButton(
                      icon: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.arrow_back,
                            color: AppColors.primaryColor),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 500,
                      width: 450,
                      child: QRView(
                        key: _qrKey,
                        onQRViewCreated: _onQRViewCreated,
                        overlay: QrScannerOverlayShape(
                          borderColor: AppColors.accentColor,
                          borderRadius: 10,
                          borderLength: 30,
                          borderWidth: 10,
                          cutOutSize: 290,
                        ),
                      ),
                    ),
                  ),
                  if (scannedResult != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Scanned Code: $scannedResult',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.qr_code_2_outlined),
                      label: const Text('Scan QR code'),
                      onPressed: isScanning
                          ? null
                          : () {
                              // Restart QR scanning
                              _qrController?.resumeCamera();
                              setState(() {
                                scannedResult = null;
                                isScanning = true;
                              });
                            },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _qrController?.dispose();
    super.dispose();
  }
}
