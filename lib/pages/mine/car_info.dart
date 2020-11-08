import 'package:driver/shared_state/user_info.dart';
import 'package:driver/widgets/to_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarInfoPage extends StatelessWidget {
  static const String routeName = 'car-ibfo-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars'),
        centerTitle: true,
      ),
      body: Consumer<UserInfoProvider>(
        builder: (_, infoProvider, __) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TOCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(right: 16),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        ),
                      ),
                      child: Image.network(
                        infoProvider.userInfo.card1,
                        fit: BoxFit.contain,
                      ),
                    ),
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.caption,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(height: 16),
                          Text(infoProvider.userInfo.carMake),
                          SizedBox(height: 8),
                          Text('${infoProvider.userInfo.carNum} seats'),
                          SizedBox(height: 8),
                          Text(infoProvider.userInfo.carNo),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
