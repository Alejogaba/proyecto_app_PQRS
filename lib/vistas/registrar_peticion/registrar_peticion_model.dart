import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';

class RegistrarPeticionModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueEsAnonima;
  // State field(s) for TextField widget.
  TextEditingController? textControllerPrimerNombre;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  TextEditingController? textControllerSegundoNombre;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  TextEditingController? textControllerPrimerApellido;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  TextEditingController? textControllerSegundoApellido;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for DropDown widget.
  String? dropDownTipoIdentificacion;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for TextField widget.
  TextEditingController? textControllerNumeroIdentificacion;
  String? Function(BuildContext, String?)? textController5Validator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for TextField widget.
  TextEditingController? textController6;
  String? Function(BuildContext, String?)? textController6Validator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue2;
  // State field(s) for TextField widget.
  TextEditingController? textController7;
  String? Function(BuildContext, String?)? textController7Validator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue3;
  bool? checkboxValue4;
  // State field(s) for TextField widget.
  TextEditingController? textController8;
  String? Function(BuildContext, String?)? textController8Validator;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for TextField widget.
  TextEditingController? textController9;
  String? Function(BuildContext, String?)? textController9Validator;
  // State field(s) for TextField widget.
  TextEditingController? textControllerDescripcionPqrs;
  String? Function(BuildContext, String?)? textController10Validator =
      (p0, p1) {
    if (p1 == null || p1.isEmpty) {
      return 'No deje este campo vacío.';
    }
    return null;
  };

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    textControllerPrimerNombre?.dispose();
    textControllerSegundoNombre?.dispose();
    textControllerPrimerApellido?.dispose();
    textControllerSegundoApellido?.dispose();
    textControllerNumeroIdentificacion?.dispose();
    textController6?.dispose();
    textController7?.dispose();
    textController8?.dispose();
    textController9?.dispose();
  }

  /// Additional helper methods are added here.

  String? get radioButtonValue => radioButtonValueEsAnonima?.value;
}
