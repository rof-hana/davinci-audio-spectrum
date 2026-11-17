# DaVinci Resolve Audio Spectrum Analyzer (Fuse + Edit Templates)

DaVinci Resolve（**無料版 / Studio版 両対応**、Windows / macOS / Linux 対応）用の本格的な **FFTオーディオスペクトラムアナライザー（スペアナ）プラグイン** です。  
エディットページの **エフェクト**・**ジェネレーター**、および **Fusionページ** のいずれからでも利用できます。

---

## 主な機能

- **純正Luaベースの高精度FFT解析**（外部DLL・Python・有料版Studio不要）
  - Radix-2 Cooley-Tukey FFT（`1024` / `2048` / `4096` / `8192` ポイント選択可）
  - 窓関数：`Hann` / `Hamming` / `Blackman-Harris`
  - 周波数スケール：**対数（Logarithmic）** / **線形（Linear）**
  - バンド数：`8` 〜 `128` バンド
  - 低域のサブビン補間 ＋ 高域の RMS/Peak ブレンド ＋ チルト補正（`Tilt Slope dB/oct`）
- **大容量WAVも安全に扱うストリーミング読み込み**
  - フレーム毎に必要なサンプル窓だけをシーク読み込みするため、長尺WAVでもメモリ消費が少なく、再生・ファイルロック問題を防ぎます。
  - 対応WAV形式：PCM（8 / 16 / 24 / 32-bit LE）、IEEE Float（32 / 64-bit LE）、`WAVE_FORMAT_EXTENSIBLE`、`RF64`
- **スクラブ（任意フレーム移動）対応のスムージング & ピークホールド**
  - `Attack Smoothing`、`Release Decay`、`Peak Hold Caps` を装備し、タイムラインをランダムシークしても破綻しない決定論的計算を採用しています。
- **6種類のビジュアルスタイル**
  1. `Bars`（縦棒グラフ）
  2. `Segmented LED`（LEDセグメント風メーター）
  3. `Line Curve`（Catmull-Romスプラインによる滑らかな波形ライン）
  4. `Filled Area`（塗りつぶしエリア付きスペクトラム）
  5. `Circular Bars`（円形・放射状バー）
  6. `Circular Line`（円形・放射状ライン）
  - いずれも **Mirror Mode（上下・内外対称表示）** に対応。
- **4種類のカラーモード & エフェクト**
  - `Solid Color`（単色）
  - `Frequency Gradient`（低域・中域・高域の3色グラデーション）
  - `Level Meter (G/Y/R)`（緑→黄→赤のレベル連動カラー）
  - `Rainbow`（レインボー）
  - **ネオン発光（`Neon Halo Intensity`）**、**グリッド/基準線表示**、**背景カラー・透明度**、**入力映像への合成ON/OFF**

---

## ファイル構成

- `AudioSpectrumAnalyzer.fuse` — Fusion Fuseプラグイン本体
- `AudioSpectrumAnalyzer.drfx` — エディットページ用テンプレートバンドル（Effect & Generator）
- `drfx_src/Edit/Effects/Audio Spectrum Analyzer.setting` — エディットページ「エフェクト」テンプレート
- `drfx_src/Edit/Generators/Audio Spectrum Analyzer.setting` — エディットページ「ジェネレーター」テンプレート
- `install_windows.bat` — Windows用一括インストーラー
- `install_mac_linux.sh` — macOS / Linux用一括インストーラー

> [!IMPORTANT]
> DaVinci Resolveの仕様上、`.drfx` ファイルのダブルクリックだけでは `.fuse` 本体は自動インストールされません。必ず **`AudioSpectrumAnalyzer.fuse` を `Fuses` フォルダへ配置** してください（付属のインストールスクリプトを使えば両方まとめて配置されます）。

---

## インストール方法

### 方法A：付属スクリプトで一括インストール（推奨）

#### Windows
1. DaVinci Resolve を終了します。
2. `install_windows.bat` をダブルクリック（またはコマンドプロンプトから実行）します。
3. DaVinci Resolve を起動します。

#### macOS / Linux
```bash
chmod +x install_mac_linux.sh
./install_mac_linux.sh
```
実行後、DaVinci Resolve を起動（または再起動）してください。

---

### 方法B：手動インストール

