import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeKey = 'theme_mode';

  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.system)) {
    on<LoadTheme>(_onLoadTheme);
    on<ToggleTheme>(_onToggleTheme);
    on<SetTheme>(_onSetTheme);
    
    // Load theme immediately when bloc is created
    add(LoadTheme());
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeIndex = prefs.getInt(_themeKey) ?? ThemeMode.system.index;
      final themeMode = ThemeMode.values[themeModeIndex];
      emit(ThemeState(themeMode: themeMode));
    } catch (e) {
      emit(const ThemeState(themeMode: ThemeMode.system));
    }
  }

  Future<void> _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) async {
    try {
      final currentMode = state.themeMode;
      ThemeMode newMode;
      
      // Jika system mode, cek brightness untuk menentukan toggle
      if (currentMode == ThemeMode.system) {
        // Default toggle ke light mode jika system
        newMode = ThemeMode.light;
      } else {
        // Toggle antara light dan dark
        newMode = currentMode == ThemeMode.light 
            ? ThemeMode.dark 
            : ThemeMode.light;
      }
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, newMode.index);
      
      emit(ThemeState(themeMode: newMode));
    } catch (e) {
      // Handle error silently, keep current theme
    }
  }

  Future<void> _onSetTheme(SetTheme event, Emitter<ThemeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, event.themeMode.index);
      emit(ThemeState(themeMode: event.themeMode));
    } catch (e) {
      // Handle error silently, keep current theme
    }
  }
}
