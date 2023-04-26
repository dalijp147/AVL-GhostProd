import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghost_prod/screens/splash.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  static final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 25, right: 16),
      child: ListView(
        children: [
          Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: [
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Souid Houssem",
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "souidhoussem@gmail.com",
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.person, color: Colors.black),
              SizedBox(
                width: 15,
              ),
              Text(
                "General",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(height: 15, thickness: 2),
          SizedBox(
            height: 10,
          ),
          buildAccountOptionRow(context, "Edit Profile", "Edit Profile"),
          buildNotificationOptionRow('Notification ', false),
          buildAccountOptionRow(context, "Wishlist", "Wishlist"),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Icon(Icons.volume_down_outlined, color: Colors.black),
              SizedBox(
                width: 15,
              ),
              Text(
                "Legal",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 45,
              ),
            ],
          ),
          Divider(height: 15, thickness: 2),
          SizedBox(
            height: 10,
          ),
          buildAccountOptionRow(context, "Terms of Use", "Terms of Use"),
          buildAccountOptionRow(context, "Privacy Policy", "Privacy Policy"),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Icon(Icons.volume_down_outlined, color: Colors.black),
              SizedBox(
                width: 15,
              ),
              Text(
                "Personal",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 45,
              ),
            ],
          ),
          Divider(height: 15, thickness: 2),
          SizedBox(
            height: 10,
          ),
          buildAccountOptionRow(context, "Rport a Bug", "Rport a Bug"),
          buildAccountOptionRow(context, "Logout", "Logout"),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

Row buildNotificationOptionRow(String title, bool isActive) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600],
        ),
      ),
      SizedBox(
        height: 45,
      ),
      Transform.scale(
        scale: 0.7,
        child: CupertinoSwitch(
          value: isActive,
          onChanged: (bool val) {},
        ),
      )
    ],
  );
}

GestureDetector buildAccountOptionRow(
    BuildContext context, String title, String value) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => splash()));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          )
        ],
      ),
    ),
  );
}
