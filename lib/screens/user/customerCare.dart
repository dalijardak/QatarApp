import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qatar_app/elements/gridElement.dart';
import 'package:qatar_app/screens/user/requestForm.dart';
import 'package:qatar_app/util/size.dart';

class CustomerCare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              height: getY(context) * 0.2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                    image: AssetImage("assets/services.jpg"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(15),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                GridElement(
                  title: "Complaints ",
                  icon: Icons.info,
                ),
                GridElement(
                  title: "Suggestions",
                  icon: Icons.rate_review,
                ),
                GridElement(
                  title: "Maintenance Requests",
                  icon: FontAwesomeIcons.tools,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddRequest(),
                    ),
                  ),
                ),
                GridElement(
                  title: "Chat",
                  icon: Icons.chat,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
