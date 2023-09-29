import 'dart:developer';
import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto_p_q_r_s/controlador/controlador_pqrs.dart';
import 'package:proyecto_p_q_r_s/controlador/storage_helper.dart';
import 'package:proyecto_p_q_r_s/modelo/pqrs.dart';
import 'package:proyecto_p_q_r_s/vistas/detalles_p_q_r/alert_decidir_estado.dart';
import 'package:proyecto_p_q_r_s/vistas/detalles_p_q_r/alert_delegar_items.dart';
import 'package:proyecto_p_q_r_s/vistas/detalles_p_q_r/alert_delegar_items.dart'
    as hp;
import 'package:proyecto_p_q_r_s/vistas/detalles_p_q_r/alert_respuesta_pqrs.dart';
import 'package:proyecto_p_q_r_s/vistas/detalles_p_q_r/pdfApi.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controlador/controlador_dependencia.dart';
import '../../flutter_flow/custom_snackbars.dart';
import '../../modelo/dependencia.dart';
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
              Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
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
                      if (widget.pqrs.estado == 2)
                        FaIcon(FontAwesomeIcons.clock,
                            color: FlutterFlowTheme.of(context).primaryText),
                      if (widget.pqrs.estado == 3)
                        FaIcon(Icons.check_rounded,
                            size: 37,
                            color: FlutterFlowTheme.of(context).primaryText),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
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
          child: SingleChildScrollView(
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
                          if (widget.pqrs.dependencia != null &&
                              widget.pqrs.dependencia!.trim().isNotEmpty)
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        3.0, 0.0, 20.0, 0.0),
                                    child: Text(
                                      widget.pqrs.dependencia!,
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
                                            widget
                                                .pqrs.segundoApellidoSolicitante
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
                          if (widget.pqrs.numTelefono != null &&
                              widget.pqrs.numTelefono!.trim().isNotEmpty)
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
                                        padding:
                                            const EdgeInsets.only(left: 7.0),
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
                              'Descripción de la ${widget.pqrs.tipoPQRS}:',
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
                                'Archivo adjunto:',
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
                                            widget.pqrs.id!,
                                            widget.pqrs.nombreArchivoAdjunto
                                                .toString(),
                                            'descarga');
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                            color: FlutterFlowTheme.of(context)
                                                .info,
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
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
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(25.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      widget.pqrs
                                                          .nombreArchivoAdjunto
                                                          .toString(),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
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
                          if (widget.pqrs.estado > 1 &&
                              widget.pqrs.respuesta
                                  .toString()
                                  .trim()
                                  .isNotEmpty)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: Text(
                                'Respuesta:',
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
                          if (widget.pqrs.estado > 1 &&
                              widget.pqrs.respuesta
                                  .toString()
                                  .trim()
                                  .isNotEmpty)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 8.0, 20.0, 0.0),
                              child: Text(
                                widget.pqrs.respuesta.toString(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 21.0,
                                    ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.pqrs.estado < 3)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 15.0, 16.0),
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0xFF006344),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
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
                      if (widget.pqrs.estado == 1)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 15.0, 16.0),
                          child: FFButtonWidget(
                            onPresionado: () {
                              try {
                                showAlertDelegar(context);
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0xFF054E63),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
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
                      if (widget.pqrs.estado < 3)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 15.0, 16.0),
                          child: FFButtonWidget(
                            onPresionado: () async {
                              await ControladorPQRS().marcarPqrsFinalizada(
                                  widget.pqrs.id!,
                                  (widget.pqrs.respuesta != null &&
                                          widget.pqrs.respuesta
                                              .toString()
                                              .trim()
                                              .isNotEmpty)
                                      ? widget.pqrs.respuesta!
                                      : 'Sin respuesta/No aplica');
                              CustomSnackBars().snackBarOk(
                                  context,
                                  'Finalizada',
                                  '${widget.pqrs.tipoPQRS} marcada como finalizada/leída');
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
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).secondary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAlertDelegar(BuildContext context) async {
    int posicionArea = 0;
    Dependencia? dependencia = await ControladorDependencia()
        .buscarDepedenciaPorNombre(widget.pqrs.dependencia.toString());
    if (dependencia != null) {
      posicionArea = dependencia.index;
    }
    Alert(
      context: context,
      title: 'Escoja la dependencia',
      content: StatefulBuilder(// You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
        return AlertDelegarItems(
          contextPadre: context,
          iconEnvio: FontAwesomeIcons.envelope,
          nombreDependencia: widget.pqrs.dependencia,
          pqr: widget.pqrs,
          nombreTipoPQR: widget.pqrs.tipoPQRS.toString(),
          posicion: posicionArea,
        );
      }),
      buttons: [
        DialogButton(
          color: FlutterFlowTheme.of(context).primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.xmark,
                  color: FlutterFlowTheme.of(context).tertiary),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Text(
                  'Cancelar',
                  style:
                      TextStyle(color: FlutterFlowTheme.of(context).tertiary),
                ),
              ),
            ],
          ),
          onPressed: () => Navigator.pop(context),
        ),
        DialogButton(
          color: FlutterFlowTheme.of(context).info,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.envelope,
                color: FlutterFlowTheme.of(context).tertiary,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Text('Delegar',
                    style: TextStyle(
                        color: FlutterFlowTheme.of(context).tertiary)),
              ),
            ],
          ),
          onPressed: () async {
            try {
              final prefs = await SharedPreferences.getInstance();
              String? email = prefs.getString('EmailDependencia');
              String? nombreDependencia = prefs.getString('NombreDependencia');
              late String urlAdjunto;
              if (email == null) {
                email = dependencia!.email.toString();
                nombreDependencia = dependencia.nombre.toString();
              }
              log('Holaaaa' + email.toString());
              log('Holaaaa' + nombreDependencia.toString());
              ControladorPQRS().marcarPqrsDelegadoEnProceso(
                  widget.pqrs.id!,
                  nombreDependencia!,
                  '${widget.pqrs.tipoPQRS} delegada a $nombreDependencia');
              print('generar pdf');

              var pdf =
                  await PdfApi().generarHojaSalida(widget.pqrs, 'observacion');
              widget.pqrs.respuesta =
                  '';
              // Genera el archivo PDF en formato Uint8List
              final Uint8List pdfBytes = await pdf.save();
              String? url = await uploadFileToFirebaseStorage(
                  pdfBytes, '${widget.pqrs.id}.pdf');
              log('url Archivo: ${url.toString()}');
              if (widget.pqrs.nombreArchivoAdjunto != null &&
                  widget.pqrs.nombreArchivoAdjunto!.trim().isNotEmpty) {
                String idm2 = widget.pqrs.nombreArchivoAdjunto
                    .toString()
                    .replaceAll('.jpg', '.png');
                urlAdjunto =
                    '\n\nArchivo adjunto en relación a este caso: https://firebasestorage.googleapis.com/v0/b/bdpqrs-2623b.appspot.com/o/pqrs%2F${widget.pqrs.id}%2F$idm2?alt=media&token=';
              } else {
                urlAdjunto = '';
              }
              await sendMail(
                  destinatario: email,
                  asunto:
                      '${widget.pqrs.tipoPQRS} con número de radicado #${widget.pqrs.id}',
                  mensaje:
                      'Saludos $nombreDependencia, delego ante ustedes la siguiente ${widget.pqrs.tipoPQRS}:\n\n"${widget.pqrs.descripcion}"$urlAdjunto\n\nA continuación en el siguiente enlace tendra una copia en formato PDF con los detalles de esta ${widget.pqrs.tipoPQRS}:\n$url');
              widget.pqrs.respuesta =
                  '${widget.pqrs.tipoPQRS} delegada a $nombreDependencia';
              AlertDecidirEstadoPQRS(
                  contextPadre: context,
                  iconEnvio: FontAwesomeIcons.envelope,
                  mensajeEnvio: 'si',
                  pqr: widget.pqrs).showConfirmationAlert(context);
            } catch (e) {
              log(e.toString());
              e.printError();
            }
          },
        ),
      ],
    ).show();
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

  Future<void> sendMail(
      {required String destinatario,
      required String asunto,
      required String mensaje}) async {
    try {
      final mailto = Mailto(
        to: [
          destinatario,
        ],
        subject: asunto,
        body: mensaje,
      );

      await launch('$mailto');
    } catch (e) {
      log('message: $e');
    }
  }

  Future<String?> uploadFileToFirebaseStorage(
      Uint8List fileBytes, String fileName) async {
    try {
      // Obtén una referencia al almacenamiento de Firebase
      final FirebaseStorage storage = FirebaseStorage.instance;

      // Crea una referencia al archivo en Firebase Storage
      final Reference storageReference = storage.ref().child(fileName);

      // Sube el archivo
      final UploadTask uploadTask = storageReference.putData(fileBytes);

      // Espera a que se complete la carga
      await uploadTask.whenComplete(() => print('Archivo subido'));

      // Obtiene el enlace de descarga del archivo subido
      final String downloadUrl = await storageReference.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error al subir el archivo: $e');
      return null;
    }
  }
}
