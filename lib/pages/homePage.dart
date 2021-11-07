import 'package:dpkmobileflutter/fragment/acceptanceFrag.dart';
import 'package:dpkmobileflutter/fragment/checkerFrag.dart';
import 'package:dpkmobileflutter/fragment/dashboardFrag.dart';
import 'package:flutter/material.dart';

// final Color backgroundColor = Colors.white;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;
  int _selectedDrawerIndex = 0;
  String _title = "Dashboard";
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        _title = "Dashboard";
        return new DashboardFrag();
      case 1:
        _title = "Acceptance";
        return new AcceptanceFrag();
      case 2:
        _title = "Checker";
        return new CheckerFrag();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() {
      if (isCollapsed)
        _controller.forward();
      else
        _controller.reverse();

      isCollapsed = !isCollapsed;
      _selectedDrawerIndex = index;
    });

  }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          // ignore: unnecessary_const
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6594BB),
              Color(0xFF5A85A8),
              Color(0xFF506C95),
              Color(0xFF465682),
              Color(0xFF3C5170),
              Color(0xFF32395D),
              Color(0xFF28314A),
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            menu(context),
            dashboard(context),
          ],
        ),
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: ()=> _onSelectItem(0),
                  child: Text("Dashboard", style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: ()=> _onSelectItem(1),
                  child: Text("Acceptance", style: TextStyle(color: Colors.white, fontSize: 22)),
                ),

                SizedBox(height: 10),
                InkWell(
                  onTap: ()=> _onSelectItem(2),
                  child: Text("Checker", style: TextStyle(color: Colors.white, fontSize: 22)),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: !isCollapsed ? BorderRadius.all(Radius.circular(40)): BorderRadius.all(Radius.circular(0)),
          elevation: 8,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // decoration: const BoxDecoration(
            //   // ignore: unnecessary_const
            //   gradient: const LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [
            //       Color(0xFF6594BB),
            //       Color(0xFF5A85A8),
            //       Color(0xFF506C95),
            //       Color(0xFF465682),
            //       Color(0xFF3C5170),
            //       Color(0xFF32395D),
            //       Color(0xFF28314A),
            //     ],
            //   ),
            // ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Container(
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(right: 16, left: 16),
                      height: 56,
                      decoration: const BoxDecoration(
                        // ignore: unnecessary_const
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF6594BB),
                            Color(0xFF5A85A8),
                            Color(0xFF506C95),
                            Color(0xFF465682),
                            Color(0xFF3C5170),
                            Color(0xFF32395D),
                            Color(0xFF28314A),
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            child: Icon(Icons.menu, color: Colors.white),
                            onTap: () {
                              setState(() {
                                if (isCollapsed)
                                  _controller.forward();
                                else
                                  _controller.reverse();

                                isCollapsed = !isCollapsed;
                              });
                            },
                          ),
                          Text(_title, style: TextStyle(fontSize: 24, color: Colors.white)),
                          Icon(Icons.settings, color: Colors.white),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      child: _getDrawerItemWidget(_selectedDrawerIndex),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}