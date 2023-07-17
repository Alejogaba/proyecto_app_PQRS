import 'dart:developer';
import 'dart:html';

import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:proyecto_p_q_r_s/vistas/registrar_peticion/hookContainer.dart';
import 'package:proyecto_p_q_r_s/modelo/pqrs.dart';
import 'package:proyecto_p_q_r_s/vistas/registrar_peticion/alert_pqrs.dart';

import '../../controlador/controlador_dependencia.dart';
import '../../flutter_flow/custom_snackbars.dart';
import '../../flutter_flow/flutter_flow_dropdown2.dart';
import '../../modelo/counter.dart';
import '../../modelo/dependencia.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'registrar_peticion_model.dart';
export 'registrar_peticion_model.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'dart:js' as js;

class RegistrarPeticionWidget extends StatefulWidget {
  final String? tipoPQRS;
  const RegistrarPeticionWidget({Key? key, this.tipoPQRS}) : super(key: key);

  @override
  _RegistrarPeticionWidgetState createState() =>
      _RegistrarPeticionWidgetState(this.tipoPQRS);
}

class _RegistrarPeticionWidgetState extends State<RegistrarPeticionWidget> {
  late RegistrarPeticionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String _respuestaRecaptcha = "Sin respuesta";
  bool _esAnonimo = false;
  String _token = "null";
  bool _opcionenvioDireccion = false;
  bool _opcionenvioEmail = false;
  bool _opcionenvioVentanilla = false;
  bool _opcionenvioWhatsapp = false;
  int posicionArea = 0;
  Dependencia? areaController;
  String? nombreTipoPQR = 'Petición';
  String nombreArchivo = '';
  List<Dependencia?> listaTemporalDependencia = [];

  TextEditingController controladorAsunto = TextEditingController();

  _RegistrarPeticionWidgetState(this.nombreTipoPQR);

