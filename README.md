# Currency Converter App
This is a currency converter app built with Flutter. The app allows users to convert between different currencies using live exchange rates.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/currency_converter.git

2. cd currency_converter
3. flutter pub get
4. flutter pub run build_runner build --delete-conflicting-outputs
5. flutter run

## Architecture

The app is built using the MVVM (Model-View-ViewModel) architecture pattern. 
- **Model:** Manages the app's data and business logic.
- **View:** Represents the UI and listens for state changes to update the UI.
- **ViewModel:** Acts as a bridge between the Model and View, handling the logic of the UI and interacting with the Model.

## Features

- Live currency conversion
- Add and manage favorite currency pairs
- View historical favorite exchange rates
- Validation
- State management Using RiverPod
- minimum Api calls to Convert rates

## Usage

1. Select the input currency.
2. Select the target currency.
3. Click ADD button before Calculate
4. Click "Calculate" to view the converted amount.


