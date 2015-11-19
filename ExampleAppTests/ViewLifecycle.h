#import <UIKit/UIKit.h>

@interface ViewLifecycle : NSObject

- (void)appear:(UIViewController *)viewController animated:(BOOL)animated;
- (void)disappear:(UIViewController *)viewController animated:(BOOL)animated;

@end