# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Configuration Structure

This is a WezTerm terminal emulator configuration written in Lua. The configuration is split into two main files:

- **wezterm.lua**: Main configuration file that defines visual settings (font, colors, opacity, tab styling), cursor behavior, and imports keybindings from the separate module
- **keybinds.lua**: Modular keybinding configuration that exports a table with `keys` and `key_tables` arrays

### Configuration Loading Pattern

The main config file uses `require("keybinds")` to load the keybindings module and assigns them to the config:

```lua
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
```

### Leader Key System

The configuration uses a tmux-style leader key pattern (`Ctrl+f` with 3-second timeout). Many keybindings are prefixed with `LEADER` modifier, requiring the leader key to be pressed first.

### Key Tables

WezTerm's key tables feature is used extensively for modal interactions:

- **resize_pane**: Activated with `Leader+s`, allows continuous pane resizing with hjkl until Enter is pressed
- **activate_pane**: Activated with `Leader+a`, provides a 1-second window for quick pane navigation
- **copy_mode**: Activated with `Leader+[`, provides vim-like text selection and navigation
- **search_mode**: Pattern matching within copy mode

## Testing Configuration Changes

To test changes to the configuration:

```bash
# WezTerm automatically reloads when config files change (automatically_reload_config = true)
# Or manually reload with: Ctrl+Shift+r

# Validate configuration syntax before applying
wezterm show-config
```

## Visual Customization

The config uses custom event handlers for UI customization:

- `format-tab-title`: Customizes tab appearance with background/foreground colors based on active state
- `update-right-status`: Shows active key table name in the status area (e.g., "TABLE: resize_pane")

## Japanese Language Support

The configuration includes `config.use_ime = true` to support Japanese input methods on macOS.

## Shortcut Keymap

