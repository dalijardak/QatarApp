import "package:flutter/material.dart";

class Rating extends StatefulWidget {
  int rating;
  final String description;
  Rating({
    this.rating,
    this.description,
  });
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int feedBackRating = 5;
  bool isLoading = false;
  List<bool> isSelected = [false, false, false, false, false];
  _onTap(int index) {
    setState(() {
      for (var i = 0; i <= index; i++) isSelected[i] = true;
      for (var i = index + 1; i < 5; i++) isSelected[i] = false;
      this.widget.rating = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: IconButton(
            icon: isSelected[0]
                ? Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )
                : Icon(
                    Icons.star_border,
                    color: Colors.grey,
                  ),
            onPressed: () => _onTap(0),
          ),
        ),
        Expanded(
          child: IconButton(
            icon: isSelected[1]
                ? Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )
                : Icon(
                    Icons.star_border,
                    color: Colors.grey,
                  ),
            onPressed: () => _onTap(1),
          ),
        ),
        Expanded(
          child: IconButton(
            icon: isSelected[2]
                ? Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )
                : Icon(
                    Icons.star_border,
                    color: Colors.grey,
                  ),
            onPressed: () => _onTap(2),
          ),
        ),
        Expanded(
          child: IconButton(
            icon: isSelected[3]
                ? Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )
                : Icon(
                    Icons.star_border,
                    color: Colors.grey,
                  ),
            onPressed: () => _onTap(3),
          ),
        ),
        Expanded(
          child: IconButton(
            icon: isSelected[4]
                ? Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )
                : Icon(
                    Icons.star_border,
                    color: Colors.grey,
                  ),
            onPressed: () => _onTap(4),
          ),
        ),
      ],
    );
  }
}
