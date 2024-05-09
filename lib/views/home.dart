import 'package:auto_ecole_app/common/widgets/custom_heading.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:auto_ecole_app/models/user.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
  /*   final box = GetStorage();
    final User user = box.read('connectedUser');
    print(user.nom); */
    return Scaffold(
      appBar: AppBar(
        title: CustomHeading(
          title: /* user.nom */ "da",
          subTitle: 'Welcome',
          color: Colors.white,
        ),
        leading: CircleAvatar(
/*           backgroundImage: NetworkImage(user.image_url),
 */        ),
      ),
      body: Center(),
    );
  }
}
