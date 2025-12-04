# UzLog

A simple and flexible logging utility for Objective-C with prefix filtering and file logging support.

## Features

- **Custom Prefix** for easy log filtering
- **File Logging** capability
- **Timestamp Support** for log entries
- **Class name extraction** helper
- **Ivar (instance variable) class name extraction**
- Macro support for default prefix configuration

## Installation

1. Add header import to your implementation file:
```objective-c
#import "UzLog.h"
```

2. Include `UzLog.mm` in your Makefile:
```makefile
SRCS = main.m UzLog.mm
```

## Usage

### Basic Configuration
```objective-c
// Set custom prefix
[UzLog setPrefix:@"Hogege"];

// Set default prefix via macro (recommended)
#define UZLOG_DEFAULT_PREFIX @"Fuga"
```

### Logging Methods
**Console Logging:**
```objective-c
[UzLog log:@"This is a log message: %@", @"Hello, World!"];
// Output: Fuga: This is a log message: Hello, World!
```

**File Logging:**
```objective-c
NSString *logFilePath = @"/path/to/logfile.txt";
[UzLog log:@"hogehoge %@ is fugafuga %d" writeToFile:YES toPath:logFilePath, arg1, arg2];
```

**Class Name Helper:**
```objective-c
NSObject *myObject = [NSObject new];
NSLog(@"Class: %@", [UzLog className:myObject]);
// Output: Class: NSObject
```

**Ivar Class Name Extraction:**
```objective-c
// Get the class name of a specific instance variable (ivar)
NSString *ivarClass = [UzLog ivarClassName:myObject ivarName:@"_delegate"];
[UzLog log:@"ivar '_delegate' class name: %@", ivarClass];

// Returns nil if the ivar doesn't exist
NSString *result = [UzLog ivarClassName:myObject ivarName:@"_nonExistent"];
// result is nil
```

**Supported Types:**
- Object types (NSString, UIView, etc.) → Returns class name
- Primitive types (int, float, BOOL, double, etc.) → Returns type name
- Non-existent ivar → Returns `nil`

**Example:**
```objective-c
@interface MyClass : NSObject {
## Notes

- Prefix format: `[YourPrefix]: log message`
- File logging is synchronous - consider performance for frequent writes
- Combine with build flags for debug/release logging differences
- The `ivarClassName:ivarName:` method uses Objective-C runtime to inspect instance variables
- Timestamp format is fixed as `[yyyy-MM-dd HH:mm:ss]`

## API Reference

### Methods

- `+ (void)setPrefix:(NSString *)prefix` - Set custom log prefix
- `+ (void)log:(NSString *)format, ...` - Basic console logging
- `+ (void)log:(NSString *)format writeToFile:(BOOL)writeToFile toPath:(NSString *)toPath, ...` - Log with file output option
- `+ (void)log:(NSString *)format writeToFile:(BOOL)writeToFile includeTimestamp:(BOOL)includeTimestamp toPath:(NSString *)toPath, ...` - Full-featured logging with timestamp
- `+ (NSString *)className:(id)object` - Get class name of an object
- `+ (NSString *)ivarClassName:(id)object ivarName:(NSString *)ivarName` - Get class/type name of an instance variable

MyClass *obj = [[MyClass alloc] init];

// Object type ivar
NSString *titleClass = [UzLog ivarClassName:obj ivarName:@"_title"];
// titleClass = @"NSString"

// Primitive type ivar
NSString *countType = [UzLog ivarClassName:obj ivarName:@"_count"];
// countType = @"int"

// Object type ivar
NSString *viewClass = [UzLog ivarClassName:obj ivarName:@"_containerView"];
// viewClass = @"UIView"
```

**Timestamp Logging:**
```objective-c
NSString *logFilePath = @"/path/to/logfile.txt";
[UzLog log:@"Debug info" 
writeToFile:YES 
includeTimestamp:YES 
     toPath:logFilePath];
// Output: [2025-12-04 14:30:45] Debug info
```

## Examples

### Typical Usage Flow
```objective-c
#define UZLOG_DEFAULT_PREFIX @"MyApp"

- (void)exampleMethod {
    [UzLog log:@"User %@ logged in", @"Alice"];
    
    if (error) {
        [UzLog log:@"Error occurred: %@", error.localizedDescription
         writeToFile:YES
             toPath:@"/var/log/myapp_error.log"];
    }
    
    [UzLog log:@"Current controller: %@", [UzLog className:self]];
}
```

## Notes

- Prefix format: `[YourPrefix]: log message`
- File logging is synchronous - consider performance for frequent writes
- Combine with build flags for debug/release logging differences