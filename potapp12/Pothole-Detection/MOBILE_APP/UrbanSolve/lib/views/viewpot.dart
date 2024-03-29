import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:error404/controller/firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: must_be_immutable
class ViewPotholeView extends StatefulWidget {
  SendDetails sendDetails = SendDetails();
  ViewPotholeView({super.key});

  @override
  State<ViewPotholeView> createState() => _ViewPotholeViewState();
}

class _ViewPotholeViewState extends State<ViewPotholeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseDatabase.instance.ref('Potholes').onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              Map<dynamic, dynamic> potholes =
                  snapshot.data!.snapshot.value as dynamic;
              List<dynamic> potholesList = [];
              potholesList.clear();
              potholes.forEach((key, value) {
                potholesList.add(value);
              });
              return SlidingUpPanel(
                color: Colors.purple.shade100,
                minHeight: 150,
                maxHeight: 700,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                panel: Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    // dragStartBehavior: DragStartBehavior.start,
                    itemCount: potholesList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 11, 8, 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.purple.shade500,
                          ),
                          child: ListTile(
                            tileColor: Colors.black,
                            title: Text(
                                "Pothole ${index + 1} at ${potholesList[index]['lat']}, ${potholesList[index]['lng']}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                FirebaseDatabase.instance
                                    .ref('Potholes')
                                    .child(potholes.keys.toList()[index])
                                    .remove();
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                body: Center(
                  child: Column(
                    children: [
                      Flexible(
                          child: FlutterMap(
                              options: const MapOptions(
                                initialCenter: LatLng(28.523555, 77.5745812),
                                initialZoom: 17,
                              ),
                              children: [
                            TileLayer(
                              urlTemplate:
                                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                              // subdomains: const ['a', 'b', 'c'],
                            ),
                            MarkerLayer(markers: [
                              const Marker(
                                  point: LatLng(28.523555, 77.5745812),
                                  child: (Icon(
                                    Icons.location_history,
                                    color: Color.fromARGB(255, 239, 10, 10),
                                    size: 25,
                                  ))),
                              for (int i = 0; i < potholesList.length; i++)
                                Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: LatLng(potholesList[i]['lat'],
                                        potholesList[i]['lng']),
                                    child: IconButton(
                                      icon: const Icon(Icons.location_on_outlined,
                                          size: 20,
                                          color:
                                              Color.fromARGB(255, 239, 17, 17)),
                                      onPressed: () {
                                        // print("Marker tapped");
                                      },
                                    ))
                            ])
                          ])),
                    ],
                  ),
                ),
              );
            }));
  }
}
