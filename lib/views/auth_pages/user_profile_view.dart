import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greetings_app/views/utilities/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../entities/ProfileImage.dart';
import '../../entities/User.dart';
import 'profile_list_items.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData?>(context)!;
    // final Stream<DocumentSnapshot> _userStream = FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(user.email)
    //     .snapshots(includeMetadataChanges: true);

    final String? profileImage =
        Provider.of<ProfileImage?>(context)?.getProfileImage;

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 3),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    AppBarButton(
                      icon: Icons.arrow_back,
                    ),
                    // SvgPicture.asset("assets/icons/menu.svg"),
                  ],
                ),
              ),
              (profileImage != null)
                  ? AvatarImage(
                      image: profileImage,
                      isNetworkImage: true,
                    )
                  : AvatarImage(
                      image: user.photoUrl ?? defaultProfileImageURL,
                      isNetworkImage: user.photoUrl != null ? true : false,
                    ),
              // AvatarImage(
              //   image: user.photoUrl ?? defaultProfileImageURL,
              //   isNetworkImage: user.photoUrl != null ? true : false,
              // ),
              const SizedBox(
                height: 30,
              ),
              const SocialIcons(),
              const SizedBox(height: 30),
              Text(
                user.displayName ?? "",
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins"),
              ),
              Text(
                user.email ?? "",
                style: const TextStyle(fontWeight: FontWeight.w300),
              ),
              const ProfileListItems(),
            ],
          )
        ],
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  final IconData? icon;

  const AppBarButton({Key? key, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kAppPrimaryColor,
          boxShadow: [
            BoxShadow(
              color: kLightBlack,
              offset: const Offset(1, 1),
              blurRadius: 10,
            ),
            BoxShadow(
              color: kWhite,
              offset: const Offset(-1, -1),
              blurRadius: 10,
            ),
          ]),
      child: Icon(
        icon,
        color: fCL,
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  final String image;
  final bool isNetworkImage;
  const AvatarImage(
      {Key? key, required this.image, required this.isNetworkImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: const EdgeInsets.all(8),
      decoration: avatarDecoration,
      child: isNetworkImage
          ? Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}

class SocialIcons extends StatelessWidget {
  const SocialIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialIcon(
          color: const Color(0xFF102397),
          iconData: facebook,
          onPressed: () {},
        ),
        SocialIcon(
          color: const Color(0xFFff4f38),
          iconData: googlePlus,
          onPressed: () {},
        ),
        SocialIcon(
          color: const Color(0xFF38A1F3),
          iconData: twitter,
          onPressed: () {},
        ),
        SocialIcon(
          color: const Color(0xFF2867B2),
          iconData: linkedin,
          onPressed: () {},
        )
      ],
    );
  }
}

class SocialIcon extends StatelessWidget {
  final Color? color;
  final IconData? iconData;
  final void Function()? onPressed;

  const SocialIcon({Key? key, this.color, this.iconData, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
        width: 45.0,
        height: 45.0,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          onPressed: onPressed,
          child: Icon(iconData, color: Colors.white),
        ),
      ),
    );
  }
}
