
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_p_q_r_s/modelo/pqrs.dart';

import '../../flutter_flow/flutter_flow_theme.dart';

class tarjetaPqrsIdentificacion extends StatelessWidget {
  final Pqrs pqrs;

  tarjetaPqrsIdentificacion(this.pqrs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: FlutterFlowTheme.of(context).secondaryText,
              spreadRadius: 1,
            )
          ],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: FlutterFlowTheme.of(context).secondaryText,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 2, 8, 4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 1, 1, 1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    definirImagenPqr(pqrs.tipoPQRS),
                    width: 65,
                    height: 65,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 2, 4, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' Ticket N° ${pqrs.id.toString()}',
                        overflow: TextOverflow.ellipsis,
                        style: FlutterFlowTheme.of(context).title3.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).title3Family),
                            ),
                      ),
                      if (!pqrs.esAnonimo)
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                              child: FaIcon(
                                FontAwesomeIcons.person,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 15,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 3, 8, 1),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.49,
                                child: AutoSizeText(
                                  pqrs.primerNombreSolicitante
                                          .toString()
                                          .trim() +
                                      ' ' +
                                      pqrs.primerApellidoSolicitante
                                          .toString()
                                          .trim(),
                                  maxFontSize: 15,
                                  minFontSize: 10,
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyText2Family),
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
                            padding: EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
                            child: FaIcon(
                              FontAwesomeIcons.calendar,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 14,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 3, 8, 1),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.49,
                              child: AutoSizeText(
                                pqrs.fechaString,
                                maxFontSize: 15,
                                minFontSize: 10,
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyText2Family),
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
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF57636C),
                      size: 24,
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

  String definirImagenPqr(String? tipoPeticion) {
    if (tipoPeticion != null) {
      switch (tipoPeticion) {
        case 'Petición':
          return 'https://www.reincorporacion.gov.co/es/atencion/PublishingImages/Paginas/pqrsd/Informes-de-PQRS-D.png';
        case 'Queja':
          return 'https://www.reincorporacion.gov.co/es/atencion/PublishingImages/Paginas/pqrsd/Informes-de-PQRS-D.png';
        case 'Reclamo':
          return 'https://www.reincorporacion.gov.co/es/atencion/PublishingImages/Paginas/pqrsd/Informes-de-PQRS-D.png';
        case 'Sugerencia':
          return 'https://www.reincorporacion.gov.co/es/atencion/PublishingImages/Paginas/pqrsd/Informes-de-PQRS-D.png';
        default:
          return 'https://cdn-icons-png.flaticon.com/512/148/148766.png';
      }
    } else {
      return 'https://cdn-icons-png.flaticon.com/512/148/148766.png';
    }
  }
}
