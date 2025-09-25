#import <UIKit/UIKit.h>

@interface UzCapture : NSObject
/// UIView を UIImage にキャプチャ
+ (UIImage *)imageFromView:(UIView *)view;
/// UIWindow 全体をキャプチャ（オプション）
+ (UIImage *)imageFromWindow:(UIWindow *)window;
@end