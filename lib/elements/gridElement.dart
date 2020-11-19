import "package:flutter/material.dart";

class GridElement extends StatelessWidget {
  final IconData icon;
  final String title;
  final dynamic onTap;

  GridElement({this.icon, this.title, this.onTap});

  final Color secondaryColor = Color.fromRGBO(42, 48, 42, 1);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 100,
        width: 80,
        decoration: BoxDecoration(
          color: Color.fromRGBO(215, 219, 224, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              this.icon,
              size: 60,
              color: secondaryColor,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                this.title,
                style: TextStyle(
                  fontFamily: "Helvetica Neue",
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: secondaryColor,
                ),
              ),
            )
          ],
        ),
      ),
      onTap: this.onTap,
    );
  }
}