1. **`AudioSpectrumAnalyzer.fuse`** を以下の `Fuses` フォルダにコピーします（フォルダが無ければ作成してください）。
   - **Windows**: `%APPDATA%\Blackmagic Design\DaVinci Resolve\Support\Fusion\Fuses\`
   - **macOS**: `~/Library/Application Support/Blackmagic Design/DaVinci Resolve/Fusion/Fuses/`
   - **Linux**: `~/.local/share/DaVinciResolve/Fusion/Fuses/`

2. **`AudioSpectrumAnalyzer.drfx`** をダブルクリックして Resolve にインストールします（または `drfx_src/Edit/.../*.setting` を `Fusion/Templates/Edit/Effects/` と `Generators/` へコピーします）。

3. DaVinci Resolve を再起動します。

---

## 使い方

> [!NOTE]
> DaVinci Resolve のプラグインAPI（OpenFX / Fusion Fuse）はタイムライン上の再生音声バッファを映像エフェクトへ直接渡す仕組みを持たないため、スペアナで解析したい音声ファイル（`.wav`）をインスペクタの **Audio File (WAV)** から指定して使用します。

### 1. エディットページで使う（ジェネレーターとして）
背景映像の上にそのままスペアナだけを重ねたい場合に最適です。
1. エフェクトライブラリ ＞ **ツールボックス ＞ ジェネレーター ＞ Audio Spectrum Analyzer** をビデオトラック（V2など）にドラッグ＆ドロップします。
2. クリップを選択し、右上の **インスペクタ ＞ ジェネレーター** タブを開きます。
3. **Audio File (WAV)** の「参照（Browse）」ボタンから `.wav` ファイルを選択します。
4. 必要に応じて **Visual Style**・**Color Mode**・**Layout** などを調整します。

### 2. エディットページで使う（エフェクトとして）
既存の映像クリップや「調整クリップ」に直接適用したい場合に使います。
1. エフェクトライブラリ ＞ **ツールボックス ＞ エフェクト ＞ Audio Spectrum Analyzer** を映像クリップまたは調整クリップにドラッグします。
2. **インスペクタ ＞ エフェクト** から `.wav` ファイルを指定します。
3. **Composite Over Input** が ON の場合は元映像に合成、OFF の場合は透過背景にスペアナのみを出力します。

### 3. Fusionページで使う
1. Fusionノードエディタで `Shift + Space` を押し、`Audio Spectrum Analyzer`（カテゴリ：`Audio`）を追加します。
2. 映像に合成する場合は元映像を黄色の `Input` ピンに接続します（未接続の場合はコンポジションの解像度で透過出力されます）。

---

## タイムライン音声との同期・WAV準備のヒント

- **フレームレート同期（`Auto Timeline FPS`）**:
  初期状態で ON になっており、タイムラインの FPS（24 / 29.97 / 30 / 60fps など）を自動取得します。手動指定したい場合は `Auto Timeline FPS` を OFF にして `Timeline FPS` を調整してください。
- **開始位置のズレ調整（`Audio Offset (sec)`）**:
  クリップの途中から音声が始まる場合やタイミングを微調整したい場合は、`Audio Offset (sec)` で秒単位にシフトできます（例：音声がクリップより2秒遅れて始まる場合は `-2.0`）。
- **MP3 / AAC / M4A しかない場合**:
  DaVinci Resolve（フェアライト等）で WAV 書き出しするか、`ffmpeg` 等で変換してください：
  ```bash
  ffmpeg -i input.mp3 -acodec pcm_s16le -ar 48000 output.wav
  ```

---

## パラメータ概要

| タブ | 主なパラメータ | 説明 |
|---|---|---|
| **Spectrum** | `Audio File (WAV)` | 解析対象のWAVファイル |
| | `Audio Channel` | `Mix (L+R)` / `Left` / `Right` |
| | `Auto Timeline FPS` / `Timeline FPS` | プロジェクトFPSの自動検出 / 手動設定 |
| | `Audio Offset (sec)` | 音声同期オフセット（秒） |
| | `Display Options` | `Digital` / `Analog Lines` / `Analog Dots` / `Segmented LED` / `Filled Area` / `Circular Bars` / `Circular Line` |
| | `Side Options` | `Side A`（上/外側）/ `Side B`（下/内側）/ `Side A & B`（両側対称） |
| | `Frequency Bands` / `Peak Hold Caps` | バンド数（8〜128）、ピークキャップ表示 |
| **Analysis** | `FFT Size` / `Window Function` | FFT分解能と窓関数 |
| | `Frequency Scale` / `Start Freq` / `End Freq` | 対数・線形スケールと開始・終了周波数（Hz） |
| | `Gain (dB)` / `Noise Floor (dB)` / `Tilt Slope` | 感度・下限ノイズフロア・高域傾き補正 |
| | `Attack Smoothing` / `Release Decay` / `Peak Fall Speed` | 立ち上がり・減衰の滑らかさ、ピーク落下速度 |
| **Layout** | `Placement Mode` / `Start Point` / `End Point` | AE式の2点ドラッグ配置（斜め可）または `Center & Size` |
| | `Maximum Height` / `Bar Spacing` / `Thickness` / `Round Bar Caps` | 最大高さ、バー間隔、太さ、丸角キャップ |
| | `Circular Inner Radius` / `Rotation` / `Arc Sweep` | 円形スタイルの内径・回転・扇形角度（30°〜360°） |
| | `Show Grid & Baseline` / `Composite Over Input` / `Bg Color` | 補助グリッド、元映像への合成、背景ティント |
| **Color** | `Color Mode` | `AE Inside / Outside` / `Frequency Gradient` / `Level Meter` / `Rainbow` |
| | `Inside / Outside / Mid / Peak Cap Color` | 芯・外側グロー・中間色・ピークキャップの配色 |
| | `Hue Interpolation (deg)` / `Softness (AE Glow)` | 色相補間回転、AE風の柔らかい発光（Softness） |
| | `LED Segments` / `Spectrum Opacity` | LED分割数、全体の不透明度 |
