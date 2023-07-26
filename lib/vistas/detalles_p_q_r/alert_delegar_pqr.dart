import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mailto/mailto.dart';
import 'package:proyecto_p_q_r_s/modelo/pqrs.dart';
import 'package:proyecto_p_q_r_s/vistas/detalles_p_q_r/alert_decidir_estado.dart';
import 'package:proyecto_p_q_r_s/vistas/detalles_p_q_r/pdfApi.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controlador/controlador_dependencia.dart';
import '../../controlador/controlador_pqrs.dart';
import '../../controlador/storage_helper.dart';
import '../../flutter_flow/flutter_flow_dropdown2.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../modelo/dependencia.dart';

class AlertDelegarRespuestaPQRS extends StatefulWidget {
  final BuildContext contextPadre;
  final Pqrs pqr;
  final IconData iconEnvio;
  final String mensajeEnvio;
  final String nombreTipoPQR;
   AlertDelegarRespuestaPQRS(
      {Key? key,
      required this.contextPadre,
      required this.iconEnvio,
      required this.mensajeEnvio,
      required this.pqr,
      required this.nombreTipoPQR}):super(key: key);

  @override
  State<AlertDelegarRespuestaPQRS> createState() =>
      _AlertDelegarRespuestaPQRSState();

   TextEditingController textControllerDescripcionPqrs =
      new TextEditingController();
  List<Dependencia?> listaTemporalDependencia = [];
  int posicionArea = 0;
  Dependencia? areaController;

  
}

class _AlertDelegarRespuestaPQRSState extends State<AlertDelegarRespuestaPQRS> {
  TextEditingController textControllerDescripcionPqrs =
      new TextEditingController();
  List<Dependencia?> listaTemporalDependencia = [];
  int posicionArea = 0;
  Dependencia? areaController;

  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  refrescarPantalla(){
    setState(() {
      
    });
  }

  
  void mostrarAlertDelegar(BuildContext context) {
    Alert(
      context: context,
      title: 'Escriba su respuesta',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
            child: Container(
              width: 800,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Si lo desea, indique la dependencia a la que le sera dirijida esta ${widget.nombreTipoPQR}',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  StreamBuilder<List<Dependencia?>>(
                    stream:
                        ControladorDependencia().obtenerDependenciasStream(''),
                    builder: (BuildContext context, snapshot) {
                      log('Conexion snaphot dependencias: ${snapshot.connectionState} ');

                      if (snapshot.data != null) {
                        log('snapshot lenght: ${snapshot.data!.length}');
                        if (snapshot.data!.length > 1) {
                          listaTemporalDependencia = snapshot.data!;
                        }
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 5, 0, 10),
                                            child: FlutterFlowDropDown2<
                                                Dependencia>(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.95,
                                              height: 45,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: Color.fromARGB(
                                                            207, 0, 0, 0),
                                                      ),
                                              hintText: 'Area...',
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              elevation: 2,
                                              borderColor: Colors.black,
                                              borderWidth: 0,
                                              borderRadius: 8,
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(12, 4, 12, 4),
                                              hidesUnderline: true,
                                              value:
                                                  snapshot.data![posicionArea],
                                              initialOption:
                                                  snapshot.data![posicionArea],
                                              options: List.generate(
                                                  snapshot.data!.length,
                                                  (index) => DropdownMenuItem(
                                                      value:
                                                          snapshot.data![index],
                                                      child: Text(
                                                        snapshot.data![index]!
                                                            .nombre
                                                            .toString(),
                                                      ))),
                                              onChanged: (val) {
                                                if (val != null) {
                                                
                                                  //setState
                                                  posicionArea = snapshot.data!
                                                      .indexOf(val);
                                                  log('Posicion area y valor: $posicionArea ${val.nombre}');
                                                  if (posicionArea < 0) {
                                                    for (var element
                                                        in listaTemporalDependencia) {
                                                      log('elemento dependencia: ${element!.nombre}');
                                                    }

                                                    posicionArea = val.index;
                                                    if (posicionArea < 0) {
                                                      posicionArea = 0;
                                                    }
                                                  }
                                                  log('Posicion area: $posicionArea');
                                                  areaController = val;
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
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: Text(
                          'Asunto:',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
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
                widget.iconEnvio,
                color: FlutterFlowTheme.of(context).tertiary,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Text(widget.mensajeEnvio,
                    style: TextStyle(
                        color: FlutterFlowTheme.of(context).tertiary)),
              ),
            ],
          ),
          onPressed: () async {
          },
        ),
      ],
    ).show();
  }
}


