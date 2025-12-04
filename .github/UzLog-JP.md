# UzLog

UzLogは、ログ出力を簡単にカスタマイズできるObjective-Cのユーティリティクラスです。  
ログにプレフィックスを追加したり、ファイルにログを出力する機能を提供します。

## 特徴

- 簡単なログフィルタリングのための**カスタムプレフィックス**
- **ファイルロギング**機能
- **タイムスタンプ付きログ出力**
- **クラス名取得** 
- **ivar（インスタンス変数）のクラス名取得**
- デフォルトのプレフィックス設定のマクロサポート

---

## 使い方

### 1. インポートと設定

まず、プロジェクトに`UzLog.h`をインポートし、Makefileに`UzLog.mm`を追加します。

```objective-c
#import "UzLog.h"
```

---

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

---

### 3. ログの出力

通常のログ出力は以下のように行います。

```objective-c
[UzLog log:@"This is a log message: %@", @"Hello, World!"];
```

---

### 4. ファイルへのログ出力

ログをファイルに書き込むこともできます。ファイルパスを指定して、重要なメッセージを保存しましょう。

```objective-c
NSString *logFilePath = @"/path/to/logfile.txt";
[UzLog log:@"hogehoge %@ is fugafuga %d" writeToFile:YES toPath:logFilePath, arg1, arg2];
```

---

### 5. タイムスタンプ付きログ出力

ログにタイムスタンプを追加するオプションが利用可能です。  
`includeTimestamp` を `YES` に設定すると、ログメッセージの先頭にタイムスタンプが追加されます。

```objective-c
NSString *logFilePath = @"/path/to/logfile.txt";
[UzLog log:@"Debug info" 
writeToFile:YES 
includeTimestamp:YES 
     toPath:logFilePath];
```

**出力例（ファイル）:**
```
[2025-02-16 14:30:45] Debug info
```

---

### 6. クラス名の取得

引数のクラス名を取得してログに出力することも可能です。

```objective-c
[UzLog className:arg1];
[UzLog log:@"Class name for arg1 is : %@", [UzLog className:arg1]];
```

---

### 7. ivar（インスタンス変数）のクラス名取得

オブジェクトの特定のインスタンス変数（ivar）のクラス名や型を取得できます。  
デバッグやリフレクション処理に便利です。

```objective-c
// ivarのクラス名を取得
NSString *ivarClass = [UzLog ivarClassName:myObject ivarName:@"_delegate"];
[UzLog log:@"ivar '_delegate' のクラス名: %@", ivarClass];

// 存在しないivarの場合はnilが返る
NSString *result = [UzLog ivarClassName:myObject ivarName:@"_nonExistent"];
if (!result) {
    [UzLog log:@"指定されたivarは存在しません"];
}
```

**対応する型：**
- オブジェクト型（NSString, UIViewなど）→ クラス名を返す
- プリミティブ型（int, float, BOOL, doubleなど）→ 型名を返す
- 存在しないivar → `nil`を返す

**使用例：**
```objective-c
@interface MyClass : NSObject {
    NSString *_title;
    int _count;
    UIView *_containerView;
}
@end

MyClass *obj = [[MyClass alloc] init];

// オブジェクト型のivar
NSString *titleClass = [UzLog ivarClassName:obj ivarName:@"_title"];
// titleClass = @"NSString"

// プリミティブ型のivar
NSString *countType = [UzLog ivarClassName:obj ivarName:@"_count"];
// countType = @"int"

// オブジェクト型のivar
NSString *viewClass = [UzLog ivarClassName:obj ivarName:@"_containerView"];
// viewClass = @"UIView"
```

---

## メソッド比較

| メソッド名                                      | プレフィックス | ファイル出力 | タイムスタンプ | 可変長引数 |
|-------------------------------------------------|----------------|--------------|----------------|------------|
| `+log:`                                         | あり           | なし         | なし           | あり       |
| `+log:writeToFile:toPath:`                      | あり           | あり         | なし           | あり       |
| `+log:writeToFile:includeTimestamp:toPath:`     | あり           | あり         | あり           | あり       |
| `+className:`                                   | -              | -            | -              | なし       |
| `+ivarClassName:ivarName:`                      | -              | -            | -              | なし       |

---

## 全体における注意事項

1. **ファイルパスの指定**
   - ファイルにログを出力する場合、正しいファイルパスを指定してください。パスが無効な場合、ログはファイルに保存されません。

2. **タイムスタンプのフォーマット**
   - タイムスタンプは `[yyyy-MM-dd HH:mm:ss]` の形式で固定されています。変更が必要な場合は、実装ファイルを修正してください。

3. **スレッドセーフ**
   - ログ出力はスレッドセーフですが、複数のスレッドから同時にファイルに書き込む場合、ログの順序が保証されないことがあります。

4. **パフォーマンス**
   - ファイルへのログ出力は、ディスクI/Oが発生するため、パフォーマンスに影響を与える可能性があります。デバッグ時以外は、ファイル出力を控えることを推奨します。

5. **既存コードとの互換性**
   - 新しいメソッドを追加しても、既存のメソッドはそのまま動作します。既存のコードに影響はありません。

---

UzLogを使えば、ログ出力の管理が簡単になり、デバッグやトラブルシューティングが効率的に行えます！