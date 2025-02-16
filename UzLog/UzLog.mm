//UzLog.mm
//Made by uz.ra in 2025/02/14 
//
/*
Usage
まずは#import "UzLog.h"
        //prefixを設定
        [UzLog setPrefix:@"Hogege"];
        //出力結果がHogege: hello worldになる
        //フィルタリングしやすいね！
        //マクロで一括もOK
        #define UZLOG_DEFAULT_PREFIX @"Fuga"

        // 通常のログ出力
        [UzLog log:@"This is a log message: %@", @"Hello, World!"];

        // ファイルにログを書き込む
        NSString *logFilePath = @"/path/to/logfile.txt";
        [UzLog log:@"This log will be written to a file: %@", @"Important message" writeToFile:YES toPath:logFilePath];

        // クラス名を取得
        [UzLog className:arg1];
        [UzLog log:@"Class name for arg1 is : %@", [UzLog className:arg1]];
*/
//
//

#import "UzLog.h"

@implementation UzLog

// プレフィックス用の静的変数
static NSString *_prefix = nil;

+ (void)setPrefix:(NSString *)prefix {
    _prefix = [prefix copy];
}

__attribute__((constructor))
static void initializePrefix() {
    // UZLOG_DEFAULT_PREFIXが定義されている場合のみプレフィックスを設定
    #ifdef UZLOG_DEFAULT_PREFIX
        [UzLog setPrefix:UZLOG_DEFAULT_PREFIX];
    #endif
}

+ (void)log:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *logMessage = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    // プレフィックスが設定されている場合のみ付与
    if (_prefix) {
        logMessage = [NSString stringWithFormat:@"%@ : %@", _prefix, logMessage];
    }
    
    NSLog(@"%@", logMessage);
}

+ (void)log:(NSString *)format writeToFile:(BOOL)writeToFile toPath:(NSString *)toPath, ... {
    va_list args;
    va_start(args, toPath);
    NSString *logMessage = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    // プレフィックスが設定されている場合のみ付与
    if (_prefix) {
        logMessage = [NSString stringWithFormat:@"%@ : %@", _prefix, logMessage];
    }
    
    NSLog(@"%@", logMessage);
    
    if (writeToFile) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:toPath]) {
            [fileManager createFileAtPath:toPath contents:nil attributes:nil];
        }
        
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:toPath];
        [fileHandle seekToEndOfFile];
        NSString *logEntry = [NSString stringWithFormat:@"%@\n", logMessage];
        [fileHandle writeData:[logEntry dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle closeFile];
    }
}

+ (NSString *)className:(id)object {
    return NSStringFromClass([object class]);
}

@end