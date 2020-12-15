import "package:flutter/material.dart";

class Rating extends StatefulWidget {
  final int rating;
  final String description;
  Rating({
    this.rating,
    this.description,
  });
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  bool isLoading = false;
  List<bool> isSelected = [false, false, false, false, false];
  _select(int index) {
    setState(() {
      for (var i = 0; i <= index; i++) isSelected[i] = true;
      for (var i = index + 1; i < 5; i++) isSelected[i] = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _select(this.widget.rating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: isSelected[0]
              ? Icon(
                  Icons.star,
                  color: Color(0xffFFD700),
                )
              : Icon(
                  Icons.star_border,
                  color: Colors.grey,
                ),
        ),
        Expanded(
          child: isSelected[1]
              ? Icon(
                  Icons.star,
                  color: Color(0xffFFD700),
                )
              : Icon(
                  Icons.star_border,
                  color: Colors.grey,
                ),
        ),
        Expanded(
          child: isSelected[2]
              ? Icon(
                  Icons.star,
                  color: Color(0xffFFD700),
                )
              : Icon(
                  Icons.star_border,
                  color: Colors.grey,
                ),
        ),
        Expanded(
          child: isSelected[3]
              ? Icon(
                  Icons.star,
                  color: Color(0xffFFD700),
                )
              : Icon(
                  Icons.star_border,
                  color: Colors.grey,
                ),
        ),
        Expanded(
          child: isSelected[4]
              ? Icon(
                  Icons.star,
                  color: Color(0xffFFD700),
                )
              : Icon(
                  Icons.star_border,
                  color: Colors.grey,
                ),
        ),
      ],
    );
  }
}
