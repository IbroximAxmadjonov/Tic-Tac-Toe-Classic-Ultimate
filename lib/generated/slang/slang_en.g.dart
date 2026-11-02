///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'slang.g.dart';

// Path: <root>
class TranslationsEn with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key);

	late final TranslationsEn _root = this; // ignore: unused_field

	@override 
	TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

	// Translations
	@override String get player => 'Player';
	@override String get start => 'Start';
	@override String get restart => 'Restart';
	@override String get mode => 'Mode';
	@override late final _Translations$settings$en settings = _Translations$settings$en._(_root);
}

// Path: settings
class _Translations$settings$en implements Translations$settings$ru {
	_Translations$settings$en._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Settings';
	@override String get select_mode => 'Select mode';
	@override String get selected_size => 'Selected size';
	@override String get language => 'Language';
	@override late final _Translations$settings$theme$en theme = _Translations$settings$theme$en._(_root);
	@override late final _Translations$settings$audio$en audio = _Translations$settings$audio$en._(_root);
	@override late final _Translations$settings$about$en about = _Translations$settings$about$en._(_root);
}

// Path: settings.theme
class _Translations$settings$theme$en implements Translations$settings$theme$ru {
	_Translations$settings$theme$en._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Theme';
	@override String get system => 'Auto';
	@override String get light => 'Light';
	@override String get dark => 'Dark';
}

// Path: settings.audio
class _Translations$settings$audio$en implements Translations$settings$audio$ru {
	_Translations$settings$audio$en._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sound & Haptics';
	@override late final _Translations$settings$audio$sound$en sound = _Translations$settings$audio$sound$en._(_root);
	@override late final _Translations$settings$audio$vibration$en vibration = _Translations$settings$audio$vibration$en._(_root);
}

// Path: settings.about
class _Translations$settings$about$en implements Translations$settings$about$ru {
	_Translations$settings$about$en._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'About';
	@override String get version => 'Version 1.0.0';
}

// Path: settings.audio.sound
class _Translations$settings$audio$sound$en implements Translations$settings$audio$sound$ru {
	_Translations$settings$audio$sound$en._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sound Effects';
	@override String get subtitle => 'Move and victory sounds';
}

// Path: settings.audio.vibration
class _Translations$settings$audio$vibration$en implements Translations$settings$audio$vibration$ru {
	_Translations$settings$audio$vibration$en._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vibration';
	@override String get subtitle => 'Haptic feedback on tap';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'player' => 'Player',
			'start' => 'Start',
			'restart' => 'Restart',
			'mode' => 'Mode',
			'settings.title' => 'Settings',
			'settings.select_mode' => 'Select mode',
			'settings.selected_size' => 'Selected size',
			'settings.language' => 'Language',
			'settings.theme.title' => 'Theme',
			'settings.theme.system' => 'Auto',
			'settings.theme.light' => 'Light',
			'settings.theme.dark' => 'Dark',
			'settings.audio.title' => 'Sound & Haptics',
			'settings.audio.sound.title' => 'Sound Effects',
			'settings.audio.sound.subtitle' => 'Move and victory sounds',
			'settings.audio.vibration.title' => 'Vibration',
			'settings.audio.vibration.subtitle' => 'Haptic feedback on tap',
			'settings.about.title' => 'About',
			'settings.about.version' => 'Version 1.0.0',
			_ => null,
		};
	}
}
