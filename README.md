# キャプチャ撮って、画像比較するツールを作ってみた。


## 実演
キャプチャを撮る


```sh
$ casperjs --ssl-protocol=tlsv1 --disk-cache=false screenshot.js <url> <dir>
```
SSLのページには `--ssl-protocol=tlsv1` オプションが必要（これはphantomjsのオプション）  
キャッシュを読みに行ってしまうのを防ぐ `--disk-cache=false`

> 基礎知識 SSL/TLSの仕組み SSL（Secure Socket Layer）とは、インターネット上でデータを暗号化して送受信する方法のひとつで、Netscape Communications社が開発しました。 TLS（Transport Layer Security）は、SSLをもとに標準化させたものです。


画像比較をする

```sh
$ gulp compare
```

撮った画像を全て削除

```sh
$ gulp cleanDeep
```

## コードリーディング

* screenshot.js
* pages.json
* gulpfile.coffee



### メリット
* 目視では限界がある細かい違いをあぶり出すことができる。
* 文言の修正、画像の差し替えなど
* 大量のページをQAする

### デメリット
* 大幅にレイアウトが変わったページは全体が差分になってしまう
* 一行文の差分によって、それ以降が差分になってしまう。

### 補足
* 汎用的にはなってません。
* マーケットでデグレが起こった
* Windows版も作ってコンフルにアップ
* 最近だと[nightmare.js](http://www.nightmarejs.org/)のほうがナウい？

## 必要なもの

 * [PhantomJS](http://phantomjs.org/)
  (brewで入れると最新版？が入ってしまう。Yosemite OS 10.10.1 と相性が悪いので `v1.9.7` を入れる)    

> PhantomJSとは、Scriptable Headless WebKitと説明されており、WebKitベースのブラウザです。 WebKitはただのレンダリングエンジン。

> ヘッドレスブラウザというのはGUIのないブラウザのことで、GUIの描画処理を行わない分、通常のブラウザに比べて高速に動作するという特徴があります。そのため、時間が掛かりがちなWebアプリケーションのGUIテストを高速化するためのソリューションとして注目されています。また、マルチプラットフォームであり、CUIのみのOSでもGUIテストを行えるという利点もあります。


 * [Casperjs](http://casperjs.org/) (最新 `v1.1.-beta3` recommended)
 `$ brew install casperjs --devel`  
 
> CasperJSは、JavaScriptで実装されたPhantomJSのユーティリティです。ざっくり以下のことができます。

>
* ブラウザのナビゲーションステップを順に定義できる
* フォーム入力
* リンクのクリック
* ページのスクリーンショット（画面の一部分だけもOK）
* リモートDOMのテスト
* イベントのロギング
* バイナリを含んだリソースのダウンロード
* テストスイート（結果をJUnitXMLで出力）
* Webコンテンツをスクレイピング
 
 * [imagemagick](http://www.imagemagick.org/script/index.php)
 * [graphicsmagick](http://www.graphicsmagick.org/)
 * nodejs (gulp)


## 参考
* [CasperJSで複数ページのスクリーンショットを撮る - Qiita](http://qiita.com/watarumohawk/items/3b121a80031e8cc29e7e)
* [CasperJSで画面キャプチャをとる | Siguniang's Blog](https://siguniang.wordpress.com/2013/07/18/capturing-screenshots-with-casperjs/)
* [[デザイナー向け] GulpとGraphicsMagickで校正途中のPDFを差分比較する。マルチページ・マルチファイル対応 - Qiita](http://qiita.com/y_hokkey/items/417e108e212210b4e635)
* [nightmare.jsとgmを使ってnode.jsでLIGブログの更新をSlackでゲットだぜ | 株式会社LIG](http://liginc.co.jp/web/programming/node-js/139045)
* [Nightmare.js+GraphicsMagickでサイト全体の描画テストを行う。](http://blog.yudppp.com/nightmare-gm/)
