<div align="center">
  <h1>KanaKit (かな・キット)</h1>
  <h4>A Dart library for for detecting and transliterating Hiragana, Katakana, and Romaji.</h4>
</div>

<div align="center">
  <a href="https://pub.dev/packages/kana_kit"
    ><img alt="Pub Version" src="https://img.shields.io/pub/v/kana_kit?logo=dart"
  /></a>
  <a href="https://codecov.io/gh/jeroen-meijer/kana_kit"
    ><img
      alt="Codecov"
      src="https://img.shields.io/codecov/c/github/jeroen-meijer/kana_kit?logo=codecov"
  /></a>
  <a
    href="https://github.com/jeroen-meijer/kana_kit/actions?query=workflow%3Aci"
  >
    <img
      alt="GitHub Workflow Status"
      src="https://img.shields.io/github/workflow/status/jeroen-meijer/kana_kit/ci?logo=github&label=ci"
    />
  </a>
  <a href="https://github.com/jeroen-meijer/kana_kit/commits/"
    ><img
      alt="GitHub last commit"
      src="https://img.shields.io/github/last-commit/jeroen-meijer/kana_kit?logo=github"
  /></a>
  <br />
  <a href="https://github.com/jeroen-meijer/kana_kit">
    <img
      alt="GitHub stars"
      src="https://img.shields.io/github/stars/jeroen-meijer/kana_kit.svg?logo=github&colorB=deeppink&label=stars"
    />
  </a>
  <a href="https://github.com/jeroen-meijer/kana_kit/issues">
    <img
      alt="GitHub issues"
      src="https://img.shields.io/github/issues/jeroen-meijer/kana_kit?logo=github"
    />
  </a>
  <a href="https://github.com/tenhobi/effective_dart">
    <img
      alt="style: effective dart"
      src="https://img.shields.io/badge/style-effective_dart-40c4ff.svg?logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJMYXllcl8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIgdmlld0JveD0iMCAwIDUxMiA1MTIiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDUxMiA1MTI7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4KCTxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+Cgkuc3Qwe2ZpbGw6I2ZmZmZmZjt9Cjwvc3R5bGU+Cgk8Zz4KCQk8cGF0aCBjbGFzcz0ic3QwIiBkPSJNMTI2LjUsMTAyLjFMMCwyNTZsMTI2LjUsMTUzLjlsMjkuOS00OS4yTDcxLjIsMjU2bDg1LjItMTA0LjdMMTI2LjUsMTAyLjF6IE0xODEuOCw0MDYuMmg1NS41bDg4LjItMzAxLjMKCQloLTU1LjVMMTgxLjgsNDA2LjJ6IE0zODUuNSwxMDIuMWwtMjkuOSw0OS4yTDQ0MC44LDI1NmwtODUuMiwxMDQuN2wyOS45LDQ5LjJMNTEyLDI1NkwzODUuNSwxMDIuMXoiIC8+Cgk8L2c+Cjwvc3ZnPgo="
    />
  </a>
  <a href="https://pub.dev/documentation/kana_kit/latest/">
    <img
      alt="Documentation"
      src="https://img.shields.io/badge/read-the%20docs-blue?logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA1MTIgNTEyIj48cGF0aCBkPSJNMjU0LjggMTM0LjdTMTg1LjEgNTkuMSAwIDU5LjF2MzE1LjFjMTg1LjEgMCAyNTQuOCA3OC44IDI1NC44IDc4LjhzNzIuMS03OC44IDI1Ny4yLTc4LjhWNTkuMWMtMTg1LjEgMC0yNTcuMiA3NS42LTI1Ny4yIDc1LjZ6bTIxNy44IDIwMC4xYy03Ny4zIDEuOS0xNTIuNSAyNC44LTIxNy44IDY2LjItNjQuNC00MS41LTEzOC45LTY0LjQtMjE1LjQtNjYuMlY5OC41YzEzMy45IDEwLjIgMTg2LjMgNjMgMTg3LjEgNjMuNGwyOC44IDI5LjIgMjguNC0yOS41czU1LjEtNTIuOCAxODktNjN2MjM2LjJ6bS0xOTYuOSA5LjRsLTMuOS02LjdjNTEuMy0yMy4zIDEwNS43LTM5IDE2MS41LTQ2LjV2Ny45Yy01NC41IDcuNy0xMDcuNiAyMy40LTE1Ny41IDQ2LjV2LTEuMnptMC0zOS40bC0zLjktNi43YzUxLjMtMjMuMiAxMDUuNy0zOC44IDE2MS41LTQ2LjF2Ny45Yy01NC41IDcuOC0xMDcuNiAyMy42LTE1Ny41IDQ2Ljl2LTJ6bTAtMzkuM2wtMy45LTYuN2M1MS4zLTIzLjIgMTA1LjctMzguOCAxNjEuNS00Ni4xdjcuOWMtNTQuNSA3LjgtMTA3LjYgMjMuNi0xNTcuNSA0Ni45di0yem0wLTM5LjRsLTMuOS02LjdjNTEuMy0yMy4zIDEwNS43LTM4LjggMTYxLjUtNDYuMXY3LjljLTU0LjUgNy44LTEwNy42IDIzLjYtMTU3LjUgNDYuOXYtMnptLTQzLjMgMTE4LjFjLTQ4LjctMjIuNy0xMDAuNC0zOC4xLTE1My42LTQ1Ljd2LTcuOWM1NC42IDggMTA3LjcgMjQuMiAxNTcuNSA0OC4xbC0zLjkgNS41em0wLTM5LjRjLTQ4LjctMjIuNC0xMDAuNS0zNy41LTE1My42LTQ0LjlWMjUyYzU0LjYgOCAxMDcuNyAyNC4xIDE1Ny41IDQ3LjdsLTMuOSA1LjF6bTAtMzkuM2MtNDguNy0yMi40LTEwMC41LTM3LjYtMTUzLjYtNDQuOXYtNy45YzU0LjYgNy44IDEwNy43IDIzLjkgMTU3LjUgNDcuN2wtMy45IDUuMXptMC0zOS40Yy00OC43LTIyLjQtMTAwLjUtMzcuNS0xNTMuNi00NC45di03LjljNTQuNiA4IDEwNy43IDI0IDE1Ny41IDQ3LjdsLTMuOSA1LjF6IiBmaWxsPSIjZmZmIi8+PC9zdmc+"
    />
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img
      alt="MIT License"
      src="https://img.shields.io/badge/License-MIT-blue.svg?label=license&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNTYiIGhlaWdodD0iMjU2Ij48cGF0aCBkPSJNMjQ1LjQ2NyAxMzQuNzgyYTExMy4xMzcgMTA5LjA5NiAwIDExMC0uMDAyIiB0cmFuc2Zvcm09Im1hdHJpeCgxLjA1NzIzIDAgMCAxLjA5MzAyIC0xMi4wNDEgLTE4LjgxNCkiIGZpbGw9IiNmZmYiIHN0cm9rZT0iIzAwMCIgc3Ryb2tlLXdpZHRoPSIxNS4zNDkiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIvPjxnIGZpbGw9Im5vbmUiIHN0cm9rZS13aWR0aD0iMTQuMTg4Ij48cGF0aCBkPSJNNTIuMjU1IDgzLjA5MXY5Mi4yMDZNODQuMDI5IDgzLjI5OXY2MC4yMjRNMTE1LjU5NSA4My4wOTFsLjIwOCA5MS45OThNMTQ3LjE2IDgzLjA5MWwuMjA5IDE5LjcyOU0xNzguOTM1IDExNC44NjVsLjIwNyA2MC40MzJNMTY5LjE3NCA5Mi44NTJsNTEuMjk1LjIwNyIgc3Ryb2tlPSIjOWMwMDAwIiBzdHJva2Utd2lkdGg9IjE2LjUwMDA3NjQ4Ii8+PHBhdGggZD0iTTE0Ny4zNjkgMTE0Ljg2NXY2MC4yMjQiIHN0cm9rZT0iIzdjN2Q3ZSIgc3Ryb2tlLXdpZHRoPSIxNi41MDAwNzY0OCIvPjwvZz48L3N2Zz4="
    />
  </a>
</div>

---

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

### LICENSE

MIT License

Copyright (c) 2024 Jeroen Meijer

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
