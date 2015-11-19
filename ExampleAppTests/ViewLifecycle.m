#import "ViewLifecycle.h"

@implementation ViewLifecycle

- (void)appear:(UIViewController *)viewController animated:(BOOL)animated {
    [self loadView:viewController];

    [self navigationControllerAppearHook:viewController];

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

- (void)navigationControllerAppearHook:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)viewController;
        [self appear:navController.topViewController animated:false];
    }
}

@end