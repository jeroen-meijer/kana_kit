# KanaKit

A Dart library for for detecting and transliterating Hiragana, Katakana, and Romaji.

This library is mostly a direct port of [WaniKani's WanaKana JavaScript library](https://github.com/WaniKani/WanaKana).

## Usage

```dart
// Create a KanaKit instance.
// If no config is provided, KanaKitConfig.defaultConfig is used.
const kanaKit = KanaKit();

// String checks
kanaKit.isJapanese('泣き虫。！〜２￥ｚｅｎｋａｋｕ') // true

kanaKit.isKana('あーア') // true

kanaKit.isHiragana('すげー') // true

kanaKit.isKatakana('ゲーム') // true

kanaKit.isKanji('切腹') // true
kanaKit.isKanji('勢い') // false

kanaKit.isRomaji('Tōkyō and Ōsaka') // true

// String converters
kanaKit.toKana('ONAJI buttsuuji') // 'オナジ ぶっつうじ'
kanaKit.toKana('座禅‘zazen’スタイル') // '座禅「ざぜん」スタイル'
kanaKit.toKana('batsuge-mu') // 'ばつげーむ'

kanaKit.toHiragana('toukyou, オオサカ') // 'とうきょう、　おおさか'
kanaKit.toKatakana('toukyou, おおさか') // 'トウキョウ、　オオサカ'

kanaKit.toRomaji('ひらがな　カタカナ') // 'hiragana katakana'

// Use upcaseKatakana to 
final kanaKitWithUpcaseKatakana = kanaKit(
  upcaseKatakana: true,
);
kanaKitWithUpcaseKatakana.toRomaji('ひらがな　カタカナ') // 'hiragana KATAKANA'
```