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
#import <objc/runtime.h>

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

+ (void)log:(NSString *)format writeToFile:(BOOL)writeToFile toPath:(NSString *)toPath, ... {
    va_list args;
    va_start(args, toPath);
    [self log:format 
  writeToFile:writeToFile 
includeTimestamp:NO
       toPath:toPath
   arguments:args];
    va_end(args);
}

+ (void)log:(NSString *)format 
writeToFile:(BOOL)writeToFile 
includeTimestamp:(BOOL)includeTimestamp
     toPath:(NSString *)toPath, ... {
    va_list args;
    va_start(args, toPath);
    [self log:format 
  writeToFile:writeToFile 
includeTimestamp:includeTimestamp
       toPath:toPath
   arguments:args];
    va_end(args);
}

// 実際の処理を行うヘルパーメソッド
+ (void)log:(NSString *)format 
writeToFile:(BOOL)writeToFile 
includeTimestamp:(BOOL)includeTimestamp
     toPath:(NSString *)toPath
  arguments:(va_list)arguments {
    
    NSString *logMessage = [[NSString alloc] initWithFormat:format arguments:arguments];
    
    // タイムスタンプ追加処理
    if (includeTimestamp) {
        static NSDateFormatter *formatter;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        });
        NSString *timestamp = [formatter stringFromDate:[NSDate date]];
        logMessage = [NSString stringWithFormat:@"[%@] %@", timestamp, logMessage];
    }
    
    // プレフィックス追加処理
    if (_prefix) {
        logMessage = [NSString stringWithFormat:@"%@ : %@", _prefix, logMessage];
    }
    
    NSLog(@"%@", logMessage);
    
    // ファイル書き込み処理
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

+ (void)log:(NSString *)format, ... {
    va_list args;
    va_start(args, format);

    NSString *logMessage = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);

    if (_prefix) {
        logMessage = [NSString stringWithFormat:@"%@ : %@", _prefix, logMessage];
    }

    NSLog(@"%@", logMessage);
}

+ (NSString *)className:(id)object {
    return NSStringFromClass([object class]);
}

+ (NSString *)ivarClassName:(id)object ivarName:(NSString *)ivarName {
    if (!object || !ivarName) {
        return nil;
    }
    
    Class objectClass = [object class];
    Ivar ivar = class_getInstanceVariable(objectClass, [ivarName UTF8String]);
    
    if (!ivar) {
        // ivarが見つからない場合
        return nil;
    }
    
    // ivarの型エンコーディングを取得
    const char *typeEncoding = ivar_getTypeEncoding(ivar);
    
    if (!typeEncoding) {
        return nil;
    }
    
    // オブジェクト型の場合（@"ClassName"の形式）
    if (typeEncoding[0] == '@') {
        // @"ClassName" の形式から ClassName を抽出
        if (strlen(typeEncoding) > 3 && typeEncoding[1] == '"') {
            NSString *fullTypeString = [NSString stringWithUTF8String:typeEncoding];
            // @"ClassName" から ClassName を抽出
            NSRange range = NSMakeRange(2, fullTypeString.length - 3);
            return [fullTypeString substringWithRange:range];
        } else {
            // @だけの場合はid型
            return @"id";
        }
    } else {
        // プリミティブ型の場合
        switch (typeEncoding[0]) {
            case 'c': return @"char";
            case 'i': return @"int";
            case 's': return @"short";
            case 'l': return @"long";
            case 'q': return @"long long";
            case 'C': return @"unsigned char";
            case 'I': return @"unsigned int";
            case 'S': return @"unsigned short";
            case 'L': return @"unsigned long";
            case 'Q': return @"unsigned long long";
            case 'f': return @"float";
            case 'd': return @"double";
            case 'B': return @"BOOL";
            case 'v': return @"void";
            case '*': return @"char *";
            case '#': return @"Class";
            case ':': return @"SEL";
            default:  return [NSString stringWithUTF8String:typeEncoding];
        }
    }
}

@end