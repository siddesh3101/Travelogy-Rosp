import 'package:flutter/material.dart';

class SelectStyle extends StatelessWidget {
  const SelectStyle(
      {super.key, required this.stylesList, required this.onStyleSelected});
  final List<dynamic> stylesList;
  final Function(dynamic style) onStyleSelected;

  @override
  Widget build(BuildContext context) {
    final imageSize = 95.0;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose Style',
                  style: TextStyle(
                    fontSize: 14,
                    // color: context.appTheme.textColor,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 14,
                    // color: context.appTheme.textColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    onStyleSelected(stylesList[index]);
                  },
                  child: Container(
                    width: imageSize,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/style1.png',
                            width: imageSize,
                            height: imageSize,
                          ),
                        ),
                        Text(
                          'Vintage',
                          style: TextStyle(
                              // fontSize: 14.sp,
                              // color: context.appTheme.textColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
