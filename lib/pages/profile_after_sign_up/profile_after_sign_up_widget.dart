import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/profile_welcome/profile_welcome_widget.dart';
import '/components/set_profile_picture/set_profile_picture_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'profile_after_sign_up_model.dart';
export 'profile_after_sign_up_model.dart';

class ProfileAfterSignUpWidget extends StatefulWidget {
  const ProfileAfterSignUpWidget({super.key});

  @override
  State<ProfileAfterSignUpWidget> createState() =>
      _ProfileAfterSignUpWidgetState();
}

class _ProfileAfterSignUpWidgetState extends State<ProfileAfterSignUpWidget> {
  late ProfileAfterSignUpModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileAfterSignUpModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Padding(
              padding: MediaQuery.viewInsetsOf(context),
              child: const ProfileWelcomeWidget(),
            ),
          );
        },
      ).then((value) => safeSetState(() {}));
    });

    _model.nameTextController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.realName, ''));
    _model.nameFocusNode ??= FocusNode();

    _model.userNameTextController ??=
        TextEditingController(text: currentUserDisplayName);
    _model.userNameFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, -1.0),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Profile',
                      style: FlutterFlowTheme.of(context).displaySmall.override(
                            fontFamily: 'Lato',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ),
                Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: const SetProfilePictureWidget(),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                        child: Stack(
                          alignment: const AlignmentDirectional(-1.0, 1.0),
                          children: [
                            AuthUserStreamWidget(
                              builder: (context) => Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.network(
                                      currentUserPhoto,
                                    ).image,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.camera_alt,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 32.0,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => SizedBox(
                            width: 200.0,
                            child: TextFormField(
                              key: const ValueKey('Name_mehr'),
                              controller: _model.nameTextController,
                              focusNode: _model.nameFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Lato',
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Name...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Lato',
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FFAppState().BorderColor,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Lato',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: _model.nameTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => SizedBox(
                            width: 200.0,
                            child: TextFormField(
                              key: const ValueKey('UserName_bwh3'),
                              controller: _model.userNameTextController,
                              focusNode: _model.userNameFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Lato',
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Username...',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Lato',
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FFAppState().BorderColor,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Lato',
                                    letterSpacing: 0.0,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: _model.userNameTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            final datePickedDate = await showDatePicker(
                              context: context,
                              initialDate: getCurrentTimestamp,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2050),
                              builder: (context, child) {
                                return wrapInMaterialDatePickerTheme(
                                  context,
                                  child!,
                                  headerBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  headerForegroundColor:
                                      FlutterFlowTheme.of(context).info,
                                  headerTextStyle: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .override(
                                        fontFamily: 'Lato',
                                        fontSize: 32.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  pickerBackgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                  pickerForegroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  selectedDateTimeBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  selectedDateTimeForegroundColor:
                                      FlutterFlowTheme.of(context).info,
                                  actionButtonForegroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  iconSize: 24.0,
                                );
                              },
                            );

                            if (datePickedDate != null) {
                              safeSetState(() {
                                _model.datePicked = DateTime(
                                  datePickedDate.year,
                                  datePickedDate.month,
                                  datePickedDate.day,
                                );
                              });
                            }
                          },
                          text: 'Set Birthday',
                          options: FFButtonOptions(
                            width: 200.0,
                            height: 40.0,
                            padding: const EdgeInsets.all(0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FFAppState().ButtonColor,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Lato',
                                  color:
                                      (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .black) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .redd) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .green) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .realBlue) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .purple) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .pink)
                                          ? FlutterFlowTheme.of(context).white
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                  letterSpacing: 0.0,
                                ),
                            borderSide: BorderSide(
                              color: FFAppState().BorderColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child:
                                  StreamBuilder<List<DisplayNameInUseRecord>>(
                                stream: queryDisplayNameInUseRecord(
                                  singleRecord: true,
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<DisplayNameInUseRecord>
                                      buttonDisplayNameInUseRecordList =
                                      snapshot.data!;
                                  // Return an empty Container when the item does not exist.
                                  if (snapshot.data!.isEmpty) {
                                    return Container();
                                  }
                                  final buttonDisplayNameInUseRecord =
                                      buttonDisplayNameInUseRecordList
                                              .isNotEmpty
                                          ? buttonDisplayNameInUseRecordList
                                              .first
                                          : null;

                                  return FFButtonWidget(
                                    key: const ValueKey('Button_3gn1'),
                                    onPressed: () async {
                                      if (_model.formKey.currentState == null ||
                                          !_model.formKey.currentState!
                                              .validate()) {
                                        return;
                                      }
                                      if (buttonDisplayNameInUseRecord
                                              ?.displayNamesUsed
                                              .contains(_model
                                                  .userNameTextController
                                                  .text) ==
                                          true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Username is already taken! ',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                const Duration(milliseconds: 4000),
                                            backgroundColor: const Color(0xFFF10616),
                                          ),
                                        );
                                      } else {
                                        await currentUserReference!
                                            .update(createUsersRecordData(
                                          displayName: _model
                                              .userNameTextController.text,
                                          birthday: _model.datePicked,
                                          realName:
                                              _model.nameTextController.text,
                                        ));

                                        await buttonDisplayNameInUseRecord!
                                            .reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'displayNamesUsed':
                                                  FieldValue.arrayUnion([
                                                _model
                                                    .userNameTextController.text
                                              ]),
                                            },
                                          ),
                                        });

                                        context.goNamed('Feed');
                                      }
                                    },
                                    text: 'Save your profile',
                                    options: FFButtonOptions(
                                      width: 250.0,
                                      height: 50.0,
                                      padding: const EdgeInsets.all(0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FFAppState().ButtonColor,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Lato',
                                            color: (FFAppState().ButtonColor ==
                                                        FlutterFlowTheme
                                                                .of(context)
                                                            .black) ||
                                                    (FFAppState().ButtonColor ==
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .redd) ||
                                                    (FFAppState().ButtonColor ==
                                                        FlutterFlowTheme
                                                                .of(context)
                                                            .green) ||
                                                    (FFAppState().ButtonColor ==
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .realBlue) ||
                                                    (FFAppState().ButtonColor ==
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .purple) ||
                                                    (FFAppState().ButtonColor ==
                                                        FlutterFlowTheme
                                                                .of(context)
                                                            .pink)
                                                ? FlutterFlowTheme.of(context)
                                                    .white
                                                : FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 10.0,
                                      borderSide: BorderSide(
                                        color: FFAppState().BorderColor,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ].divide(const SizedBox(height: 24.0)),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Draggable<String>(
                      data: '',
                      feedback: Material(
                        type: MaterialType.transparency,
                        child: Draggable<String>(
                          data: '',
                          feedback: Material(
                            type: MaterialType.transparency,
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  print('GoogleCalenLink pressed ...');
                                },
                                text: 'Link your Google Calendar',
                                options: FFButtonOptions(
                                  width: 250.0,
                                  height: 50.0,
                                  padding: const EdgeInsets.all(0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FFAppState().ButtonColor,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Lato',
                                        color: (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme
                                                            .of(context)
                                                        .black) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .redd) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .green) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .realBlue) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .purple) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .pink)
                                            ? FlutterFlowTheme.of(context).white
                                            : FlutterFlowTheme.of(context)
                                                .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 10.0,
                                  borderSide: BorderSide(
                                    color: FFAppState().BorderColor,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('GoogleCalenLink pressed ...');
                              },
                              text: 'Link your Google Calendar',
                              options: FFButtonOptions(
                                width: 250.0,
                                height: 50.0,
                                padding: const EdgeInsets.all(0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FFAppState().ButtonColor,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Lato',
                                      color: (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme
                                                          .of(context)
                                                      .black) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .redd) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .green) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .realBlue) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .purple) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .pink)
                                          ? FlutterFlowTheme.of(context).white
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 10.0,
                                borderSide: BorderSide(
                                  color: FFAppState().BorderColor,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      child: Draggable<String>(
                        data: '',
                        feedback: Material(
                          type: MaterialType.transparency,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('GoogleCalenLink pressed ...');
                              },
                              text: 'Link your Google Calendar',
                              options: FFButtonOptions(
                                width: 250.0,
                                height: 50.0,
                                padding: const EdgeInsets.all(0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FFAppState().ButtonColor,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Lato',
                                      color: (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme
                                                          .of(context)
                                                      .black) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .redd) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .green) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .realBlue) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .purple) ||
                                              (FFAppState().ButtonColor ==
                                                  FlutterFlowTheme.of(context)
                                                      .pink)
                                          ? FlutterFlowTheme.of(context).white
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 10.0,
                                borderSide: BorderSide(
                                  color: FFAppState().BorderColor,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('GoogleCalenLink pressed ...');
                            },
                            text: 'Link your Google Calendar',
                            options: FFButtonOptions(
                              width: 250.0,
                              height: 50.0,
                              padding: const EdgeInsets.all(0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FFAppState().ButtonColor,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Lato',
                                    color:
                                        (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .black) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .redd) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .green) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .realBlue) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .purple) ||
                                                (FFAppState().ButtonColor ==
                                                    FlutterFlowTheme.of(context)
                                                        .pink)
                                            ? FlutterFlowTheme.of(context).white
                                            : FlutterFlowTheme.of(context)
                                                .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 10.0,
                              borderSide: BorderSide(
                                color: FFAppState().BorderColor,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(14.0),
                            ),
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
    );
  }
}
