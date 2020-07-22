# KanaKit (カナ・キット)

A Dart library for for detecting and transliterating Hiragana, Katakana, and Romaji.

This library is mostly a direct port of [WaniKani's WanaKana JavaScript library](https://github.com/WaniKani/WanaKana).

## Usage

To use KanaKit, construct a `KanaKit` class instance.
It contains all available methods for detecting and converting Japanese text.

```dart
// Create a KanaKit instance.
//
// You can optionally provide a config of type KanaKitConfig.
// If no config is provided, KanaKitConfig.defaultConfig is used.
const kanaKit = KanaKit();

// String checks
kanaKit.isJapanese('泣き虫。！～２￥ｚｅｎｋａｋｕ') // true

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

// Use upcaseKatakana to capitalize characters that were converted from Katakana.s
final kanaKitWithUpcaseKatakana = kanaKit(
  upcaseKatakana: true,
);
kanaKitWithUpcaseKatakana.toRomaji('ひらがな　カタカナ') // 'hiragana KATAKANA'
```

### LICENSE

MIT License

Copyright (c) 2020 Jeroen Meijer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
