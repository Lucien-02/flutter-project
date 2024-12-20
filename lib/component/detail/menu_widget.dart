import 'package:comics_app/component/detail/tab_content_widget.dart';
import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final int length;
  final List<Tab> tabs;
  final List<Widget> screens;

  MenuWidget({
    required this.tabs,
    required this.screens,
    required this.length,
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: tabs,
            indicatorColor: AppColors.orange,
            dividerColor: Colors.transparent,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              child:TabBarView(
              children: screens,
            ),
            )
          ),

      ),
        ],
      )
    );
  }
}
