import 'dart:math';
import 'package:cma_registrator/core/extensions/date_time_formatted_extension.dart';
import 'package:cma_registrator/core/models/operating_cycle/operating_cycle.dart';
import 'package:cma_registrator/core/repositories/operating_cycle_details/operating_cycle_details.dart';
import 'package:cma_registrator/core/widgets/error_message_widget.dart';
import 'package:cma_registrator/core/widgets/future_builder_widget.dart';
import 'package:cma_registrator/pages/operating_cycle_details/widgets/operating_cycle_details_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hmi_core/hmi_core.dart';
import 'package:hmi_core/hmi_core_app_settings.dart';
///
class OperatingCycleDetailsPage extends StatelessWidget {
  final OperatingCycle _operatingCycle;
  final OperatingCycleDetails _operatingCycleDetails;
  static const routeName = '/operatingCycleDetails';
  ///
  const OperatingCycleDetailsPage({
    super.key, 
    required OperatingCycle operatingCycle, 
    required OperatingCycleDetails operatingCycleDetails,
  }) : 
    _operatingCycle = operatingCycle,
    _operatingCycleDetails = operatingCycleDetails;
  //
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: FutureBuilderWidget(
        onFuture: _operatingCycleDetails.fetchAll,
        retryLabel: Padding(
          padding: EdgeInsets.symmetric(
            vertical: const Setting('padding').toDouble,
          ),
          child: Text(
            const Localized('Retry').v,
            style: theme.textTheme.titleLarge?.copyWith(
              height: 1,
              color: theme.colorScheme.onPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        caseLoading: (_) => const Center(
          child: CupertinoActivityIndicator(),
        ),
        validateData: (data) {
          return !data.hasError;
        },
        caseData: (context, result) => OperatingCycleDetailsBody(
          operatingCycle: _operatingCycle,
          points: result.data,
        ),
        caseError: (_, error) => ErrorMessageWidget(
          message: const Localized('Data loading error').v,
        ),
        caseNothing: (context) => ErrorMessageWidget(
          message: const Localized('No data').v,
        ),
      ),
    );
  }
}