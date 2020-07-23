# Example

To use KanaKit, construct a `KanaKit` class instance.
It contains all available methods for detecting and converting Japanese text.

```dart
// Create a KanaKit instance.
//
// You can optionally provide a config of type KanaKitConfig.
// If no config is provided, KanaKitConfig.defaultConfig is used.
const kanaKit = KanaKit();

// Checks
kanaKit.isJapanese('泣き虫。！～２￥ｚｅｎｋａｋｕ') // true

kanaKit.isKana('あーア') // true

kanaKit.isHiragana('すげー') // true

kanaKit.isKatakana('ゲーム') // true

kanaKit.isKanji('切腹') // true
kanaKit.isKanji('勢い') // false

kanaKit.isRomaji('Tōkyō and Ōsaka') // true

// Converters
kanaKit.toKana('ONAJI buttsuuji') // 'オナジ ぶっつうじ'
kanaKit.toKana('座禅‘zazen’スタイル') // '座禅「ざぜん」スタイル'
kanaKit.toKana('batsuge-mu') // 'ばつげーむ'

kanaKit.toHiragana('toukyou, オオサカ') // 'とうきょう、　おおさか'
kanaKit.toKatakana('toukyou, おおさか') // 'トウキョウ、　オオサカ'

kanaKit.toRomaji('ひらがな　カタカナ') // 'hiragana katakana'

// Use upcaseKatakana to capitalize characters that were converted from Katakana.s
kanaKit
  .copyWithConfig(upcaseKatakana: true)
  .toRomaji('ひらがな　カタカナ') // 'hiragana KATAKANA'
```
