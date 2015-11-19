#import "ViewLifecycle.h"

@implementation ViewLifecycle

- (void)appear:(UIViewController *)viewController animated:(BOOL)animated {
    [self loadView:viewController];
    [viewController viewDidAppear:animated];
}

- (void)disappear:(UIViewController *)viewController animated:(BOOL)animated {
    [viewController viewWillDisappear:animated];
    [viewController viewDidDisappear:animated];
}

- (void)loadView:(UIViewController *)viewController {
    // load the view and call viewDidLoad
    UIView *forceLoad = viewController.view;
    forceLoad = nil;
}

@end