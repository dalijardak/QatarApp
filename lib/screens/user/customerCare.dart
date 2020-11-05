import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qatar_app/elements/gridElement.dart';
import 'package:qatar_app/screens/user/requestForm.dart';
import 'package:qatar_app/screens/user/reviewScreen.dart';
import 'package:qatar_app/util/size.dart';

import '../contact_page.dart';

class CustomerCare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(153, 5, 5, 1),
        title: Text("Customer Care"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.feedback),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FeedbackPage(),
              ),
            ),
          ),
        ],
      ),
      body: Container(
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
                    title: "Suggestions",
                    icon: Icons.rate_review,
                    onTap: () =>
                        Navigator.pushNamed(context, "/SuggestionPage"),
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
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        child: BottomAppBar(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: Color.fromRGBO(153, 5, 5, 1),
            ),
            height: getY(context) * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.phone,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                Text(
                  "Contact Us",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Georgia",
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Contact(),
          ),
        ),
      ),
    );
  }
}
