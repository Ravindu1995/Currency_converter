import 'package:currency_converter/providers/currencies_provider.dart';
import 'package:currency_converter/ui/theme/app_colors.dart';
import 'package:currency_converter/ui/views/favorite/favourite_view.dart';
import 'package:currency_converter/ui/views/home/currency_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final currencyState = ref.watch(currencyViewModelProvider);
    final controller = ref.watch(currencyViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Currency Converter',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                controller.loadFavouriteCurrencies();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavouriteView()),
                );
              },
              icon: const Icon(Icons.favorite))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownSearch<String>(
                validator: (String? item) {
                  if (item == null) {
                    return "This field cannot be empty.";
                  } else {
                    return null;
                  }
                },
                popupProps: const PopupProps.menu(
                  showSearchBox: true,
                  showSelectedItems: true,
                  // disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: currencyCodes.toList(),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Currency name",
                    hintText: "Select Currency",
                    hintStyle: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary.withOpacity(0.5)),
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary.withOpacity(0.5)),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide:
                          BorderSide(color: AppColors.green, width: 1.0),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: AppColors.red, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: AppColors.ash, width: 1.0),
                    ),
                  ),
                ),
                onChanged: (value) {
                  ref.read(inputCurrencyProvider.notifier).state =
                      value.toString();
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: TextFormField(
                  onChanged: (currency) {
                    ref.read(inputAmountProvider.notifier).state =
                        currency.toString();
                  },
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide:
                          BorderSide(color: AppColors.green, width: 1.0),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: AppColors.red, width: 1.0),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: AppColors.red, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide:
                          BorderSide(color: AppColors.ashSecond, width: 1.0),
                    ),
                    labelText: "Amount",
                    labelStyle: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary.withOpacity(0.5)),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "To",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontSize: 24),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 60.w,
                    child: DropdownSearch<String>(
                      validator: (String? item) {
                        if (item == null) {
                          return "This field cannot be empty.";
                        } else {
                          return null;
                        }
                      },
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: true,
                      ),
                      items: currencyCodes.toList(),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Currency name",
                          hintText: "Select Currency",
                          hintStyle: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary.withOpacity(0.5),
                          ),
                          labelStyle: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary.withOpacity(0.5),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: AppColors.green, width: 1.0),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: AppColors.red, width: 1.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: AppColors.ash, width: 1.0),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        ref.read(targetCurrencyProvider.notifier).state =
                            value.toString();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      final selectedCurrency = ref.read(targetCurrencyProvider);
                      final currentList = ref.read(targetCurrenciesProvider);

                      // Add the selected currency if it's not already in the list
                      if (selectedCurrency.isNotEmpty &&
                          !currentList.contains(selectedCurrency)) {
                        ref.read(targetCurrenciesProvider.notifier).state = [
                          ...currentList,
                          selectedCurrency
                        ];
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 28),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.background,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Consumer(
                builder: (context, ref, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        ref.watch(targetCurrenciesProvider).map((currency) {
                      final rates =
                          ref.watch(targetCurrenciesWithRatesProvider);
                      final rate = rates[currency];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 12),
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 245, 238, 238),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              rate != null
                                  ? '$currency : $rate'
                                  : '$currency : ',
                              style: const TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  final inputCurrency =
                                      ref.read(inputCurrencyProvider);
                                  final targetCurrency =
                                      ref.read(targetCurrencyProvider);
                                  controller
                                      .saveFavoriteCurrencyPair(
                                          inputCurrency, targetCurrency)
                                      .then((success) {
                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Successfully Added $currency from favorites.'),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Failed to add $currency from favorites.'),
                                        ),
                                      );
                                    }
                                  });
                                  ;
                                },
                                icon: const Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.pink,
                                ))
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          final targetCurrencies = ref.read(targetCurrenciesProvider);

          if (targetCurrencies.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please add at least one target currency.'),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            controller.getCurrencies();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 36),
          child: const Text(
            "Calculate",
            style: TextStyle(color: AppColors.background, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
