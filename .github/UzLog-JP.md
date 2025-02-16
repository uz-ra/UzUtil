# UzLog

UzLogは、ログ出力を簡単にカスタマイズできるObjective-Cのユーティリティクラスです。  
ログにプレフィックスを追加したり、ファイルにログを出力する機能を提供します。


## 特徴

- **簡単なログフィルタリングのためのカスタムプレフィックス**

- **ファイルロギング**機能

- **クラス名抽出** ヘルパー

- デフォルトのプレフィックス設定のマクロサポート

## 使い方

### 1. インポートと設定

まず、プロジェクトに`UzLog.h`をインポートし、Makefileに`UzLog.mm`を書く

```objective-c
#import "UzLog.h"
```

### 2. プレフィックスの設定

ログメッセージにプレフィックスを追加できます。これにより、ログのフィルタリングや識別が容易になります。

```objective-c
// プレフィックスを設定
[UzLog setPrefix:@"Hogege"];
// 出力例: "Hogege: hello world"
```

マクロを使ってデフォルトのプレフィックスを一括設定することも可能です。

```objective-c
#define UZLOG_DEFAULT_PREFIX @"Fuga"
```

### 3. ログの出力

通常のログ出力は以下のように行います。

```objective-c
[UzLog log:@"This is a log message: %@", @"Hello, World!"];
```

### 4. ファイルへのログ出力

ログをファイルに書き込むこともできます。ファイルパスを指定して、重要なメッセージを保存しましょう。

```objective-c
NSString *logFilePath = @"/path/to/logfile.txt";
[UzLog log:@"This log will be written to a file: %@", @"Important message" writeToFile:YES toPath:logFilePath];
```

### 5. クラス名の取得

引数のクラス名を取得してログに出力することも可能です。

```objective-c
[UzLog className:arg1];
[UzLog log:@"Class name for arg1 is : %@", [UzLog className:arg1]];
```

---

UzLogを使えば、ログ出力の管理が簡単になり、デバッグやトラブルシューティングが効率的に行えます！