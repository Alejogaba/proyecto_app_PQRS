import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:proyecto_p_q_r_s/vistas/ventan_p_q_r_s_anonimo/ventan_p_q_r_s_widget_anonimo.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:dotted_border/dotted_border.dart';

import '../../modelo/funcionario.dart';
import '../components/barra_superior.dart';
import '../ventan_p_q_r_s/ventan_p_q_r_s_widget.dart';
import '../ventana_dependencias/ventana_dependencias_widget.dart';
import '../ventana_funcionarios/ventana_funcionarios_widget.dart';
import '../ventana_soporte/ventana_soporte_widget.dart';

class RegistrarFuncionarioPageWidget extends StatefulWidget {
  final String? operacionaRealizar;
  final String? id;
  final Funcionario? funcionarioEditar;
  final int idArea;

  const RegistrarFuncionarioPageWidget(
      {Key? key,
      this.operacionaRealizar,
      this.id,
      this.funcionarioEditar,
      this.idArea = 0})
      : super(key: key);

  @override
  _RegistrarFuncionarioPageWidgetState createState() =>
      _RegistrarFuncionarioPageWidgetState(this.operacionaRealizar, this.id,
          this.funcionarioEditar, this.idArea);
}

class _RegistrarFuncionarioPageWidgetState
    extends State<RegistrarFuncionarioPageWidget>
    with SingleTickerProviderStateMixin {
  TextEditingController textControllerApellidos = TextEditingController();
  TextEditingController textControllerCedula = TextEditingController();
  TextEditingController textControllerNombres = TextEditingController();
  TextEditingController? textControllerCorreo = TextEditingController();
  TextEditingController? controladorimagenUrl = TextEditingController();
  TextEditingController textControllerTelefono_1 = TextEditingController();
  TextEditingController textControllerTelefono_2 = TextEditingController();
  TextEditingController textControllerEnlaceSIGEP = TextEditingController();
  TextEditingController textControllerCargo = TextEditingController();

  int? countControllerValue = 1;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  File? imageFile;
  bool blur = false;

  String? urlImagen;
  final ImagePicker picker = ImagePicker();
  late String result;
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _errorColor = false;
  bool _dropdownErrorColor = false;

  int? numInventario;
  int estadoActivoOpcion = 0;
  Funcionario? activo;
  final String? operacionaRealizar;
  final String? id;
  int idArea = 0;
  int anchominimo = 640;
  Uint8List? imageBytes;

  final Funcionario? funcionarioEditar;
  FocusNode _focusNodeCorreo = FocusNode();
  FocusNode _focusNodeCedula = FocusNode();
  FocusNode _focusNodeNombre = FocusNode();
  FocusNode _focusNodeApellidos = FocusNode();
  FocusNode _focusNodeTelefono_1 = FocusNode();
  FocusNode _focusNodeTelefono_2 = FocusNode();
  FocusNode _focusNodeEnlaceSIGEP = FocusNode();
  FocusNode _focusNodeCargo = FocusNode();
  Color color = Colors.red;
  List<TextInputFormatter> inputNumero = <TextInputFormatter>[
    // for below version 2 use this
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10),
  ];

  List<TextInputFormatter> inputFormater = <TextInputFormatter>[
    LengthLimitingTextInputFormatter(10),
  ];

  _RegistrarFuncionarioPageWidgetState(
      this.operacionaRealizar, this.id, this.funcionarioEditar, this.idArea);

  // ignore: prefer_final_fields5

  @override
  void initState() {
    super.initState();

    if (funcionarioEditar != null) {
      textControllerApellidos.text = funcionarioEditar!.apellidos.toString();
      textControllerCedula.text = funcionarioEditar!.cedula.toString();
      textControllerNombres.text = funcionarioEditar!.nombres.toString();
      textControllerCorreo!.text = funcionarioEditar!.correo.toString();
      textControllerTelefono_1.text = funcionarioEditar!.telefono1.toString();
      (funcionarioEditar!.telefono2 != null)
          ? textControllerTelefono_2.text =
              funcionarioEditar!.telefono2.toString()
          : textControllerTelefono_2.text = "";
      (funcionarioEditar!.enlaceSIGEP != null)
          ? textControllerEnlaceSIGEP.text =
              funcionarioEditar!.enlaceSIGEP.toString()
          : textControllerEnlaceSIGEP.text = "";
      textControllerCargo.text = funcionarioEditar!.cargo.toString();
    } else {
      id != null
          ? textControllerApellidos.text = id.toString()
          : textControllerApellidos.text = '';

      textControllerCedula.text = '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    textControllerApellidos.dispose();
    textControllerCedula.dispose();
    textControllerNombres.dispose();
    textControllerCorreo?.dispose();
    textControllerCargo.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic tamanioPadding = (MediaQuery.of(context).size.width < anchominimo)
        ? EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10)
        : EdgeInsetsDirectional.fromSTEB(80, 10, 80, 10);

    dynamic anchoColumnaWrap = (MediaQuery.of(context).size.width < anchominimo)
        ? MediaQuery.of(context).size.width * 0.9
        : MediaQuery.of(context).size.width * 0.4;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: _errorColor
            ? Colors.redAccent
            : FlutterFlowTheme.of(context).primaryColor,
        elevation: 8,
        child: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: FaIcon(
            _errorColor ? Icons.error : FontAwesomeIcons.solidFloppyDisk,
            color: FlutterFlowTheme.of(context).tertiary,
            size: 30,
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate() && idArea != 0) {
              setState(() {
                blur = true;
              });
              String? imagenUrl;
              log('serial: ${textControllerApellidos.text.toString()}');

              if (imageFile != null) {
              } else {
                String res = 'error';
                if (funcionarioEditar != null) {
                } else {}

                if (res == 'ok') {
                  Timer(Duration(seconds: 3), () {
                    setState(() {
                      blur = false;
                    });
                    Navigator.pop(context);
                  });
                }
              }
            } else if (idArea == 0) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Seleccione el área donde se encuentra el funcionario",
                  style: FlutterFlowTheme.of(context).bodyText2.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyText2Family,
                        color: FlutterFlowTheme.of(context).tertiary,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyText2Family),
                      ),
                ),
                backgroundColor: Colors.redAccent,
              ));
              setState(() {
                blur = false;
                _errorColor = true;
              });
              Future.delayed(const Duration(milliseconds: 6000), () {
                setState(() {
                  _errorColor = false;
                });
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "No deje campos obligatorios (*) vacios",
                  style: FlutterFlowTheme.of(context).bodyText2.override(
                        fontFamily:
                            FlutterFlowTheme.of(context).bodyText2Family,
                        color: FlutterFlowTheme.of(context).tertiary,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).bodyText2Family),
                      ),
                ),
                backgroundColor: Colors.redAccent,
              ));
              log('rojo');
              setState(() {
                blur = false;
                _errorColor = true;
              });
              Future.delayed(const Duration(milliseconds: 6000), () {
                setState(() {
                  _errorColor = false;
                });
              });
            }
          },
        ),
      ),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: BarraSuperior(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0),
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                          child: Container(
                            width: 155.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).accent3,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 5.0),
                                  child: Icon(
                                    Icons.home,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 20.0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Dashboard',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0),
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VentanPQRSWidget()));
                            },
                            child: Container(
                              width: 240.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).accent3,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 5.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.cubes,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 21.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'PQRS  Identificación',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0),
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VentanPQRSWidgetAnonimo()));
                            },
                            child: Container(
                              width: 185.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).accent3,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 5.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.cube,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 20.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'PQRS Anónimo',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 18.0,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0),
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VentanaFuncionariosWidget()));
                            },
                            child: Container(
                              width: 185.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 2.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.solidIdCard,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 22.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Funcionarios',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0),
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VentanaDependenciasWidget()));
                            },
                            child: Container(
                              width: 180.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).accent3,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 1.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.building,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 22.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Dependencias',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0),
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VentanaSoporteWidget()));
                            },
                            child: Container(
                              width: 130.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).accent3,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 1.0),
                                    child: Icon(
                                      Icons.support_agent,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 22.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Soporte',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 18.0,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: defTamanoAncho(MediaQuery.of(context).size.width),
                  child: Container(
                    alignment: Alignment.topCenter,
                    margin: (MediaQuery.of(context).size.width < anchominimo)
                        ? EdgeInsets.fromLTRB(0, 15, 0, 0)
                        : EdgeInsets.fromLTRB(10, 0, 10, 10),
                    height: (MediaQuery.of(context).size.width < anchominimo)
                        ? null
                        : 1000,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      //border corner radius
                      /*boxShadow: [
                        BoxShadow(
                          color: FlutterFlowTheme.of(context).boxShadow, //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],*/
                    ),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding:
                            (MediaQuery.of(context).size.width < anchominimo)
                                ? EdgeInsetsDirectional.all(10)
                                : EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 20, 0),
                                            child: Text(
                                              'Toca en la cámara para subir una imagen',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .title3,
                                            ),
                                          ),
                                          Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    anchominimo)
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 16, 10, 14),
                                                child: Center(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: imagenPerfil(context,
                                                        urlImagen, imageFile),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: anchoColumnaWrap,
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 50, 5, 0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .solidIdCard,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 28,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 30, 0, 0),
                                                    child: TextFormFieldCustom(
                                                        context,
                                                        textControllerCedula,
                                                        'Ej. 1065324298',
                                                        'Número de cédula*',
                                                        10,
                                                        TextInputType.number,
                                                        inputNumero,
                                                        true,
                                                        null,
                                                        _focusNodeCedula,
                                                        esSoloLectura:
                                                            (funcionarioEditar !=
                                                                    null)
                                                                ? true
                                                                : false),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: anchoColumnaWrap,
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.05, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 50, 5, 0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.solidUser,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 28,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 30, 0, 0),
                                                    child: TextFormFieldCustom(
                                                        context,
                                                        textControllerNombres,
                                                        'Ej. Luis Carlos',
                                                        'Nombres*',
                                                        30,
                                                        TextInputType.name,
                                                        null,
                                                        true,
                                                        null,
                                                        _focusNodeNombre),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: anchoColumnaWrap,
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.05, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 50, 5, 0),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.solidUser,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 28,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 30, 0, 0),
                                                    child: TextFormFieldCustom(
                                                        context,
                                                        textControllerApellidos,
                                                        'Ej. Calderon Gutierrez',
                                                        'Apellidos',
                                                        30,
                                                        TextInputType.name,
                                                        null,
                                                        false,
                                                        null,
                                                        _focusNodeApellidos),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        FutureBuilder<List<String>>(
                                          builder: (BuildContext context,
                                              AsyncSnapshot<dynamic> snapshot) {
                                            if (snapshot.connectionState ==
                                                    ConnectionState.done &&
                                                snapshot.hasData) {
                                              return Container(
                                                width: anchoColumnaWrap,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      child: Text(
                                                        'Área del funcionario',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1Family,
                                                                  fontSize: 20,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyText1Family),
                                                                ),
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 12,
                                                                    0, 0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0, 0),
                                                                  child: Text(
                                                                      'vacio')),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              (MediaQuery.of(context).size.width < anchominimo)
                                  ? Container()
                                  : Padding(
                                      padding: tamanioPadding,
                                      child: Divider(
                                        height: 2,
                                        thickness: 1,
                                        color: Color(0x94ABB3BA),
                                      ),
                                    ),
                              Column(
                                children: [
                                  Padding(
                                    padding: tamanioPadding,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 30, 15, 0),
                                          child: FaIcon(
                                            FontAwesomeIcons.suitcase,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 25,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormFieldCustom(
                                              context,
                                              textControllerCargo,
                                              '',
                                              'Cargo*',
                                              30,
                                              TextInputType.name,
                                              null,
                                              true,
                                              null,
                                              _focusNodeCargo),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: tamanioPadding,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 30, 15, 0),
                                          child: Icon(
                                            Icons.mail,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 28,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormFieldCustom(
                                              context,
                                              textControllerCorreo,
                                              'Ej. Sistemas@lajaguadeIbirico-Cesar.gov.co',
                                              'Correo eléctronico',
                                              100,
                                              TextInputType.emailAddress,
                                              null,
                                              false,
                                              null,
                                              _focusNodeCorreo),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: tamanioPadding,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 30, 15, 0),
                                          child: FaIcon(
                                            FontAwesomeIcons.phone,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 25,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormFieldCustom(
                                              context,
                                              textControllerTelefono_1,
                                              'Ej.3104562222',
                                              'Número de teléfono*',
                                              10,
                                              TextInputType.phone,
                                              inputNumero,
                                              true,
                                              null,
                                              _focusNodeTelefono_1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: tamanioPadding,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 30, 15, 0),
                                          child: FaIcon(
                                            FontAwesomeIcons.phone,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 25,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormFieldCustom(
                                              context,
                                              textControllerTelefono_2,
                                              '',
                                              'Número de teléfono alternativo',
                                              10,
                                              TextInputType.phone,
                                              inputNumero,
                                              false,
                                              null,
                                              _focusNodeTelefono_2),
                                        ),
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
                  ),
                ),
              ],
            ),
          ),
          if (blur)
            ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4,
                  sigmaY: 4,
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          color: FlutterFlowTheme.of(context).primaryColor,
                          strokeWidth: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget TextFormFieldCustom(
      context,
      controlador,
      String hint,
      String label,
      int maxCharacters,
      tipoTeclado,
      esNumero,
      bool _esObligatorio,
      sufix,
      _focusNode,
      {bool esSoloLectura = false}) {
    return TextFormField(
      readOnly: esSoloLectura,
      validator: (_esObligatorio)
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'No deje este campo vacio';
              }
              return null;
            }
          : null,
      cursorColor: FlutterFlowTheme.of(context).primaryText,
      controller: controlador,
      keyboardType: tipoTeclado,
      inputFormatters: (esNumero == null)
          ? <TextInputFormatter>[
              LengthLimitingTextInputFormatter(maxCharacters),
            ]
          : esNumero,
      obscureText: false,
      focusNode: _focusNode,
      decoration: InputDecoration(
        fillColor: FlutterFlowTheme.of(context).primaryBackground,
        labelText: label,
        labelStyle: FlutterFlowTheme.of(context).title3.override(
              fontFamily: FlutterFlowTheme.of(context).title3Family,
              fontSize: 22,
              color: _focusNodeCorreo.hasFocus
                  ? FlutterFlowTheme.of(context).primaryText
                  : FlutterFlowTheme.of(context).secondaryText,
              useGoogleFonts: GoogleFonts.asMap()
                  .containsKey(FlutterFlowTheme.of(context).title3Family),
            ),
        hintText: hint,
        hintStyle: FlutterFlowTheme.of(context).title3.override(
              fontFamily: FlutterFlowTheme.of(context).title3Family,
              color: FlutterFlowTheme.of(context).secondaryText,
              fontSize: 22,
              useGoogleFonts: GoogleFonts.asMap()
                  .containsKey(FlutterFlowTheme.of(context).title3Family),
            ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x94ABB3BA),
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).primaryText,
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).primaryText,
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
        suffixIcon: sufix,
      ),
      style: FlutterFlowTheme.of(context).title3.override(
            fontFamily: FlutterFlowTheme.of(context).title3Family,
            fontSize: 22,
            color: FlutterFlowTheme.of(context).primaryText,
            useGoogleFonts: GoogleFonts.asMap()
                .containsKey(FlutterFlowTheme.of(context).title3Family),
          ),
    );
  }

  Future<String> registrarFuncionario(BuildContext context, String? imagenUrl,
      {bool editar = false}) async {
    Future pickImageFromGallery() async {
      print("starting get image");
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      //final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      print("getting image.....");
      setState(() {
        if (pickedFile != null) {
          print("file not null");
          imageFile = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }

    Future captureImageFromCamera() async {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        if (pickedFile != null) {
          imageFile = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }

    Future<void> _showChoiceDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Seleccione"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Galeria"),
                      onTap: () {
                        pickImageFromGallery();
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    GestureDetector(
                      child: Text("Camara"),
                      onTap: () {
                        captureImageFromCamera();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            );
          });
    }

    Future<void> pickFile() async {
      FilePickerResult? pickedFile =
          await FilePicker.platform.pickFiles(type: FileType.image);
      setState(() {
        if (pickedFile != null) {
          File imagefile = File(pickedFile.files.single.path!);
          log('ruta archivo: ${imagefile.path}');
        } else {
          // User canceled the picker
        }
      });
    }

    Future pickImageDesktop() async {
      print("starting get image");
      final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        dialogTitle: 'Seleccionar imagen',
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'gif', 'gif', 'bmp', 'webp'],
      );
      //final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      print("getting image Desktop.....");
      setState(() {
        if (pickedFile != null) {
          print("file not null");
          imageFile = File(pickedFile.files.single.path!);
          //inputImage = InputImage.fromFilePath(pickedFile.files.single.path!);
          //imageToText(inputImage);
        } else {
          print('No image selected.');
        }
      });
    }

    Widget _decideImageView(imageFile) {
      if (funcionarioEditar != null && imageFile == null) {
        return Image.network(
          funcionarioEditar!.urlImagen,
          width: 250,
          height: 200,
          fit: BoxFit.cover,
        );
      } else if (imageFile == null) {
        return const Center(
          child: Icon(
            FontAwesomeIcons.camera,
            size: 40,
          ),
        );
      } else {
        return Image.file(
          imageFile,
          width: 250,
          height: 200,
          fit: BoxFit.cover,
        );
      }
    }

    Widget imagenPerfil(BuildContext context, urlImagen, imageFile) {
      return GestureDetector(
        onTap: () async {
          if (Platform.isAndroid || Platform.isIOS) {
            await _showChoiceDialog(context);
            setState(() {
              controladorimagenUrl = null;
            });
          } else {
            print('Escoger imagen');
            await pickImageDesktop();
            setState(() {
              controladorimagenUrl = null;
            });
          }
        },
        child: (imageFile == null || imageFile.toString().isEmpty)
            ? DottedBorder(
                color: FlutterFlowTheme.of(context).secondaryText,
                strokeWidth: 2,
                dashPattern: [10, 10],
                child: Container(
                    width: 250,
                    height: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: urlImagen != null && imageFile == null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(urlImagen))
                            : null),
                    child: _decideImageView(imageFile)))
            : Container(
                width: 250,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).primaryText,
                      width: 2,
                    ),
                    shape: BoxShape.rectangle,
                    image: urlImagen != null && imageFile == null
                        ? DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(urlImagen))
                        : null),
                child: _decideImageView(imageFile)),
      );
    }

    Future<void> cargarFuncionarioDropdown(int idArea) async {
      log('idAre: $idArea');

      log('Cargando area...');
    }

    return '';
  }

  Widget imagenPerfil(BuildContext context, urlImagen, imageFile) {
    return GestureDetector(
      onTap: () async {
        print('Escoger imagen');
        await pickImageDesktop();
        setState(() {
          controladorimagenUrl = null;
        });
      },
      child: (imageFile == null || imageFile.toString().isEmpty)
          ? DottedBorder(
              color: FlutterFlowTheme.of(context).secondaryText,
              strokeWidth: 2,
              dashPattern: [10, 10],
              child: Container(
                  width: 250,
                  height: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: urlImagen != null && imageFile == null
                          ? DecorationImage(
                              fit: BoxFit.cover, image: NetworkImage(urlImagen))
                          : null),
                  child: _decideImageView(imageFile)))
          : Container(
              width: 250,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).primaryText,
                    width: 2,
                  ),
                  shape: BoxShape.rectangle,
                  image: urlImagen != null && imageFile == null
                      ? DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(urlImagen))
                      : null),
              child: _decideImageView(imageFile)),
    );
  }

  Future pickImageFromGallery() async {
    print("starting get image");
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    //final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print("getting image.....");
    setState(() {
      if (pickedFile != null) {
        print("file not null");
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future captureImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Seleccione"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Galeria"),
                    onTap: () {
                      pickImageFromGallery();
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Camara"),
                    onTap: () {
                      captureImageFromCamera();
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> pickFile() async {
    FilePickerResult? pickedFile =
        await FilePicker.platform.pickFiles(type: FileType.image);
    setState(() {
      if (pickedFile != null) {
        File imagefile = File(pickedFile.files.single.path!);
        log('ruta archivo: ${imagefile.path}');
      } else {
        // User canceled the picker
      }
    });
  }

  Future pickImageDesktop() async {
    print("starting get image");
    final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      dialogTitle: 'Seleccionar imagen',
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpge', 'gif', 'bmp', 'webp'],
    );
    //final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print("getting image Desktop.....");
    setState(() {
      if (pickedFile != null) {
        print("file not null");
        Uint8List? bytes = pickedFile.files.first.bytes;
        if (bytes != null) {
          setState(() {
            imageBytes = bytes;
          });
        }
        //inputImage = InputImage.fromFilePath(pickedFile.files.single.path!);
        //imageToText(inputImage);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _decideImageView(imageFile) {
    if (funcionarioEditar != null && imageBytes == null) {
      return Image.network(
        funcionarioEditar!.urlImagen,
        width: 250,
        height: 200,
        fit: BoxFit.cover,
      );
    } else if (imageBytes == null) {
      return const Center(
        child: Icon(
          FontAwesomeIcons.camera,
          size: 40,
        ),
      );
    } else {
      return Image.memory(
        imageBytes!,
        width: 250,
        height: 200,
        fit: BoxFit.cover,
      );
    }
  }

  EdgeInsetsGeometry defTamanoAncho(screenSize) {
    if (screenSize < 640) {
      return EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0);
    } else {
      return EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0);
    }
  }
}
