//AppFinder.mm
//Made by uz.ra in 2025/04/21
//
#import "AppFinder.h"

@implementation AppFinder

+ (NSString *)dataDirForBundleID:(NSString *)bundleID {
    NSString *appsRoot = @"/var/mobile/Containers/Data/Application";
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *contents = [fm contentsOfDirectoryAtPath:appsRoot error:nil];

    for (NSString *uuid in contents) {
        NSString *metaPath = [appsRoot stringByAppendingPathComponent:
            [NSString stringWithFormat:@"%@/.com.apple.mobile_container_manager.metadata.plist", uuid]
        ];

        NSDictionary *metadata = [NSDictionary dictionaryWithContentsOfFile:metaPath];
        NSString *identifier = metadata[@"MCMMetadataIdentifier"];

        if ([identifier isEqualToString:bundleID]) {
            return [appsRoot stringByAppendingPathComponent:uuid];
        }
    }

    return nil;
}

+ (NSString *)bundleDirForBundleID:(NSString *)bundleID {
    NSString *appsRoot = @"/var/containers/Bundle/Application";
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *contents = [fm contentsOfDirectoryAtPath:appsRoot error:nil];

    for (NSString *uuid in contents) {
        NSString *metaPath = [appsRoot stringByAppendingPathComponent:
            [NSString stringWithFormat:@"%@/.com.apple.mobile_container_manager.metadata.plist", uuid]
        ];

        NSDictionary *metadata = [NSDictionary dictionaryWithContentsOfFile:metaPath];
        NSString *identifier = metadata[@"MCMMetadataIdentifier"];

        if ([identifier isEqualToString:bundleID]) {
            return [appsRoot stringByAppendingPathComponent:uuid];
        }
    }

    return nil;
}


@end
