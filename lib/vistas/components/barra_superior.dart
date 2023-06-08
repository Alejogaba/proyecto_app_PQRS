import 'package:flutter/material.dart';
import 'package:proyecto_p_q_r_s/vistas/home_page/home_page_widget.dart';

import '../../controlador/auth_helper.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class BarraSuperior extends StatelessWidget {
  const BarraSuperior({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      automaticallyImplyLeading: false,
      title: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/1663692934.png',
                width: 120.0,
                height: 40.0,
                fit: BoxFit.fill,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      
                      /*AuthHelper.handleSignOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HomePageWidget()));*/
                    },
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        'https://picsum.photos/seed/967/600',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      
                      AuthHelper.handleSignOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HomePageWidget()));
                    },
                    child: Container(
                      width: 45.0,
                      height: 45.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.logout_outlined),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [],
      centerTitle: true,
      elevation: 3.0,
    );
  }
}