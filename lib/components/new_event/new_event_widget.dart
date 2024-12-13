import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_colorpicker/flutterflow_colorpicker.dart';
import 'package:provider/provider.dart';
import 'new_event_model.dart';
export 'new_event_model.dart';

class NewEventWidget extends StatefulWidget {
  const NewEventWidget({
    super.key,
    String? eventName,
  }) : eventName = eventName ?? 'Event Name';

  final String eventName;

  @override
  State<NewEventWidget> createState() => _NewEventWidgetState();
}

class _NewEventWidgetState extends State<NewEventWidget> {
  late NewEventModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewEventModel());

    _model.eventNameTextController ??= TextEditingController();
    _model.eventNameFocusNode ??= FocusNode();

    _model.eventDescTextController ??= TextEditingController();
    _model.eventDescFocusNode ??= FocusNode();

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
      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: MediaQuery.sizeOf(context).height * 0.833,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create New Event',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Lato',
                          letterSpacing: 0.0,
                        ),
                  ),
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.close,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      context.safePop();
                    },
                  ),
                ],
              ),
              TextFormField(
                controller: _model.eventNameTextController,
                focusNode: _model.eventNameFocusNode,
                autofocus: false,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Event Name',
                  hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Lato',
                        letterSpacing: 0.0,
                      ),
                  filled: true,
                ),
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'Lato',
                      letterSpacing: 0.0,
                    ),
                validator: _model.eventNameTextControllerValidator
                    .asValidator(context),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: FFAppState().BorderColor,
                          width: 2.0,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  'Start Time',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: 'Lato',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Text(
                                dateTimeFormat(
                                    "M/d h:mm a", _model.datePicked1),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Lato',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            icon: Icon(
                              Icons.access_time_outlined,
                              color: FlutterFlowTheme.of(context).secondary,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              final datePicked1Date = await showDatePicker(
                                context: context,
                                initialDate: getCurrentTimestamp,
                                firstDate: getCurrentTimestamp,
                                lastDate: DateTime(2050),
                                builder: (context, child) {
                                  return wrapInMaterialDatePickerTheme(
                                    context,
                                    child!,
                                    headerBackgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    headerForegroundColor:
                                        FlutterFlowTheme.of(context).info,
                                    headerTextStyle:
                                        FlutterFlowTheme.of(context)
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
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                    selectedDateTimeBackgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    selectedDateTimeForegroundColor:
                                        FlutterFlowTheme.of(context).info,
                                    actionButtonForegroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                    iconSize: 24.0,
                                  );
                                },
                              );

                              TimeOfDay? datePicked1Time;
                              if (datePicked1Date != null) {
                                datePicked1Time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      getCurrentTimestamp),
                                  builder: (context, child) {
                                    return wrapInMaterialTimePickerTheme(
                                      context,
                                      child!,
                                      headerBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      headerForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      headerTextStyle:
                                          FlutterFlowTheme.of(context)
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
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      selectedDateTimeBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      selectedDateTimeForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      actionButtonForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      iconSize: 24.0,
                                    );
                                  },
                                );
                              }

                              if (datePicked1Date != null &&
                                  datePicked1Time != null) {
                                safeSetState(() {
                                  _model.datePicked1 = DateTime(
                                    datePicked1Date.year,
                                    datePicked1Date.month,
                                    datePicked1Date.day,
                                    datePicked1Time!.hour,
                                    datePicked1Time.minute,
                                  );
                                });
                              }
                              FFAppState().timePicked1 = true;
                              safeSetState(() {});
                            },
                          ),
                        ].divide(const SizedBox(width: 12.0)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: FFAppState().BorderColor,
                          width: 2.0,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  'End Time',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: 'Lato',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Text(
                                dateTimeFormat(
                                    "M/d h:mm a", _model.datePicked2),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Lato',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            icon: Icon(
                              Icons.access_time_outlined,
                              color: FlutterFlowTheme.of(context).secondary,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              final datePicked2Date = await showDatePicker(
                                context: context,
                                initialDate: getCurrentTimestamp,
                                firstDate: getCurrentTimestamp,
                                lastDate: DateTime(2050),
                                builder: (context, child) {
                                  return wrapInMaterialDatePickerTheme(
                                    context,
                                    child!,
                                    headerBackgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    headerForegroundColor:
                                        FlutterFlowTheme.of(context).info,
                                    headerTextStyle:
                                        FlutterFlowTheme.of(context)
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
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                    selectedDateTimeBackgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    selectedDateTimeForegroundColor:
                                        FlutterFlowTheme.of(context).info,
                                    actionButtonForegroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                    iconSize: 24.0,
                                  );
                                },
                              );

                              TimeOfDay? datePicked2Time;
                              if (datePicked2Date != null) {
                                datePicked2Time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      getCurrentTimestamp),
                                  builder: (context, child) {
                                    return wrapInMaterialTimePickerTheme(
                                      context,
                                      child!,
                                      headerBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      headerForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      headerTextStyle:
                                          FlutterFlowTheme.of(context)
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
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      selectedDateTimeBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      selectedDateTimeForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      actionButtonForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      iconSize: 24.0,
                                    );
                                  },
                                );
                              }

                              if (datePicked2Date != null &&
                                  datePicked2Time != null) {
                                safeSetState(() {
                                  _model.datePicked2 = DateTime(
                                    datePicked2Date.year,
                                    datePicked2Date.month,
                                    datePicked2Date.day,
                                    datePicked2Time!.hour,
                                    datePicked2Time.minute,
                                  );
                                });
                              }
                              FFAppState().timePicked2 = true;
                              safeSetState(() {});
                            },
                          ),
                        ].divide(const SizedBox(width: 12.0)),
                      ),
                    ),
                  ),
                ].divide(const SizedBox(width: 12.0)),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Theme(
                        data: ThemeData(
                          checkboxTheme: const CheckboxThemeData(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(0.0),
                                topRight: Radius.circular(0.0),
                              ),
                            ),
                          ),
                          unselectedWidgetColor: FFAppState().BorderColor,
                        ),
                        child: Checkbox(
                          value: _model.checkboxValue1 ??= false,
                          onChanged: (newValue) async {
                            safeSetState(
                                () => _model.checkboxValue1 = newValue!);
                            if (newValue!) {
                              FFAppState().allDay = true;
                              safeSetState(() {});
                            } else {
                              FFAppState().allDay = false;
                              safeSetState(() {});
                            }
                          },
                          side: BorderSide(
                            width: 2,
                            color: FFAppState().BorderColor,
                          ),
                          activeColor: FFAppState().BorderColor,
                        ),
                      ),
                      Text(
                        'All Day',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Lato',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ].divide(const SizedBox(width: 8.0)),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Theme(
                        data: ThemeData(
                          checkboxTheme: const CheckboxThemeData(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(0.0),
                                topRight: Radius.circular(0.0),
                              ),
                            ),
                          ),
                          unselectedWidgetColor: FFAppState().BorderColor,
                        ),
                        child: Checkbox(
                          value: _model.checkboxValue2 ??= false,
                          onChanged: (newValue) async {
                            safeSetState(
                                () => _model.checkboxValue2 = newValue!);
                            if (newValue!) {
                              FFAppState().daily = true;
                              safeSetState(() {});
                            } else {
                              FFAppState().Weekly = false;
                              safeSetState(() {});
                            }
                          },
                          side: BorderSide(
                            width: 2,
                            color: FFAppState().BorderColor,
                          ),
                          activeColor: FFAppState().BorderColor,
                        ),
                      ),
                      Text(
                        'Daily',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Lato',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ].divide(const SizedBox(width: 8.0)),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Theme(
                        data: ThemeData(
                          checkboxTheme: const CheckboxThemeData(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(0.0),
                                topRight: Radius.circular(0.0),
                              ),
                            ),
                          ),
                          unselectedWidgetColor: FFAppState().BorderColor,
                        ),
                        child: Checkbox(
                          value: _model.checkboxValue3 ??= false,
                          onChanged: (newValue) async {
                            safeSetState(
                                () => _model.checkboxValue3 = newValue!);
                            if (newValue!) {
                              FFAppState().Weekly = true;
                              safeSetState(() {});
                            } else {
                              FFAppState().Monthly = false;
                              safeSetState(() {});
                            }
                          },
                          side: BorderSide(
                            width: 2,
                            color: FFAppState().BorderColor,
                          ),
                          activeColor: FFAppState().BorderColor,
                        ),
                      ),
                      Text(
                        'Weekly',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Lato',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ].divide(const SizedBox(width: 8.0)),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      final colorPickedColor = await showFFColorPicker(
                        context,
                        currentColor: _model.colorPicked ??=
                            FlutterFlowTheme.of(context).primary,
                        showRecentColors: true,
                        allowOpacity: true,
                        textColor: FlutterFlowTheme.of(context).primaryText,
                        secondaryTextColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        backgroundColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        primaryButtonBackgroundColor:
                            FlutterFlowTheme.of(context).primary,
                        primaryButtonTextColor: Colors.white,
                        primaryButtonBorderColor: Colors.transparent,
                        displayAsBottomSheet: isMobileWidth(context),
                      );

                      if (colorPickedColor != null) {
                        safeSetState(
                            () => _model.colorPicked = colorPickedColor);
                      }
                    },
                    child: Container(
                      width: 70.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                          color: FFAppState().BorderColor,
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                    child: Text(
                                      'Event Color',
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily: 'Lato',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                    child: Container(
                                      width: 15.0,
                                      height: 15.0,
                                      decoration: BoxDecoration(
                                        color: valueOrDefault<Color>(
                                          _model.colorPicked,
                                          const Color(0xFF00B2FF),
                                        ),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(const SizedBox(height: 6.0)),
                              ),
                            ),
                          ].divide(const SizedBox(width: 12.0)),
                        ),
                      ),
                    ),
                  ),
                ].divide(const SizedBox(width: 22.0)),
              ),
              TextFormField(
                controller: _model.eventDescTextController,
                focusNode: _model.eventDescFocusNode,
                autofocus: false,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Event Description',
                  hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Lato',
                        letterSpacing: 0.0,
                      ),
                  filled: true,
                ),
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'Lato',
                      letterSpacing: 0.0,
                    ),
                maxLines: 4,
                minLines: 3,
                validator: _model.eventDescTextControllerValidator
                    .asValidator(context),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Theme(
                    data: ThemeData(
                      checkboxTheme: const CheckboxThemeData(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(0.0),
                          ),
                        ),
                      ),
                      unselectedWidgetColor: FFAppState().BorderColor,
                    ),
                    child: Checkbox(
                      value: _model.checkboxValue4 ??= false,
                      onChanged: (newValue) async {
                        safeSetState(() => _model.checkboxValue4 = newValue!);
                      },
                      side: BorderSide(
                        width: 2,
                        color: FFAppState().BorderColor,
                      ),
                      activeColor: FFAppState().BorderColor,
                    ),
                  ),
                  Text(
                    'Add Travel Time',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Lato',
                          letterSpacing: 0.0,
                        ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: FFAppState().BorderColor,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            8.0, 12.0, 8.0, 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '30 minutes',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Lato',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: FFAppState().BorderColor,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            8.0, 12.0, 8.0, 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Before',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Lato',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ].divide(const SizedBox(width: 12.0)),
              ),
              FFButtonWidget(
                onPressed: () async {
                  if (!FFAppState().timePicked1) {
                    await AppointmentsRecord.collection
                        .doc()
                        .set(createAppointmentsRecordData(
                          userID: currentUserDisplayName,
                          eventName: _model.eventNameTextController.text,
                          eventTime: getCurrentTimestamp,
                          endTime: getCurrentTimestamp,
                          eventDescription: _model.eventDescTextController.text,
                          isAllDay: FFAppState().allDay,
                          weekly: FFAppState().Weekly,
                          color: _model.colorPicked,
                          daily: FFAppState().daily,
                        ));
                  } else if (!FFAppState().timePicked2) {
                    await AppointmentsRecord.collection
                        .doc()
                        .set(createAppointmentsRecordData(
                          userID: currentUserDisplayName,
                          eventName: _model.eventNameTextController.text,
                          eventTime: getCurrentTimestamp,
                          endTime: getCurrentTimestamp,
                          eventDescription: _model.eventDescTextController.text,
                          isAllDay: FFAppState().allDay,
                          weekly: FFAppState().Weekly,
                          color: _model.colorPicked,
                          daily: FFAppState().daily,
                        ));
                  } else {
                    await AppointmentsRecord.collection
                        .doc()
                        .set(createAppointmentsRecordData(
                          userID: currentUserDisplayName,
                          eventName: _model.eventNameTextController.text,
                          eventTime: _model.datePicked1,
                          endTime: _model.datePicked2,
                          eventDescription: _model.eventDescTextController.text,
                          isAllDay: FFAppState().allDay,
                          weekly: FFAppState().Weekly,
                          color: _model.colorPicked,
                          daily: FFAppState().daily,
                        ));
                  }

                  context.pushNamed('CalendarView');

                  FFAppState().allDay = false;
                  FFAppState().Weekly = false;
                  FFAppState().daily = false;
                  FFAppState().timePicked1 = false;
                  FFAppState().timePicked2 = false;
                  safeSetState(() {});
                },
                text: 'Save Event',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 50.0,
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FFAppState().ButtonColor,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Lato',
                        color: (FFAppState().ButtonColor ==
                                    FlutterFlowTheme.of(context).black) ||
                                (FFAppState().ButtonColor ==
                                    FlutterFlowTheme.of(context).redd) ||
                                (FFAppState().ButtonColor ==
                                    FlutterFlowTheme.of(context).green) ||
                                (FFAppState().ButtonColor ==
                                    FlutterFlowTheme.of(context).realBlue) ||
                                (FFAppState().ButtonColor ==
                                    FlutterFlowTheme.of(context).purple) ||
                                (FFAppState().ButtonColor ==
                                    FlutterFlowTheme.of(context).pink)
                            ? FlutterFlowTheme.of(context).white
                            : FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: FFAppState().BorderColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ].divide(const SizedBox(height: 16.0)),
          ),
        ),
      ),
    );
  }
}
