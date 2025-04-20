#import <Foundation/Foundation.h>

@interface AppFinder : NSObject
+ (NSString *)dataDirForBundleID:(NSString *)bundleID;
+ (NSString *)bundleDirForBundleID:(NSString *)bundleID;
@end