# UzLog

A simple and flexible logging utility for Objective-C with prefix filtering and file logging support.

## Features

- **Custom Prefix** for easy log filtering
- **File Logging** capability
- **Class name extraction** helper
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
[UzLog log:@"Important system event: %d" writeToFile:YES toPath:logFilePath, 42];
```

**Class Name Helper:**
```objective-c
NSObject *myObject = [NSObject new];
NSLog(@"Class: %@", [UzLog className:myObject]);
// Output: Class: NSObject
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