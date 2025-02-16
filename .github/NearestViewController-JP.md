# NearestViewController

`NearestViewController`は、`UIView`のカテゴリ（拡張）として実装された便利なメソッドを提供します。  
このメソッドは、現在の`UIView`から最も近い親`UIViewController`を取得するために使用されます。

---

## 概要

`UIView`のインスタンスから、そのビューが属する`UIViewController`を簡単に取得できます。  
これは、ビュー階層を遡り、`nextResponder`を利用して実現されています。

---

## 使い方

### 1. インポート

`NearestViewController.h`をプロジェクトにインポートします。

```objective-c
#import "NearestViewController.h"
```

### 2. メソッドの呼び出し

`UIView`のインスタンスから、最も近い`UIViewController`を取得します。

```objective-c
UIViewController *nearestVC = [self.view nearestViewController];
if (nearestVC) {
    NSLog(@"Nearest ViewController: %@", nearestVC);
} else {
    NSLog(@"No ViewController found.");
}
```

---

## 実装詳細

### メソッド: `nearestViewController`

このメソッドは、`UIView`の`nextResponder`を遡り、最初に見つかった`UIViewController`を返します。  
もし`UIViewController`が見つからない場合は、`nil`を返します。

```objective-c
- (UIViewController *)nearestViewController {
    // nextResponderをたどってUIViewControllerを探す
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil; // UIViewControllerが見つからない場合nilを返す
}
```

---

## 使用例

### シナリオ

ある`UIView`が複雑なビュー階層に埋め込まれている場合、そのビューが属する`UIViewController`を簡単に取得したいことがあります。  
このメソッドを使えば、ビュー階層を手動で遡る必要がなく、簡単に目的の`UIViewController`を取得できます。

### コード例

```objective-c
// カスタムビュー内で最も近いViewControllerを取得
UIViewController *parentVC = [self nearestViewController];
if (parentVC) {
    [parentVC presentViewController:someViewController animated:YES completion:nil];
}
```