import 'package:clientmanagerapp/Abono/bloc/abono_bloc.dart';
import 'package:clientmanagerapp/Client/bloc/client_bloc.dart';
import 'package:clientmanagerapp/Client/ui/screens/client_list_screen.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter/material.dart';

class ClientManagerMainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ClientManagerMainScreen();
  }

}

class _ClientManagerMainScreen extends State<ClientManagerMainScreen> {
  int indexTap = 0;
  final List<Widget> widgetsChildren = [
    BlocProvider(
      bloc: AbonoBloc(),
      child: BlocProvider(
        bloc: ClientBloc(),
        child: ClientListScreen(),
      ),

    ),

    //ClientListScreen(),
    Container(),
    Container(),
  ];

  void onTapTapped(int index){

    setState(() {
      indexTap = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(
      body: widgetsChildren[indexTap],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xff202225),
          primaryColor: Color(0xff43b581),
        ),
        child: BottomNavigationBar(
          onTap: onTapTapped,
          currentIndex: indexTap,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.people,
                  //color: Color(0xff36393f)
                ),
                title: Text("")
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.notifications,
                      //color: Color(0xff36393f),
                  ),
                  title: Text("")
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                      //color: Color(0xff36393f)
                  ),
                  title: Text("")
              ),
            ]
        ),
      ),
    );
  }

}