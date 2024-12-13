import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_welcome_model.dart';
export 'profile_welcome_model.dart';

class ProfileWelcomeWidget extends StatefulWidget {
  const ProfileWelcomeWidget({super.key});

  @override
  State<ProfileWelcomeWidget> createState() => _ProfileWelcomeWidgetState();
}

class _ProfileWelcomeWidgetState extends State<ProfileWelcomeWidget> {
  late ProfileWelcomeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileWelcomeModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                child: Text(
                  'Let\'s create your profile!',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'Lato',
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: Text(
                  'Add your name and username so people can recognize you. Add your birthday and profile picture to give your profile your own personal touch',
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Lato',
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Align(
                      alignment: const AlignmentDirectional(1.0, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: FlutterFlowIconButton(
                          borderColor: FFAppState().BorderColor,
                          borderRadius: 30.0,
                          borderWidth: 2.0,
                          buttonSize: 40.0,
                          fillColor: FFAppState().ButtonColor,
                          icon: Icon(
                            Icons.arrow_forward,
                            color: (FFAppState().ButtonColor ==
                                        FlutterFlowTheme.of(context).black) ||
                                    (FFAppState().ButtonColor ==
                                        FlutterFlowTheme.of(context).redd) ||
                                    (FFAppState().ButtonColor ==
                                        FlutterFlowTheme.of(context).green) ||
                                    (FFAppState().ButtonColor ==
                                        FlutterFlowTheme.of(context)
                                            .realBlue) ||
                                    (FFAppState().ButtonColor ==
                                        FlutterFlowTheme.of(context).purple) ||
                                    (FFAppState().ButtonColor ==
                                        FlutterFlowTheme.of(context).pink)
                                ? FlutterFlowTheme.of(context).white
                                : FlutterFlowTheme.of(context).primaryText,
                            size: 20.0,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
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
}
