///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'slang.g.dart';

// Path: <root>
typedef TranslationsRu = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// ru: 'Игрок'
	String get player => 'Игрок';

	/// ru: 'Начать'
	String get start => 'Начать';

	/// ru: 'Заново'
	String get restart => 'Заново';

	/// ru: 'Режим'
	String get mode => 'Режим';

	late final Translations$settings$ru settings = Translations$settings$ru._(_root);
}

// Path: settings
class Translations$settings$ru {
	Translations$settings$ru._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Найстройки'
	String get title => 'Найстройки';

	/// ru: 'Выберите режима'
	String get select_mode => 'Выберите режима';

	/// ru: 'Выбранный размер'
	String get selected_size => 'Выбранный размер';

	/// ru: 'Язык'
	String get language => 'Язык';

	late final Translations$settings$theme$ru theme = Translations$settings$theme$ru._(_root);
	late final Translations$settings$audio$ru audio = Translations$settings$audio$ru._(_root);
	late final Translations$settings$about$ru about = Translations$settings$about$ru._(_root);
}

// Path: settings.theme
class Translations$settings$theme$ru {
	Translations$settings$theme$ru._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Тема оформления'
	String get title => 'Тема оформления';

	/// ru: 'Авто'
	String get system => 'Авто';

	/// ru: 'Светлая'
	String get light => 'Светлая';

	/// ru: 'Тёмная'
	String get dark => 'Тёмная';
}

// Path: settings.audio
class Translations$settings$audio$ru {
	Translations$settings$audio$ru._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Звук и вибрация'
	String get title => 'Звук и вибрация';

	late final Translations$settings$audio$sound$ru sound = Translations$settings$audio$sound$ru._(_root);
	late final Translations$settings$audio$vibration$ru vibration = Translations$settings$audio$vibration$ru._(_root);
}

// Path: settings.about
class Translations$settings$about$ru {
	Translations$settings$about$ru._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Об игре'
	String get title => 'Об игре';

	/// ru: 'Версия 1.0.0'
	String get version => 'Версия 1.0.0';
}

// Path: settings.audio.sound
class Translations$settings$audio$sound$ru {
	Translations$settings$audio$sound$ru._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Звуковые эффекты'
	String get title => 'Звуковые эффекты';

	/// ru: 'Звуки ходов и победы'
	String get subtitle => 'Звуки ходов и победы';
}

// Path: settings.audio.vibration
class Translations$settings$audio$vibration$ru {
	Translations$settings$audio$vibration$ru._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ru: 'Вибрация'
	String get title => 'Вибрация';

	/// ru: 'Тактильный отклик при нажатиях'
	String get subtitle => 'Тактильный отклик при нажатиях';
}

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'player' => 'Игрок',
			'start' => 'Начать',
			'restart' => 'Заново',
			'mode' => 'Режим',
			'settings.title' => 'Найстройки',
			'settings.select_mode' => 'Выберите режима',
			'settings.selected_size' => 'Выбранный размер',
			'settings.language' => 'Язык',
			'settings.theme.title' => 'Тема оформления',
			'settings.theme.system' => 'Авто',
			'settings.theme.light' => 'Светлая',
			'settings.theme.dark' => 'Тёмная',
			'settings.audio.title' => 'Звук и вибрация',
			'settings.audio.sound.title' => 'Звуковые эффекты',
			'settings.audio.sound.subtitle' => 'Звуки ходов и победы',
			'settings.audio.vibration.title' => 'Вибрация',
			'settings.audio.vibration.subtitle' => 'Тактильный отклик при нажатиях',
			'settings.about.title' => 'Об игре',
			'settings.about.version' => 'Версия 1.0.0',
			_ => null,
		};
	}
}
