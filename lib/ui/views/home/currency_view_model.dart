import 'package:currency_converter/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final currencyViewModelProvider = Provider((ref) => CurrencyViewModel(ref));

final checkOngoingClaimsProvider =
    FutureProvider((ref) => CurrencyViewModel(ref).getCurrencies());

final inputCurrencyProvider = StateProvider<String>((ref) => "USD");
final inputAmountProvider = StateProvider<String>((ref) => '');
final targetCurrencyProvider = StateProvider<String>((ref) => 'LKR');
final targetCurrenciesProvider = StateProvider<List<String>>((ref) => []);

final targetCurrenciesWithRatesProvider =
    StateProvider<Map<String, double>>((ref) => {});
final favouriteCurrenciesProvider = StateProvider<List<String>>((ref) => []);
final formattedRatesProvider =
    FutureProvider((ref) => CurrencyViewModel(ref).fetchFormattedRates());

class CurrencyViewModel {
  CurrencyViewModel(this.ref);

  final Ref ref;
  late final curRates = ref.read(currencyServiceProvider);

  set currency(name) => ref.read(inputCurrencyProvider.notifier).state;

  Future<void> getCurrencies() async {
    final inputCurrency = ref.read(inputCurrencyProvider);
    final inputAmount = double.tryParse(ref.read(inputAmountProvider)) ?? 0.0;
    final targetCurrencies = ref.read(targetCurrenciesProvider);

    final rates = await curRates.fetchLatestRates(inputCurrency);

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

  Future<bool> saveFavoriteCurrencyPair(
      String inputCurrency, String targetCurrency) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteCurrencies = prefs.getStringList('favoriteCurrencies') ?? [];
    final newPair = '$inputCurrency:$targetCurrency';

    if (!favoriteCurrencies.contains(newPair)) {
      favoriteCurrencies.add(newPair);
      await prefs.setStringList('favoriteCurrencies', favoriteCurrencies);
      return true;
    }
    return false;
  }

  Future<bool> deleteFavoriteCurrencyPair(String formattedRate) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteCurrencies = prefs.getStringList('favoriteCurrencies') ?? [];

    // Extract the currency pair from the formatted rate as example  'USD:LKR'
    final formattedPair = formattedRate.split(' ');

    String formattedPair1 = formattedPair.join(':');

    if (favoriteCurrencies.contains(formattedPair1.toString())) {
      favoriteCurrencies.remove(formattedPair1.toString());
      await prefs.setStringList('favoriteCurrencies', favoriteCurrencies);

      // Update the provider state
      ref.read(favouriteCurrenciesProvider.notifier).state = favoriteCurrencies;

      // finally, update the formattered rates provider
      ref.refresh(formattedRatesProvider);
      return true;
    }
    return false;
  }

  Future<void> loadFavouriteCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPairs = prefs.getStringList('favoriteCurrencies') ?? [];

    ref.read(favouriteCurrenciesProvider.notifier).state = savedPairs;
  }

  Future<Map<String, String>> fetchFormattedRates() async {
    const baseCurrency = 'USD';
    final favouritePairs = ref.read(favouriteCurrenciesProvider);

    // Fetch rates relative to the base currency (USD in this case)
    final rates = await curRates.fetchLatestRates(baseCurrency);
    print(favouritePairs);
    final Map<String, String> formattedRates = {};

    for (final pair in favouritePairs) {
      final currencies = pair.split(':');
      if (currencies.length == 2) {
        final inputCurrency = currencies[0];
        final targetCurrency = currencies[1];

        final inputRate = rates[inputCurrency];
        final targetRate = rates[targetCurrency];

        if (inputRate != null && targetRate != null) {
          // Calculate conversion rate
          final conversionRate = targetRate / inputRate;
          formattedRates[pair] =
              '1 $inputCurrency = ${conversionRate.toStringAsFixed(2)} $targetCurrency';
        } else {
          formattedRates[pair] = 'Rate not available';
        }
      }
    }

    return formattedRates;
  }
}
