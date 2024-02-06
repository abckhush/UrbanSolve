import 'dart:io';
import 'package:flutter/material.dart';
import 'package:error404/controller/firestore.dart';
import 'package:error404/utils/popupmessage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:google_fonts/google_fonts.dart';

LocationData? location1;

class ReportPotholeView extends StatefulWidget {
  const ReportPotholeView({super.key});

  @override
  State<ReportPotholeView> createState() => _ReportPotholeViewState();
}

class _ReportPotholeViewState extends State<ReportPotholeView> {
  Location location = Location();
  LocationData? _locationData;
  PopUpMessage popUpMessage = PopUpMessage();

  @override
  void initState() {
    super.initState();
    loadmodel();
    getlocation();
  }

  detect_image(File image) async {
    var prediction = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 4,
        threshold: 0.001,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _loading = false;
      _predictions = prediction!;
      print(_predictions);
    });
  }

  bool _loading = true;
  late File _image;
  final imagePicker = ImagePicker();
  List _predictions = [];

  loadmodel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/label.txt');
  }

  Future<LocationData> getlocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {}
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {}
    }

    var locationData = await location.getLocation();
    print(locationData);
    setState(() {
      location1 = locationData;
    });
    return locationData;
  }

  _loadimagefromgallery() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    detect_image(_image);
  }

  _loadimagefromcamera() async {
    var image = await imagePicker.pickImage(source: ImageSource.camera);

    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    detect_image(_image);
  }

  Future<void> retrieveLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) {
        print('Location services are disabled.');
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Location permission denied.');
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      _locationData = _locationData;
    });
  }

  Widget build(BuildContext context) {
    SendDetails sendDetails = SendDetails();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 234, 229),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 237, 234, 229),
        title: Row(
          children: [
            Icon(
              Icons.report,
              color: Color.fromARGB(255, 2, 102, 112),
            ),
            SizedBox(width: 10),
            Text(
              'Report An Issue',
              style: GoogleFonts.petrona(
                color: Color.fromARGB(255, 2, 102, 112),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 237, 234, 229)),
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  // child: Container(
                  // decoration: const BoxDecoration(
                  //     borderRadius: BorderRadius.only(
                  //       bottomLeft: Radius.circular(30),
                  //       bottomRight: Radius.circular(30),
                  //     ),
                  //color: Color.fromARGB(255, 243, 241, 241)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/report.png',
                        height: 250,
                        width: 250,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Smooth out your route, Report potholes for a sleeker commute!',
                        style: GoogleFonts.petrona(
                            color: Color.fromARGB(255, 2, 102, 112),
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Capture / Pick Pot-Hole Images:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  _loadimagefromcamera();
                },
                child: Container(
                    height: 50,
                    width: 300,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 159, 237, 215),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera,
                          color: Color.fromARGB(255, 2, 102, 112),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Capture Image',
                          style: TextStyle(
                              color: Color.fromARGB(255, 2, 102, 112)),
                        )
                      ],
                    ))),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () {
                  _loadimagefromgallery();
                },
                child: Container(
                    height: 50,
                    width: 300,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 159, 237, 215),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: Color.fromARGB(255, 2, 102, 112),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Upload Image',
                          style: TextStyle(
                              color: Color.fromARGB(255, 2, 102, 112)),
                        )
                      ],
                    ))),
            const SizedBox(
              height: 20,
            ),
            _loading == false
                ? Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.file(_image),
                      ),
                      Text(_predictions[0]['label']
                              .toString()
                              .substring(1)
                              .isNotEmpty
                          ? _predictions[0]['label'].toString().substring(1)
                          : "No Pothole Detected"),
                      Text(
                          'Confidence ${_predictions[0]['confidence'].toString().substring(2, 4)}.${_predictions[0]['confidence'].toString().substring(4, 6)}%'),
                      Text(
                          ' Lat:${location1!.latitude.toString()}, Long : ${location1!.longitude.toString()}'),
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      _predictions[0]['label'].toString().substring(1) ==
                              ' Pothole'
                          ? GestureDetector(
                              onTap: () async {
                                popUpMessage.flushbarmessage(context,
                                    "Wait for a moment", "Sending Details");
                                await retrieveLocation();
                                // ignore: use_build_context_synchronously

                                // ignore: use_build_context_synchronously
                                sendDetails
                                    .sendDetails(
                                        context,
                                        LatLng(location1!.latitude!,
                                            location1!.longitude!))
                                    .then((value) {
                                  Navigator.pop(context);
                                  popUpMessage.flushbarmessage(
                                      context,
                                      "Thanks for you contribution",
                                      "Successfully Reported");
                                });
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const ReportPotholeView()));
                              },
                              child: Container(
                                height: 50,
                                width: 300,
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: const Center(
                                    child: Text(
                                  'Report Pothole',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            )
                          : const SizedBox(
                              height: 30,
                              child: Text("No pothole Detected"),
                            ),
                    ],
                  )
                : const Icon(Icons.arrow_circle_up),
          ],
        ),
      ),
    );
  }
}