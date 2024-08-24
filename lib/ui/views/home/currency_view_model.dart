
import 'package:currency_converter/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final CurrencyViewModelProvider = Provider((ref) => CurrencyViewModel(ref));

final checkOngoingClaimsProvider =
    FutureProvider((ref) => CurrencyViewModel(ref).getCurrencies());

final inputCurrencyProvider = StateProvider<String>((ref) => "USD");
final inputAmountProvider = StateProvider<String>((ref) => '');
final targetCurrencyProvider = StateProvider<String>((ref) => 'LKR');
final targetCurrenciesProvider = StateProvider<List<String>>((ref) => []);

final targetCurrenciesWithRatesProvider =
    StateProvider<Map<String, double>>((ref) => {});

class CurrencyViewModel {
  CurrencyViewModel(this.ref);

  final Ref ref;
  late final policy = ref.read(currencyServiceProvider);

  set currency(name) => ref.read(inputCurrencyProvider.notifier).state;

  Future<void> getCurrencies() async {
    final inputCurrency = ref.read(inputCurrencyProvider);
    final inputAmount = double.tryParse(ref.read(inputAmountProvider)) ?? 0.0;
    final targetCurrencies = ref.read(targetCurrenciesProvider);

    final rates = await policy.fetchLatestRates(inputCurrency);

    final updatedRates = <String, double>{};

    for (final currency in targetCurrencies) {
      if (rates.containsKey(currency)) {
        final rate = rates[currency] as double;
        final convertedAmount = inputAmount * rate;
        updatedRates[currency] = convertedAmount;
      }
    }

    ref.read(targetCurrenciesWithRatesProvider.notifier).state = updatedRates;
  }
}
