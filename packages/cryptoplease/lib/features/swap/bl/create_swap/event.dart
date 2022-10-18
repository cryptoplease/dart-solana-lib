part of 'bloc.dart';

@freezed
class CreateSwapEvent with _$CreateSwapEvent {
  const factory CreateSwapEvent.initialized() = Init;

  const factory CreateSwapEvent.amountUpdated(Decimal decimal) = AmountUpdated;

  const factory CreateSwapEvent.editingModeToggled() = EditingModeToggled;

  const factory CreateSwapEvent.slippageUpdated(Decimal slippage) =
      SlippageUpdated;

  const factory CreateSwapEvent.submitted() = Submitted;

  const factory CreateSwapEvent.routeInvalidated() = RouteInvalidated;
}
