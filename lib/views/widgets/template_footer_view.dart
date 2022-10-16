import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../entities/User.dart';

class TemplateFooter extends StatelessWidget {
  const TemplateFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData?>(context);

    return Material(
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: ListTile(
              title: Text(user!.displayName ?? 'No name'),
              isThreeLine: true,
              subtitle: const Text(
                'phone number' " \n" 'website' + "\n" + ('Email'),
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(100.0),
            ),
            child: Image.network(
              user.photoUrl ?? '',
              fit: BoxFit.contain,
              width: 80,
              errorBuilder: (context, exception, stackTrack) => SizedBox(
                height: 100,
                width: 150,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        size: 45,
                        color: Theme.of(context).primaryColor,
                      ),
                      const Text(
                        "Image cannot be loaded!",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  width: 150,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                      width: 150,
                      height: 100,
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
