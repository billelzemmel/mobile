import 'package:auto_ecole_app/constants/colors.dart';
import 'package:auto_ecole_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:auto_ecole_app/constants/contante.dart';
import 'package:auto_ecole_app/models/car.dart';
import 'package:auto_ecole_app/views/vehicule/controller/vehiculeController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_storage/get_storage.dart';

class CarBlock extends StatefulWidget {
  @override
  _CarBlockState createState() => _CarBlockState();
}

class _CarBlockState extends State<CarBlock> {
  late User? conuser;
  final boxs = GetStorage();

  @override
  void initState() {
    super.initState();
    conuser = boxs.read('connectedUser');
    if (conuser != null) {
      VehiculeController.fetchVehicule(conuser!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          title: Text('Vehucule List'),
        ),
        body: ListView.builder(
          itemCount: VehiculeController.vehiculeList.length,
          itemBuilder: (BuildContext context, int index) {
            Car car = VehiculeController.vehiculeList[index];
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('${car.type} ', style: kHeadingStyle),
                    subtitle: Text(
                      car.nom,
                      style: TextStyle(
                        color: greyColor,
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image(
                        image: NetworkImage(car.image),
                        width: 70.0,
                      ),
                    ),
                  ),
                  CachedNetworkImage(
                    imageUrl: car.image,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  Row(
                    //Divider line
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                          child: Divider(color: greyColor),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.credit_card),
                                SizedBox(width: 5.0),
                                Text(
                                  '${car.matricule.toString()}',
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                child: Text(
                                  car.disponible > 0
                                      ? 'Disponible'
                                      : 'Not Disponible',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
