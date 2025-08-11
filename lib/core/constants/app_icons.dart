import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class AppIcons {
  // Navigation Icons
  static const IconData home = Icons.home;
  static const IconData transactions = Icons.receipt_long;
  static const IconData budget = Icons.account_balance_wallet;
  static const IconData settings = Icons.settings;
  
  // Transaction Type Icons
  static const IconData income = Icons.trending_up;
  static const IconData expense = Icons.trending_down;
  static const IconData add = Icons.add;
  static const IconData edit = Icons.edit;
  static const IconData delete = Icons.delete;
  static const IconData save = Icons.check;
  static const IconData cancel = Icons.close;
  
  // Category Icons
  static const Map<String, IconData> categoryIcons = {
    'Food': FontAwesomeIcons.utensils,
    'Transport': FontAwesomeIcons.car,
    'Entertainment': FontAwesomeIcons.gamepad,
    'Shopping': FontAwesomeIcons.shoppingBag,
    'Healthcare': FontAwesomeIcons.heartPulse,
    'Bills': FontAwesomeIcons.fileInvoiceDollar,
    'Education': FontAwesomeIcons.graduationCap,
    'Salary': FontAwesomeIcons.moneyBillWave,
    'Investment': FontAwesomeIcons.chartLine,
    'Gift': FontAwesomeIcons.gift,
    'Other': FontAwesomeIcons.ellipsis,
  };
  
  // Subcategory Icons
  static const Map<String, IconData> subcategoryIcons = {
    // Food subcategories
    'Coffee': FontAwesomeIcons.mugHot,
    'Restaurant': FontAwesomeIcons.utensils,
    'Groceries': FontAwesomeIcons.cartShopping,
    'Fast Food': FontAwesomeIcons.burger,
    
    // Transport subcategories
    'Fuel': FontAwesomeIcons.gasPump,
    'Public Transport': FontAwesomeIcons.bus,
    'Taxi': FontAwesomeIcons.taxi,
    'Parking': FontAwesomeIcons.squareParking,
    
    // Entertainment subcategories
    'Movie': FontAwesomeIcons.film,
    'Music': FontAwesomeIcons.music,
    'Games': FontAwesomeIcons.gamepad,
    'Sports': FontAwesomeIcons.futbol,
    
    // Shopping subcategories
    'Clothes': FontAwesomeIcons.shirt,
    'Electronics': FontAwesomeIcons.laptop,
    'Books': FontAwesomeIcons.book,
    'Home': FontAwesomeIcons.house,
    
    // Healthcare subcategories
    'Medicine': FontAwesomeIcons.pills,
    'Doctor': FontAwesomeIcons.userDoctor,
    'Dental': FontAwesomeIcons.tooth,
    'Insurance': FontAwesomeIcons.shield,
    
    // Bills subcategories
    'Electricity': FontAwesomeIcons.bolt,
    'Water': FontAwesomeIcons.droplet,
    'Internet': FontAwesomeIcons.wifi,
    'Phone': FontAwesomeIcons.phone,
    'Rent': FontAwesomeIcons.house,
  };
  
  // Payment Method Icons
  static const Map<String, IconData> paymentMethodIcons = {
    'Cash': FontAwesomeIcons.moneyBill,
    'E-Wallet': FontAwesomeIcons.wallet,
    'Bank': FontAwesomeIcons.buildingColumns,
    'Credit Card': FontAwesomeIcons.creditCard,
  };
  
  // UI Icons
  static const IconData arrowBack = Icons.arrow_back;
  static const IconData arrowForward = Icons.arrow_forward;
  static const IconData search = Icons.search;
  static const IconData filter = Icons.filter_list;
  static const IconData sort = Icons.sort;
  static const IconData calendar = Icons.calendar_today;
  static const IconData pieChart = Icons.pie_chart;
  static const IconData barChart = Icons.bar_chart;
  static const IconData visibility = Icons.visibility;
  static const IconData visibilityOff = Icons.visibility_off;
  static const IconData lock = Icons.lock;
  static const IconData unlock = Icons.lock_open;
  static const IconData darkMode = Icons.dark_mode;
  static const IconData lightMode = Icons.light_mode;
  static const IconData autoMode = Icons.brightness_auto;
}
