# NearestViewController

`NearestViewController` provides a convenience method implemented as a category (extension) of `UIView`.
This method is used to retrieve the closest parent `UIViewController` from the current `UIView`.

---

## Overview

From a `UIView` instance, you can easily get the `UIViewController` to which the view belongs.
This is accomplished by going back through the view hierarchy and using `nextResponder`.

---

## Usage

### 1. import

Import `NearestViewController.h` into your project.

```objective-c
#import "NearestViewController.h"
```

### Calling methods

Get the nearest `UIViewController` from the `UIView` instance.

```objective-c
UIViewController *nearestVC = [self.view nearestViewController];
if (nearestVC) {
    NSLog(@"Nearest ViewController: %@", nearestVC);
} else {
    NSLog(@"No ViewController found."); }
}
```

--- ---

## Implementation details

### Method: `nearestViewController`.

This method traverses the `nextResponder` of the `UIView` and returns the first `UIViewController` found.
If `UIViewController` is not found, it returns `nil`.

If no `UIViewController` is found, then `nil` is returned.
- (UIViewController *)nearestViewController {
    // Follow nextResponder to find UIViewController.
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder; }
        }
    }
    return nil; // return nil if UIViewController is not found
}
```

--- ````

## Example usage

### Scenario

When a `UIView` is embedded in a complex view hierarchy, you may want to easily retrieve the `UIViewController` to which the view belongs.
Using this method, you can easily retrieve the desired `UIViewController` without having to manually traverse the view hierarchy.

### Code Example

```objective-c
// Get the closest ViewController in the custom view
UIViewController *parentVC = [self nearestViewController];
if (parentVC) {
    [parentVC presentViewController:someViewController animated:YES completion:nil];
}
```