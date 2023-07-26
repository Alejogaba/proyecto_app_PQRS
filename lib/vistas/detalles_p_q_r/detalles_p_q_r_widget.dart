import 'dart:developer';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto_p_q_r_s/controlador/controlador_pqrs.dart';
import 'package:proyecto_p_q_r_s/controlador/storage_helper.dart';
import 'package:proyecto_p_q_r_s/modelo/pqrs.dart';
import 'package:proyecto_p_q_r_s/vistas/detalles_p_q_r/alert_delegar_pqr.dart';
import 'package:proyecto_p_q_r_s/vistas/detalles_p_q_r/alert_delegar_pqr.dart'
    as hp;
import 'package:proyecto_p_q_r_s/vistas/detalles_p_q_r/alert_respuesta_pqrs.dart';
import 'package:url_launcher/url_launcher.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'detalles_p_q_r_model.dart';
export 'detalles_p_q_r_model.dart';
import 'package:mailto/mailto.dart';
import 'package:get/get.dart';

class DetallesPQRWidget extends StatefulWidget {
  final Pqrs pqrs;
  const DetallesPQRWidget(this.pqrs, {Key? key}) : super(key: key);

  @override
  _DetallesPQRWidgetState createState() => _DetallesPQRWidgetState();
}

class _DetallesPQRWidgetState extends State<DetallesPQRWidget> {
  late DetallesPQRModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetallesPQRModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
          child: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            title: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                        child: Text(
                          widget.pqrs.tipoPQRS.toString(),
                          style: FlutterFlowTheme.of(context)
                              .displaySmall
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [],
            centerTitle: true,
            elevation: 0.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: Color(0x2E000000),
                        offset: Offset(0.0, 2.0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: Text(
                                ' ',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: Text(
                                'Fecha:  ${widget.pqrs.fechaString.toString()}',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Text(
                                  'Dependencia solicitada:',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Icon(
                                Icons.settings_outlined,
                                color: Colors.black,
                                size: 18.0,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    3.0, 0.0, 20.0, 0.0),
                                child: Text(
                                  '${widget.pqrs.nombreDependencia.toString()}',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Text(
                                  'Nombre del solicitante:',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 20.0, 0.0),
                                child: Text(
                                  ('${widget.pqrs.primerNombreSolicitante.toString()}' +
                                          ' ' +
                                          widget.pqrs.segundoNombreSolicitante
                                              .toString() +
                                          ' ' +
                                          '${widget.pqrs.primerApellidoSolicitante.toString()}' +
                                          ' ' +
                                          widget.pqrs.segundoApellidoSolicitante
                                              .toString())
                                      .replaceAll('  ', ' '),
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Text(
                                  'Número de telefono:',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 20.0, 0.0),
                                child: Text(
                                  '${widget.pqrs.numTelefono.toString()}',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Text(
                                  'Tipo de medio de envio de la respuesta:',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    6.0, 0.0, 20.0, 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    FaIcon(
                                      definirIcono(
                                          widget.pqrs.tipoMedioContacto),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 7.0),
                                      child: Text(
                                        definirTipoEnvio(
                                            widget.pqrs.tipoMedioContacto),
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 20.0, 0.0),
                                child: Text(
                                  'Medio de envio:',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 20.0, 0.0),
                                child: Text(
                                  widget.pqrs.medioContacto.toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 0.0, 20.0, 0.0),
                          child: Text(
                            'Descripción de la ${widget.pqrs.tipoPQRS}',
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              20.0, 8.0, 20.0, 0.0),
                          child: Text(
                            widget.pqrs.descripcion.toString(),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  fontSize: 21.0,
                                ),
                          ),
                        ),
                        if (widget.pqrs.nombreArchivoAdjunto
                            .toString()
                            .isNotEmpty)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 10.0, 20.0, 0.0),
                            child: Text(
                              widget.pqrs.nombreArchivoAdjunto.toString(),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        if (widget.pqrs.nombreArchivoAdjunto != null &&
                            widget.pqrs.nombreArchivoAdjunto
                                .toString()
                                .isNotEmpty)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                6.0, 8.0, 0.0, 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 3.0, 0.0, 7.0),
                                  child: InkWell(
                                    onTap: () {
                                      StorageHelper().descargarArchivo(
                                          'NPkcT3fnkQSTAiDhBSrn', 'descarga');
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              borderRadius:
                                                  BorderRadius.circular(13.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                              ),
                                            ),
                                            alignment: AlignmentDirectional(
                                                0.050000000000000044,
                                                0.050000000000000044),
                                            child: Icon(
                                              Icons.attach_file,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
                                              size: 24.0,
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 450.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          25.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    widget.pqrs
                                                        .nombreArchivoAdjunto
                                                        .toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 16.0),
                    child: FFButtonWidget(
                      onPresionado: () {
                        try {
                          AlertRespuestaPQRS(
                                  contextPadre: context,
                                  iconEnvio: definirIcono(
                                      widget.pqrs.tipoMedioContacto),
                                  mensajeEnvio: definirMensajeEnvio(
                                      widget.pqrs.tipoMedioContacto),
                                  pqr: widget.pqrs)
                              .showConfirmationAlert(context);
                        } catch (e) {
                          log('Error responder: $e');
                        }
                      },
                      text: 'Responder',
                      icon: Icon(
                        Icons.email_outlined,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        width: 300.0,
                        height: 50.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Color(0xFF006344),
                        textStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                        elevation: 3.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 16.0),
                    child: FFButtonWidget(
                      onPresionado: () {
                        try {
                          dynamic a = AlertDelegarRespuestaPQRS(
                              nombreTipoPQR: widget.pqrs.tipoPQRS.toString(),
                              contextPadre: context,
                              iconEnvio:
                                  definirIcono(widget.pqrs.tipoMedioContacto),
                              mensajeEnvio: definirMensajeEnvio(
                                  widget.pqrs.tipoMedioContacto),
                              pqr: widget.pqrs);
                          hp.AlertDelegarRespuestaPQRS;
                        } catch (e) {
                          log('Error responder: $e');
                        }
                      },
                      text: 'Delegar',
                      icon: Icon(
                        Icons.forward_to_inbox_outlined,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        width: 300.0,
                        height: 50.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Color(0xFF054E63),
                        textStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                        elevation: 3.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 16.0),
                    child: FFButtonWidget(
                      onPresionado: () async {
                        await ControladorPQRS()
                            .marcarPqrsFinalizada(widget.pqrs.id!);
                        Get.snackbar('Finzalizado',
                            '${widget.pqrs.tipoPQRS} marcada como finalizada',
                            duration: Duration(seconds: 5),
                            margin: EdgeInsets.fromLTRB(4, 8, 4, 0),
                            snackStyle: SnackStyle.FLOATING,
                            backgroundColor: Color.fromARGB(211, 28, 138, 46),
                            icon: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            colorText: Color.fromARGB(255, 228, 219, 218));
                        Navigator.of(context).pop();
                      },
                      text: 'Marcar como finalizado',
                      icon: Icon(
                        Icons.check_rounded,
                        size: 15.0,
                      ),
                      options: FFButtonOptions(
                        width: 300.0,
                        height: 50.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                        elevation: 3.0,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData definirIcono(int tipoMedioRespuesta) {
    switch (tipoMedioRespuesta) {
      case 2:
        return FontAwesomeIcons.envelope;
      case 3:
        return FontAwesomeIcons.whatsapp;
      default:
        return FontAwesomeIcons.print;
    }
  }

  String definirMensajeEnvio(int tipoMedioRespuesta) {
    switch (tipoMedioRespuesta) {
      case 2:
        return 'Enviar respuesta al correo';
      case 3:
        return 'Enviar respuesta al WhatsApp';
      default:
        return 'Imprimir';
    }
  }

  String definirTipoEnvio(int tipoMedioRespuesta) {
    switch (tipoMedioRespuesta) {
      case 1:
        return 'Enviar por correspondencia';
      case 2:
        return 'Enviar respuesta al correo electrónico';
      case 3:
        return 'Enviar respuesta al WhatsApp';
      default:
        return 'Reclamar en ventanilla';
    }
  }
}
