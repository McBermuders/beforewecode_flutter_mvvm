//unsorted
//interfaces/abstract classes
//flutter
import 'package:flutter/material.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/project_navigator.dart';

class HeaderWithOptionalImageTile extends StatelessWidget {
  final ProjectNavigator navigator;
  final String imageURL;

  const HeaderWithOptionalImageTile(
      {required this.navigator, required this.imageURL, required Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget title;
    Widget? subtitle;
    if (imageURL.isEmpty == false) {
      double screenHeight = MediaQuery.of(context).size.height;
      title = Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: screenHeight - screenHeight / 2,
        child: Image.network(
          imageURL,
          loadingBuilder: (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress != null){
              double percentage = loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes! *
                  100
                  : 0.0;
              return Center(
                child: Stack(
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 72, 0, 0),
                      child: Center(child: Text("${percentage.toInt()}")),
                    ),
                  ],
                ),
              );
            } else{
              return child;
            }
          },
        ),
      );
      subtitle = const Center(
        child: Text("Tap Image to open rootview"),
      );
    } else {
      title = Container(
        height: 200,
        color: Colors.grey,
        child: const Center(
          child: Text("Tap to open detailview"),
        ),
      );
    }
    return ListTile(
      onTap: () {
        navigator.move(0, context);
      },
      title: title,
      subtitle: subtitle,
    );
  }
}
