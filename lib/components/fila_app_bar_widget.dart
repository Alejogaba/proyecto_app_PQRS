import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'fila_app_bar_model.dart';
export 'fila_app_bar_model.dart';

class FilaAppBarWidget extends StatefulWidget {
  const FilaAppBarWidget({Key? key}) : super(key: key);

  @override
  _FilaAppBarWidgetState createState() => _FilaAppBarWidgetState();
}

class _FilaAppBarWidgetState extends State<FilaAppBarWidget> {
  late FilaAppBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilaAppBarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/images/1663692934.png',
          width: 150.0,
          height: 50.0,
          fit: BoxFit.fill,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                'https://picsum.photos/seed/967/600',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
