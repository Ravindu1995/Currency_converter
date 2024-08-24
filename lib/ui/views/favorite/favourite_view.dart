import 'package:currency_converter/ui/views/home/currency_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouriteView extends ConsumerWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Currencies'),
        actions: [
          IconButton(
              onPressed: () {
                ref.refresh(formattedRatesProvider);
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.green,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer(
          builder: (context, ref, child) {
            final formattedRatesAsyncValue = ref.watch(formattedRatesProvider);

            return formattedRatesAsyncValue.when(
              data: (formattedRates) {
                if (formattedRates.isEmpty) {
                  return const Center(
                    child: Text('No favourite currencies added.'),
                  );
                }

                return ListView.builder(
                  itemCount: formattedRates.length,
                  itemBuilder: (context, index) {
                    final pair = formattedRates.keys.elementAt(index);
                    final rate = formattedRates[pair];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              rate ?? 'Rate not available',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(currencyViewModelProvider)
                                  .deleteFavoriteCurrencyPair(pair)
                                  .then((success) {
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Successfully removed $pair from favorites.'),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Failed to remove $pair from favorites.'),
                                    ),
                                  );
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
            );
          },
        ),
      ),
    );
  }
}
