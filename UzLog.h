#import <Foundation/Foundation.h>

// UZLOG_DEFAULT_PREFIXが定義されていない場合は何もしない
#ifdef UZLOG_DEFAULT_PREFIX
    // 定義されている場合はその値を使用
#else
    // 定義されていない場合はプレフィックスを使用しない
    #define UZLOG_DEFAULT_PREFIX nil
#endif

@interface UzLog : NSObject
+ (void)setPrefix:(NSString *)prefix;
+ (void)log:(NSString *)format, ...;
+ (void)log:(NSString *)format writeToFile:(BOOL)writeToFile toPath:(NSString *)toPath, ...;
+ (NSString *)className:(id)object;
@end