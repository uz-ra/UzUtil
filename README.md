# UzUtil

iOS開発に便利なObjective-C/C++ユーティリティ集

## 📦 コンポーネント

### UzLog
シンプルなNSLogの拡張とちょっとだけ手間が省ける追加機能  
Simple NSLog extensions with additional features

**機能:**
- カスタムプレフィックスによるログフィルタリング
- ファイルへのログ出力
- タイムスタンプ付きログ
- クラス名の取得

- [English](./.github/UzLog-EN.md)
- [日本語](./.github/UzLog-JP.md)

---

### NearestViewController
FlexListとか使ってると出てくるNearestViewControllerを返すUIViewの拡張  
An extension of UIView that returns the NearestViewController

**機能:**
- UIViewから最も近いViewControllerを取得

- [English](./.github/NearestViewController-EN.md)
- [日本語](./.github/NearestViewController-JP.md)

---

### UzCapture
UIViewやUIWindowをUIImageにキャプチャするユーティリティ  
Utility to capture UIView or UIWindow as UIImage

**機能:**
- UIViewのキャプチャ
- UIWindow全体のキャプチャ

**使用例:**
```objective-c
#import "UzCapture.h"

// UIViewをキャプチャ
UIImage *viewImage = [UzCapture imageFromView:myView];

// UIWindow全体をキャプチャ
UIImage *windowImage = [UzCapture imageFromWindow:[UIApplication sharedApplication].keyWindow];
```

---

### UzFileManager
ファイル操作とデータ管理のヘルパー  
File operation and data management helper

**機能:**
- Bundle IDからデータディレクトリを取得
- Bundle IDからバンドルディレクトリを取得
- XMLファイルの特定キーの値を上書き
- JSONファイルの特定キーパスの値を上書き

**使用例:**
```objective-c
#import "UzFileManager.h"

// データディレクトリを取得
NSString *dataDir = [UzFileManager dataDirForBundleID:@"com.example.app"];

// バンドルディレクトリを取得
NSString *bundleDir = [UzFileManager bundleDirForBundleID:@"com.example.app"];

// XMLファイルの値を上書き
[UzFileManager overwriteXML:@"/path/to/file.xml" :@"someKey" :@"newValue"];

// JSONファイルの値を上書き
[UzFileManager overwriteJSON:@"/path/to/file.json" :@"user.name" :@"John"];
```

