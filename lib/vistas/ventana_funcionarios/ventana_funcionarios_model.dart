import '/vistas/components/fila_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VentanaFuncionariosModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // Model for Fila_AppBar component.
  late FilaAppBarModel filaAppBarModel;
  // State field(s) for TextField widget.
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    filaAppBarModel = createModel(context, () => FilaAppBarModel());
  }

  void dispose() {
    filaAppBarModel.dispose();
    textController?.dispose();
  }

  /// Additional helper methods are added here.

}
