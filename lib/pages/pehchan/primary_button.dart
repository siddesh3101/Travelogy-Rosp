import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool hasImage;
  final String? imagePath;

  const PrimaryButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.hasImage = false,
      this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.purple,
          fixedSize: Size(
            MediaQuery.of(context).size.width,
            50,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasImage) ...[
              Image(
                image: AssetImage(imagePath!),
                height: 20,
                width: 20,
              ),
              SizedBox(
                width: 5,
              ),
            ],
            Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ));
  }
}