  @override
  void initState() {
    super.initState();
    GRecaptchaV3.showBadge();
    _model = createModel(context, () => RegistrarPeticionModel());

    _model.textControllerPrimerNombre ??= TextEditingController();
    _model.textControllerSegundoNombre ??= TextEditingController();
    _model.textControllerPrimerApellido ??= TextEditingController();
    _model.textControllerSegundoApellido ??= TextEditingController();
    _model.textControllerNumeroIdentificacion ??= TextEditingController();
    _model.textController6 ??= TextEditingController();
    _model.textController7 ??= TextEditingController();
    _model.textController8 ??= TextEditingController();
    _model.textController9 ??= TextEditingController();
    _model.textControllerDescripcionPqrs ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DropzoneViewController? controllerDropzone;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Envia un $nombreTipoPQR',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Poppins',
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          leading: IconButton(
              onPressed: () {
                GRecaptchaV3.hideBadge();
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                color: FlutterFlowTheme.of(context).primaryText,
              )),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 0.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x44111417),
                                    offset: Offset(0.0, 2.0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 4.0, 4.0, 4.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 4.0, 8.0, 4.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 2.0, 0.0, 5.0),
                                            child: FaIcon(
                                              FontAwesomeIcons.listUl,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 30.0,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Tipo de $nombreTipoPQR',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Selecciona de que manera desea registrar la solicitud::',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 10.0, 10.0, 10.0),
                                              child: FlutterFlowRadioButton(
                                                options: [
                                                  'A nombre personal',
                                                  'Anónima'
                                                ].toList(),
                                                onChanged: (val) =>
                                                    setState(() {
                                                  if (_esAnonimo) {
                                                    _esAnonimo = false;
                                                  } else {
                                                    _esAnonimo = true;
                                                  }
                                                  print('tipo solicitud: $val');
                                                }),
                                                controller: _model
                                                        .radioButtonValueEsAnonima ??=
                                                    FormFieldController<String>(
                                                        'A nombre personal'),
                                                optionHeight: 40.0,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                selectedTextStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontSize: 15.0,
                                                        ),
                                                buttonPosition:
                                                    RadioButtonPosition.left,
                                                direction: Axis.horizontal,
                                                radioButtonColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                inactiveRadioButtonColor:
                                                    Color(0x8A000000),
                                                toggleable: false,
                                                horizontalAlignment:
                                                    WrapAlignment.start,
                                                verticalAlignment:
                                                    WrapCrossAlignment.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 12.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'A continuación completa tus datos para dar respuesta a tu solicitud',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                ),
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
                          if (!_esAnonimo)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 12.0, 16.0, 0.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 1.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5.0,
                                      color: Color(0x44111417),
                                      offset: Offset(0.0, 2.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4.0, 4.0, 4.0, 4.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 4.0, 8.0, 4.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 2.0, 0.0, 5.0),
                                              child: Icon(
                                                Icons.person,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 30.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Datos Peticionario',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 22.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Los campos con asterisco (*) son obligatorios',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 8.0, 8.0, 8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.47,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .textControllerPrimerNombre,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Primer nombre*',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                                    validator: (value) {
                                                      if (value!.isEmpty &&
                                                          !_esAnonimo) {
                                                        return 'No deje este campo vacío.';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 8.0, 8.0, 8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.47,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .textControllerSegundoNombre,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Segundo nombre',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 8.0, 8.0, 8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.47,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .textControllerPrimerApellido,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Primer apellido*',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                                    validator: (value) {
                                                      if (value!.isEmpty &&
                                                          !_esAnonimo) {
                                                        return 'No deje este campo vacío.';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 8.0, 8.0, 8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.47,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .textControllerSegundoApellido,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Segundo apellido',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                                    validator: _model
                                                        .textController4Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 10.0, 10.0, 10.0),
                                                child:
                                                    FlutterFlowDropDown<String>(
                                                  controller: _model
                                                          .dropDownValueController1 ??=
                                                      FormFieldController<
                                                          String>(null),
                                                  options: [
                                                    'Tarjeta de indetidad',
                                                    'Cédula'
                                                  ],
                                                  onChanged: (val) => setState(
                                                      () => _model
                                                              .dropDownTipoIdentificacion =
                                                          val),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.47,
                                                  height: 50.0,
                                                  searchHintTextStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                          ),
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                  hintText:
                                                      'Tipo de identificación*',
                                                  searchHintText: 'Buscar...',
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  elevation: 2.0,
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  borderWidth: 0.0,
                                                  borderRadius: 15.0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 4.0, 12.0, 4.0),
                                                  hidesUnderline: true,
                                                  isSearchable: false,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        11.0, 8.0, 8.0, 8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.47,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .textControllerNumeroIdentificacion,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Número de identificación*',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                                    validator: (value) {
                                                      if (value!.isEmpty &&
                                                          !_esAnonimo) {
                                                        return 'No deje este campo vacío.';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 0.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x44111417),
                                    offset: Offset(0.0, 2.0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 4.0, 4.0, 4.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 4.0, 8.0, 4.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 2.0, 0.0, 5.0),
                                            child: FaIcon(
                                              FontAwesomeIcons.mailBulk,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 30.0,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Datos de contacto',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Indique y diligencie el medio de envio para la respuesta (Solo una opción):',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Theme(
                                              data: ThemeData(
                                                checkboxTheme:
                                                    CheckboxThemeData(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0),
                                                  ),
                                                ),
                                                unselectedWidgetColor:
                                                    FlutterFlowTheme.of(context)
                                                        .accent2,
                                              ),
                                              child: Checkbox(
                                                value: _model.checkboxValue1 ??=
                                                    false,
                                                onChanged: (_opcionenvioEmail ||
                                                        _opcionenvioVentanilla ||
                                                        _opcionenvioWhatsapp)
                                                    ? null
                                                    : (newValue) async {
                                                        setState(() {
                                                          _model.checkboxValue1 =
                                                              newValue!;
                                                          if (_opcionenvioDireccion) {
                                                            _opcionenvioDireccion =
                                                                false;
                                                          } else {
                                                            _opcionenvioDireccion =
                                                                true;
                                                          }
                                                        });
                                                      },
                                                activeColor: (_opcionenvioEmail ||
                                                        _opcionenvioVentanilla ||
                                                        _opcionenvioWhatsapp)
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (!(_opcionenvioEmail ||
                                                    _opcionenvioVentanilla ||
                                                    _opcionenvioWhatsapp)) {
                                                  setState(() {
                                                    if (_model.checkboxValue1 !=
                                                            null &&
                                                        _model.checkboxValue1 ==
                                                            true) {
                                                      _model.checkboxValue1 =
                                                          false;
                                                    } else {
                                                      if (_model
                                                              .checkboxValue1 !=
                                                          null) {
                                                        _model.checkboxValue1 =
                                                            true;
                                                      }
                                                    }
                                                    if (_opcionenvioDireccion) {
                                                      _opcionenvioDireccion =
                                                          false;
                                                    } else {
                                                      _opcionenvioDireccion =
                                                          true;
                                                    }
                                                  });
                                                }
                                              },
                                              child: Text(
                                                'Dirección de correspondencia',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: (_opcionenvioEmail ||
                                                                _opcionenvioVentanilla ||
                                                                _opcionenvioWhatsapp)
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 8.0, 8.0, 8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.47,
                                                  child: TextFormField(
                                                    controller:
                                                        _model.textController6,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    enabled: (_opcionenvioEmail ||
                                                            _opcionenvioVentanilla ||
                                                            _opcionenvioWhatsapp)
                                                        ? false
                                                        : true,
                                                    decoration: InputDecoration(
                                                      hintText: (_opcionenvioEmail ||
                                                              _opcionenvioVentanilla ||
                                                              _opcionenvioWhatsapp)
                                                          ? ''
                                                          : 'Ingrese aqui su Dirección..',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                                    validator: (value) {
                                                      if (value!.isEmpty &&
                                                          _opcionenvioDireccion) {
                                                        return 'No deje este campo vacío.';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Theme(
                                              data: ThemeData(
                                                checkboxTheme:
                                                    CheckboxThemeData(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0),
                                                  ),
                                                ),
                                                unselectedWidgetColor:
                                                    FlutterFlowTheme.of(context)
                                                        .accent2,
                                              ),
                                              child: Checkbox(
                                                value: _model.checkboxValue2 ??=
                                                    false,
                                                onChanged: (_opcionenvioDireccion ||
                                                        _opcionenvioVentanilla ||
                                                        _opcionenvioWhatsapp)
                                                    ? null
                                                    : (newValue) async {
                                                        setState(() {
                                                          _model.checkboxValue2 =
                                                              newValue!;
                                                          if (_opcionenvioEmail) {
                                                            _opcionenvioEmail =
                                                                false;
                                                          } else {
                                                            _opcionenvioEmail =
                                                                true;
                                                          }
                                                        });
                                                      },
                                                activeColor:
                                                    (_opcionenvioDireccion ||
                                                            _opcionenvioVentanilla ||
                                                            _opcionenvioWhatsapp)
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (!(_opcionenvioDireccion ||
                                                    _opcionenvioVentanilla ||
                                                    _opcionenvioWhatsapp)) {
                                                  setState(() {
                                                    if (_model.checkboxValue2 !=
                                                            null &&
                                                        _model.checkboxValue2 ==
                                                            true) {
                                                      _model.checkboxValue2 =
                                                          false;
                                                    } else {
                                                      if (_model
                                                              .checkboxValue2 !=
                                                          null) {
                                                        _model.checkboxValue2 =
                                                            true;
                                                      }
                                                    }
                                                    if (_opcionenvioEmail) {
                                                      _opcionenvioEmail = false;
                                                    } else {
                                                      _opcionenvioEmail = true;
                                                    }
                                                  });
                                                }
                                              },
                                              child: Text(
                                                'Correo electrónico',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: (_opcionenvioDireccion ||
                                                                _opcionenvioVentanilla ||
                                                                _opcionenvioWhatsapp)
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 8.0, 8.0, 8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.47,
                                                  child: TextFormField(
                                                    controller:
                                                        _model.textController7,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    enabled: (_opcionenvioDireccion ||
                                                            _opcionenvioVentanilla ||
                                                            _opcionenvioWhatsapp)
                                                        ? false
                                                        : true,
                                                    decoration: InputDecoration(
                                                      hintText: (_opcionenvioDireccion ||
                                                              _opcionenvioVentanilla ||
                                                              _opcionenvioWhatsapp)
                                                          ? ''
                                                          : 'Ingrese aqui su Correo electrónico..',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                                    validator: (value) {
                                                      if (value!.isEmpty &&
                                                          _opcionenvioEmail) {
                                                        return 'No deje este campo vacío.';
                                                      }
                                                      if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                              .hasMatch(
                                                                  value) &&
                                                          _opcionenvioEmail) {
                                                        return 'Por favor ingrese un correo válido';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Theme(
                                              data: ThemeData(
                                                checkboxTheme:
                                                    CheckboxThemeData(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0),
                                                  ),
                                                ),
                                                unselectedWidgetColor:
                                                    FlutterFlowTheme.of(context)
                                                        .accent2,
                                              ),
                                              child: Checkbox(
                                                value: _model.checkboxValue3 ??=
                                                    false,
                                                onChanged: (_opcionenvioDireccion ||
                                                        _opcionenvioVentanilla ||
                                                        _opcionenvioEmail)
                                                    ? null
                                                    : (newValue) async {
                                                        setState(() {
                                                          _model.checkboxValue3 =
                                                              newValue!;
                                                          if (_opcionenvioWhatsapp) {
                                                            _opcionenvioWhatsapp =
                                                                false;
                                                          } else {
                                                            _opcionenvioWhatsapp =
                                                                true;
                                                          }
                                                        });
                                                      },
                                                activeColor:
                                                    (_opcionenvioDireccion ||
                                                            _opcionenvioVentanilla ||
                                                            _opcionenvioEmail)
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (!(_opcionenvioDireccion ||
                                                    _opcionenvioVentanilla ||
                                                    _opcionenvioEmail)) {
                                                  setState(() {
                                                    if (_model.checkboxValue3 !=
                                                            null &&
                                                        _model.checkboxValue3 ==
                                                            true) {
                                                      _model.checkboxValue3 =
                                                          false;
                                                    } else {
                                                      if (_model
                                                              .checkboxValue3 !=
                                                          null) {
                                                        _model.checkboxValue3 =
                                                            true;
                                                      }
                                                    }
                                                    if (_opcionenvioWhatsapp) {
                                                      _opcionenvioWhatsapp =
                                                          false;
                                                    } else {
                                                      _opcionenvioWhatsapp =
                                                          true;
                                                    }
                                                  });
                                                }
                                              },
                                              child: Text(
                                                'WhatsApp',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: (_opcionenvioDireccion ||
                                                                _opcionenvioVentanilla ||
                                                                _opcionenvioEmail)
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 8.0, 8.0, 8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.47,
                                                  child: TextFormField(
                                                    controller:
                                                        _model.textController8,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    enabled: (_opcionenvioDireccion ||
                                                            _opcionenvioVentanilla ||
                                                            _opcionenvioEmail)
                                                        ? false
                                                        : true,
                                                    decoration: InputDecoration(
                                                      hintText: (_opcionenvioDireccion ||
                                                              _opcionenvioVentanilla ||
                                                              _opcionenvioEmail)
                                                          ? ''
                                                          : 'Ingrese aqui el número de teléfono..',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                                    validator: (value) {
                                                      if (value!.isEmpty &&
                                                          _opcionenvioWhatsapp) {
                                                        return 'No deje este campo vacío.';
                                                      }
                                                      if ((value.length < 10 ||
                                                              !value.startsWith(
                                                                  '3')) &&
                                                          _opcionenvioWhatsapp) {
                                                        return 'Ingrese un número de teléfono valido';
                                                      }

                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Theme(
                                              data: ThemeData(
                                                checkboxTheme:
                                                    CheckboxThemeData(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0.0),
                                                  ),
                                                ),
                                                unselectedWidgetColor:
                                                    FlutterFlowTheme.of(context)
                                                        .accent2,
                                              ),
                                              child: Checkbox(
                                                value: _model.checkboxValue4 ??=
                                                    false,
                                                onChanged:
                                                    (_opcionenvioDireccion ||
                                                            _opcionenvioWhatsapp ||
                                                            _opcionenvioEmail)
                                                        ? null
                                                        : (newValue) async {
                                                            setState(() {
                                                              _model.checkboxValue4 =
                                                                  newValue!;
                                                              if (_opcionenvioVentanilla) {
                                                                _opcionenvioVentanilla =
                                                                    false;
                                                              } else {
                                                                _opcionenvioVentanilla =
                                                                    true;
                                                              }
                                                            });
                                                          },
                                                activeColor:
                                                    (_opcionenvioDireccion ||
                                                            _opcionenvioWhatsapp ||
                                                            _opcionenvioEmail)
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (!(_opcionenvioDireccion ||
                                                    _opcionenvioWhatsapp ||
                                                    _opcionenvioEmail)) {
                                                  setState(() {
                                                    if (_model.checkboxValue4 !=
                                                            null &&
                                                        _model.checkboxValue4 ==
                                                            true) {
                                                      _model.checkboxValue4 =
                                                          false;
                                                    } else {
                                                      if (_model
                                                              .checkboxValue4 !=
                                                          null) {
                                                        _model.checkboxValue4 =
                                                            true;
                                                      }
                                                    }
                                                    if (_opcionenvioVentanilla) {
                                                      _opcionenvioVentanilla =
                                                          false;
                                                    } else {
                                                      _opcionenvioVentanilla =
                                                          true;
                                                    }
                                                  });
                                                }
                                              },
                                              child: Text(
                                                'Reclamar en ventanilla SDP',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: (_opcionenvioDireccion ||
                                                                _opcionenvioWhatsapp ||
                                                                _opcionenvioEmail)
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 11.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'Número de teléfono de contacto',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 8.0, 8.0, 8.0),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.47,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .textController9,
                                                      autofocus: true,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Ingrese aqui su número de teléfono...',
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                      validator: _model
                                                          .textController8Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
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
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 0.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x44111417),
                                    offset: Offset(0.0, 2.0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 4.0, 4.0, 4.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 4.0, 8.0, 4.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 2.0, 0.0, 5.0),
                                            child: Icon(
                                              Icons.feedback,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 30.0,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              '$nombreTipoPQR',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Si lo desea, indique la dependencia a la que le sera dirijida esta $nombreTipoPQR',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        StreamBuilder<List<Dependencia?>>(
                                          stream: ControladorDependencia()
                                              .obtenerDependenciasStream(''),
                                          builder:
                                              (BuildContext context, snapshot) {
                                            log('Conexion snaphot dependencias: ${snapshot.connectionState} ');

                                            if (snapshot.data != null) {
                                              log('snapshot lenght: ${snapshot.data!.length}');
                                              if (snapshot.data!.length > 1) {
                                                listaTemporalDependencia =
                                                    snapshot.data!;
                                              }
                                              return Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 10,
                                                                    0, 0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0, 0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          5,
                                                                          0,
                                                                          10),
                                                                  child: FlutterFlowDropDown2<
                                                                      Dependencia>(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.95,
                                                                    height: 45,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color: Color.fromARGB(
                                                                              207,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                        ),
                                                                    hintText:
                                                                        'Area...',
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    elevation:
                                                                        2,
                                                                    borderColor:
                                                                        Colors
                                                                            .black,
                                                                    borderWidth:
                                                                        0,
                                                                    borderRadius:
                                                                        8,
                                                                    margin: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            4,
                                                                            12,
                                                                            4),
                                                                    hidesUnderline:
                                                                        true,
                                                                    value: snapshot
                                                                            .data![
                                                                        posicionArea],
                                                                    initialOption:
                                                                        snapshot
                                                                            .data![posicionArea],
                                                                    options: List.generate(
                                                                        snapshot.data!.length,
                                                                        (index) => DropdownMenuItem(
                                                                            value: snapshot.data![index],
                                                                            child: Text(
                                                                              snapshot.data![index]!.nombre.toString(),
                                                                            ))),
                                                                    onChanged:
                                                                        (val) {
                                                                      if (val !=
                                                                          null) {
                                                                        setState(
                                                                            () {
                                                                          posicionArea = snapshot
                                                                              .data!
                                                                              .indexOf(val);
                                                                          log('Posicion area y valor: $posicionArea ${val.nombre}');
                                                                          if (posicionArea <
                                                                              0) {
                                                                            for (var element
                                                                                in listaTemporalDependencia) {
                                                                              log('elemento dependencia: ${element!.nombre}');
                                                                            }
                                                                           
                                                                            posicionArea =
                                                                                val.index;
                                                                            if (posicionArea <
                                                                                0) {
                                                                              posicionArea = 0;
                                                                            }
                                                                          }
                                                                          log('Posicion area: $posicionArea');
                                                                          areaController =
                                                                              val;
                                                                        });
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return Center(
                                                child: Container(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Asunto:',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 8.0, 8.0, 8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.47,
                                                  child: TextFormField(
                                                    controller:
                                                        controladorAsunto,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      hintText: 'Asunto',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                                    maxLines: 1,
                                                    minLines: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Descripción: Haga un relato claro y precisode los hechos:',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 8.0, 8.0, 8.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.47,
                                                  child: TextFormField(
                                                    controller: _model
                                                        .textControllerDescripcionPqrs,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Describa su $nombreTipoPQR',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16.0,
                                                        ),
                                                    maxLines: 7,
                                                    minLines: 4,
                                                    validator: _model
                                                        .textController10Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 0.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x44111417),
                                    offset: Offset(0.0, 2.0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 4.0, 4.0, 4.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 4.0, 8.0, 4.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 2.0, 0.0, 5.0),
                                            child: Icon(
                                              Icons.attach_file,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 30.0,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Documento adicional',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  3.0, 0.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Adjunta en un solo archivo la documentación que consideres necesaria para realizar tu Petición.',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  3.0, 7.0, 0.0, 7.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Tipos de archivos permitidos: doc, txt, xls, xlsx, docx, ppt, pptx, pdf, mp4, mp3, zip, jpg, jpeg, png, gif, rar.',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  3.0, 0.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Peso máximo permitido 2MB',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16.0,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          6.0, 8.0, 0.0, 8.0),
                                      child: HoverContainer(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 12.0, 16.0, 0.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x44111417),
                                    offset: Offset(0.0, 2.0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 4.0, 4.0, 4.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 4.0, 8.0, 4.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 2.0, 0.0, 5.0),
                                            child: Icon(
                                              Icons.warning_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 30.0,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Aviso de privacidad y autorización para el tratamiento de datos personales',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.98,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    3.0, 0.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'Al dar clic en el botón enviar, esta aceptando las políticia de Privacidad y Condiciones generales para el uso de la información que se nombran a continuación:',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 16.0,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  6.0, 16.0, 0.0, 16.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              FFButtonWidget(
                                                onPresionado: () async {
                                                  await launchURL(
                                                      'https://www.lapazrobles-cesar.gov.co/Paginas/Politicas-de-Privacidad-y-Condiciones-de-Uso.aspx');
                                                },
                                                text:
                                                    'Ver Políticas de Privacidad y condiciones de uso',
                                                options: FFButtonOptions(
                                                  width: 650.0,
                                                  height: 60.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .info,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                        fontSize: 25.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
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
                          Align(
                            alignment: AlignmentDirectional(0.0, -0.05),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 70.0, 0.0, 24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FFButtonWidget(
                                    onPresionado: () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          await getToken();
                                          log('El token obetnido es: $_token');
                                          final url =
                                              'https://us-central1-bdpqrs-2623b.cloudfunctions.net/checarRecaptcha'; // Cambia esto con la URL de tu función de Firebase
                                          final response = await http.post(
                                              Uri.parse(url),
                                              body: {'token': _token});
                                          log('Respuesta token: $response');
                                          _respuestaRecaptcha =
                                              response.toString();
                                        } catch (e) {
                                          log('Error al obtener token: $e');
                                        }

                                        if (_opcionenvioDireccion ||
                                            _opcionenvioVentanilla ||
                                            _opcionenvioWhatsapp ||
                                            _opcionenvioEmail) {
                                          await guardarPQR();
                                        } else {
                                          CustomSnackBars().snackBarError(
                                              context,
                                              'Advertencia',
                                              'Seleccione al menos un medio de contacto para dar respuesta a su $nombreTipoPQR');
                                        }
                                      } else {
                                        CustomSnackBars().snackBarError(
                                            context,
                                            'Advertencia',
                                            'No deje campos obligatorios vacios');
                                      }
                                    },
                                    text: 'Enviar $nombreTipoPQR',
                                    options: FFButtonOptions(
                                      width: 250.0,
                                      height: 50.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context).info,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .tertiary,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleFileUpload(dynamic event) {
    final file = event['target']['files'][0];
    final reader = js.JsObject(js.context['FileReader']);

    reader['onLoad'] = js.allowInterop((e) {
      final result = reader.callMethod('getResult');

      // Aquí puedes realizar acciones con el contenido del archivo,
      // como guardarlo temporalmente en memoria.
      print(result);
    });

    reader.callMethod('readAsText', [file]);
  }

  Future<void> guardarPQR() async {
    // Obtener los valores de los controladores de texto y otras variables
    String primerNombre = _model.textControllerPrimerNombre?.text ?? '';
    String segundoNombre = _model.textControllerSegundoNombre?.text ?? '';
    String primerApellido = _model.textControllerPrimerApellido?.text ?? '';
    String segundoApellido = _model.textControllerSegundoApellido?.text ?? '';
    String tipoIdentificacion = _model.dropDownTipoIdentificacion ?? '';
    String numeroIdentificacion =
        _model.textControllerNumeroIdentificacion?.text ?? '';
    bool esAnonima = _model.radioButtonValueEsAnonima?.value == 'Anónima';
    String respuesta = '';
    String tipomedioContacto = '';
    String medioContacto = '';
    if (_model.checkboxValue1 == true) {
      tipomedioContacto = '1';
      medioContacto = _model.textController6?.text ?? '';
    } else if (_model.checkboxValue2 == true) {
      tipomedioContacto = '2';
      medioContacto = _model.textController7?.text ?? '';
    } else if (_model.checkboxValue3 == true) {
      tipomedioContacto = '3';
      medioContacto = _model.textController8?.text ?? '';
    } else if (_model.checkboxValue4 == true) {
      tipomedioContacto = '4';
      medioContacto = '';
    }
    String descripcion = _model.textControllerDescripcionPqrs?.text ?? '';
    String telefono = _model.textController9.text;
    String? nombreAdjuntoPQRS = window.localStorage['nombreAdjuntoPQRS'];
    Counter counter =
        Counter(collectionName: 'counters', documentId: 'contadorPqrs');

// Generar un ID autoincrementado
    int? newId = await counter.incrementCounter(
        FirebaseFirestore.instance.collection('counters').doc('contadorPqrs'));

    if (newId == null) {
      GRecaptchaV3.hideBadge();
      Navigator.pop(context);
    }

    // Crear la instancia de PQR con los valores obtenidos
    Pqrs peticion = Pqrs(
        dependencia: areaController != null ? areaController!.nombre : '',
        asunto: (controladorAsunto.text.length > 3)
            ? controladorAsunto.text
            : 'Sin Asunto',
        id: newId,
        nombreDependencia: '',
        primerNombreSolicitante: primerNombre,
        segundoNombreSolicitante: segundoNombre,
        primerApellidoSolicitante: primerApellido,
        segundoApellidoSolicitante: segundoApellido,
        tipoIdSolicitante: tipoIdentificacion,
        idSolicitante: numeroIdentificacion,
        tipoPQRS: this.nombreTipoPQR,
        tipoMedioContacto: int.parse(tipomedioContacto),
        numTelefono: telefono,
        medioContacto: medioContacto,
        direccion: '',
        descripcion: descripcion,
        respuesta: respuesta,
        nombreArchivoAdjunto: nombreAdjuntoPQRS ?? '',
        fechaInt: DateTime.now().millisecondsSinceEpoch,
        fechaString: DateFormat('d - MMMM - y', 'es').format(DateTime.now()),
        esAnonimo: esAnonima);

    AlertPQRS(pqr: peticion).showConfirmationAlert(context);
    // Llamar a la función guardarPQR con la instancia de PQR
  }

  Future<void> getToken() async {
    String token = await GRecaptchaV3.execute('submit') ?? 'null returned';
    setState(() {
      _token = token;
    });
  }
}
