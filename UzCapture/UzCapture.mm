#import "UzCapture.h"

@implementation UzCapture

+ (UIImage *)imageFromView:(UIView *)view {
    if (!view) return nil;
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageFromWindow:(UIWindow *)window {
    return [self imageFromView:window];
}

@end
