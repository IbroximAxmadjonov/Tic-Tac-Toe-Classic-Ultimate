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
class TranslationsUz with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsUz({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.uz,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <uz>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key);

	late final TranslationsUz _root = this; // ignore: unused_field

	@override 
	TranslationsUz $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsUz(meta: meta ?? this.$meta);

	// Translations
	@override String get player => 'O\'yinchi';
	@override String get start => 'Boshlash';
	@override String get restart => 'Qayta boshlash';
	@override String get mode => 'Rejim';
	@override late final _Translations$settings$uz settings = _Translations$settings$uz._(_root);
}

// Path: settings
class _Translations$settings$uz implements Translations$settings$ru {
	_Translations$settings$uz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sozlamalar';
	@override String get select_mode => 'Rejimni tanlang';
	@override String get selected_size => 'Tanlangan o\'lcham';
	@override String get language => 'Til';
	@override late final _Translations$settings$theme$uz theme = _Translations$settings$theme$uz._(_root);
	@override late final _Translations$settings$audio$uz audio = _Translations$settings$audio$uz._(_root);
	@override late final _Translations$settings$about$uz about = _Translations$settings$about$uz._(_root);
}

// Path: settings.theme
class _Translations$settings$theme$uz implements Translations$settings$theme$ru {
	_Translations$settings$theme$uz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mavzu';
	@override String get system => 'Avto';
	@override String get light => 'Yorug\'';
	@override String get dark => 'Qorong\'i';
}

// Path: settings.audio
class _Translations$settings$audio$uz implements Translations$settings$audio$ru {
	_Translations$settings$audio$uz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ovoz va tebranish';
	@override late final _Translations$settings$audio$sound$uz sound = _Translations$settings$audio$sound$uz._(_root);
	@override late final _Translations$settings$audio$vibration$uz vibration = _Translations$settings$audio$vibration$uz._(_root);
}

// Path: settings.about
class _Translations$settings$about$uz implements Translations$settings$about$ru {
	_Translations$settings$about$uz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'O\'yin haqida';
	@override String get version => 'Versiya 1.0.0';
}

// Path: settings.audio.sound
class _Translations$settings$audio$sound$uz implements Translations$settings$audio$sound$ru {
	_Translations$settings$audio$sound$uz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ovoz effektlari';
	@override String get subtitle => 'Yurish va g\'alaba tovushlari';
}

// Path: settings.audio.vibration
class _Translations$settings$audio$vibration$uz implements Translations$settings$audio$vibration$ru {
	_Translations$settings$audio$vibration$uz._(this._root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tebranish';
	@override String get subtitle => 'Bosganda tebranish signali';
}

/// The flat map containing all translations for locale <uz>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsUz {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'player' => 'O\'yinchi',
			'start' => 'Boshlash',
			'restart' => 'Qayta boshlash',
			'mode' => 'Rejim',
			'settings.title' => 'Sozlamalar',
			'settings.select_mode' => 'Rejimni tanlang',
			'settings.selected_size' => 'Tanlangan o\'lcham',
			'settings.language' => 'Til',
			'settings.theme.title' => 'Mavzu',
			'settings.theme.system' => 'Avto',
			'settings.theme.light' => 'Yorug\'',
			'settings.theme.dark' => 'Qorong\'i',
			'settings.audio.title' => 'Ovoz va tebranish',
			'settings.audio.sound.title' => 'Ovoz effektlari',
			'settings.audio.sound.subtitle' => 'Yurish va g\'alaba tovushlari',
			'settings.audio.vibration.title' => 'Tebranish',
			'settings.audio.vibration.subtitle' => 'Bosganda tebranish signali',
			'settings.about.title' => 'O\'yin haqida',
			'settings.about.version' => 'Versiya 1.0.0',
			_ => null,
		};
	}
}