```
モード,キー,修飾キー,動作・説明
Normal,¥,Alt,\ (バックスラッシュ) を入力
Normal,q,Super,アプリケーション終了 (Quit)
Normal,Enter,Alt,フルスクリーン切り替え
Normal,n,Super,新しいウィンドウを開く
Normal,Tab,Ctrl,次のタブへ移動 (+1)
Normal,Tab,Shift + Ctrl,前のタブへ移動 (-1)
Normal,1 〜 8,Super,指定番号のタブを表示
Normal,9,Super,右端のタブを表示
Normal,t,Super,新しいタブを作成
Normal,w,Super,現在のタブを閉じる (確認あり)
Normal,Backspace,Shift,左のペインに移動
Normal,l,Shift + Ctrl,右のペインに移動
Normal,k,Shift + Ctrl,上のペインに移動
Normal,j,Shift + Ctrl,下のペインに移動
Normal,+,Super,フォントサイズ拡大
Normal,-,Super,フォントサイズ縮小
Normal,0,Super,フォントサイズリセット
Normal,c,Super,クリップボードへコピー
Normal,v,Super,クリップボードからペースト
Normal,C,Ctrl,クリップボードへコピー
Normal,Copy,(なし),クリップボードへコピー
Normal,Paste,(なし),クリップボードからペースト
Normal,l,Super,デバッグオーバーレイを表示
Normal,R,Ctrl,設定リロード
Normal,r,Super,設定リロード
Normal,P,Ctrl,コマンドパレットを開く
Normal,U,Ctrl,文字選択ツール (CharSelect)
Normal,Z,Ctrl,アクティブペインのズーム (最大化/復元)
Normal,Space,Super,Quick Select モード開始
Normal,PageUp,Shift,1ページ スクロールアップ
Normal,PageDown,Shift,1ページ スクロールダウン
Normal,p,Alt + Ctrl,0.5ページ スクロールアップ
Normal,n,Alt + Ctrl,0.5ページ スクロールダウン
Normal,Enter,Shift,改行コード送信 (Claude Code等対策)
Normal,[,Alt,前のプロンプトへスクロール
Normal,],Alt,次のプロンプトへスクロール
Normal,f,Super,検索モード開始 (Search)
Normal,X,Ctrl,コピーモード開始
Leader,r,Ctrl + q,ペインを横に分割
Leader,d,Ctrl + q,ペインを縦に分割
Leader,x,Ctrl + q,現在のペインを閉じる (確認あり)
Leader,a,Ctrl + q,画面内のARNを選択してAWSコンソールを開く
Leader,s,Ctrl + q,設定モード (Setting Mode) へ移行
Leader,z,Ctrl + q,直前のコマンドと出力をコピー
Leader,b,Ctrl + q,現在のバッファを色付きでNeovimで開く
Copy Mode,c,Ctrl,コピーモード終了
Copy Mode,q,(なし),コピーモード終了
Copy Mode,Esc,(なし),コピーモード終了
Copy Mode,h,(なし),カーソル左移動
Copy Mode,j,(なし),カーソル下移動
Copy Mode,k,(なし),カーソル上移動
Copy Mode,l,(なし),カーソル右移動
Copy Mode,0,(なし),行頭へ移動
Copy Mode,^,(なし),行頭 (コンテンツ開始位置) へ移動
Copy Mode,$,(なし),行末へ移動
Copy Mode,",",(なし),直前のジャンプを逆方向に繰り返し
Copy Mode,;,(なし),直前のジャンプを繰り返し
Copy Mode,g,(なし),スクロールバックの先頭へ
Copy Mode,G,(なし),スクロールバックの末尾へ
Copy Mode,w,(なし),次の単語へ移動
Copy Mode,e,(なし),単語の末尾へ移動
Copy Mode,b,(なし),前の単語へ移動
Copy Mode,t,(なし),指定文字の手前へジャンプ (前方)
Copy Mode,f,(なし),指定文字へジャンプ (前方)
Copy Mode,T,(なし),指定文字の手前へジャンプ (後方)
Copy Mode,F,(なし),指定文字へジャンプ (後方)
Copy Mode,H,(なし),画面 (Viewport) 最上部へ
Copy Mode,L,(なし),画面 (Viewport) 最下部へ
Copy Mode,M,(なし),画面 (Viewport) 中央へ
Copy Mode,O,(なし),選択範囲の反対側の端へ移動 (水平)
Copy Mode,o,(なし),選択範囲の反対側の端へ移動
Copy Mode,m,Alt,行頭 (コンテンツ) へ移動
Copy Mode,b,Ctrl,1ページアップ
Copy Mode,f,Ctrl,1ページダウン
Copy Mode,u,Ctrl,0.5ページアップ
Copy Mode,d,Ctrl,0.5ページダウン
Copy Mode,v,(なし),文字選択モード開始
Copy Mode,v,Ctrl,矩形 (Block) 選択モード開始
Copy Mode,V,(なし),行選択モード開始
Copy Mode,y,(なし),選択範囲をコピー
Copy Mode,p,Alt + Ctrl,1ページアップ
Copy Mode,n,Alt + Ctrl,1ページダウン
Copy Mode,n,Ctrl,次の検索一致箇所へ
Copy Mode,p,Ctrl,前の検索一致箇所へ
Copy Mode,/,(なし),検索モードへ
Copy Mode,[,Alt,前のプロンプトへスクロール
Copy Mode,],Alt,次のプロンプトへスクロール
Copy Mode,[,(なし),前の入力ゾーン (Input/Output) へ移動
Copy Mode,],(なし),次の入力ゾーン (Input/Output) へ移動
Copy Mode,z,(なし),セマンティックゾーン選択 (現在の領域を選択)
Search Mode,Esc,(なし),モード終了
Search Mode,n,Ctrl,次へ移動 & コピーモードへ
Search Mode,p,Ctrl,前へ移動 & コピーモードへ
Search Mode,r,Ctrl,検索タイプ切替 (Case sensitive等)
Search Mode,u,Ctrl,入力パターンをクリア
Search Mode,X,Ctrl,コピーモードへ移行 (パターン維持)
Setting Mode,h,(なし),ペイン幅を1セル縮小
Setting Mode,l,(なし),ペイン幅を1セル拡大
Setting Mode,k,(なし),ペイン高さを1セル縮小
Setting Mode,j,(なし),ペイン高さを1セル拡大
Setting Mode,1 〜 9,(なし),ペインの高さを 10%〜90% に設定
Setting Mode,1 〜 9,Ctrl,ペインの幅を 10%〜90% に設定
Setting Mode,Esc,(なし),モード終了
Setting Mode,q,(なし),モード終了
Setting Mode,c,Ctrl,モード終了
```
