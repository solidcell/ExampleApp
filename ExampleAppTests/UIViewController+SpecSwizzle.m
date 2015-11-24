//#import <objc/runtime.h>
//#import "ViewLifecycle.h"
//
//@interface UIViewController (SpecSwizzle)
//
//@property (nonatomic, strong) UIViewController *internalPresentedViewController;
//@property (nonatomic, strong) UIViewController *internalPresentingViewController;
//
//@end
//
//@implementation UIViewController (SpecSwizzle)
//
//@dynamic internalPresentedViewController;
//@dynamic internalPresentingViewController;
//
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//
//        [self swizzleOriginalSelector:@selector(presentViewController:animated:completion:)
//                     swizzledSelector:@selector(xxx_presentViewController:animated:completion:)];
//
//        [self swizzleOriginalSelector:@selector(dismissViewControllerAnimated:completion:)
//                     swizzledSelector:@selector(xxx_dismissViewControllerAnimated:completion:)];
//    });
//}
//
//#pragma mark - presentedViewController
//
//- (UIViewController *)presentedViewController {
//    return self.internalPresentedViewController;
//}
//
//- (void)setInternalPresentedViewController:(UIViewController *)object {
//    objc_setAssociatedObject(self, @selector(internalPresentedViewController), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (UIViewController *)internalPresentedViewController {
//    return objc_getAssociatedObject(self, @selector(internalPresentedViewController));
//}
//
//#pragma mark - presentingViewController
//
//- (UIViewController *)presentingViewController {
//    if (self.internalPresentingViewController) {
//        return self.internalPresentingViewController;
//    }
//    if (self.navigationController && self.navigationController.internalPresentingViewController) {
//        return self.navigationController.internalPresentingViewController;
//    }
//    return nil;
//}
//
//- (void)setInternalPresentingViewController:(UIViewController *)object {
//    objc_setAssociatedObject(self, @selector(internalPresentingViewController), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (UIViewController *)internalPresentingViewController {
//    return objc_getAssociatedObject(self, @selector(internalPresentingViewController));
//}
//
//#pragma mark - Swizzled methods
//
//- (void)xxx_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
//    self.internalPresentedViewController = viewControllerToPresent;
//    [[self viewLifecycle] appear:viewControllerToPresent animated:animated];
//    viewControllerToPresent.internalPresentingViewController = self;
//}
//
//- (void)xxx_dismissViewControllerAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
//    if (self.internalPresentedViewController) {
//        self.internalPresentedViewController.internalPresentingViewController = nil;
//        [[self viewLifecycle] disappear:self.internalPresentedViewController animated:animated];
//        self.internalPresentedViewController = nil;
//    } else {
//        [self.presentingViewController dismissViewControllerAnimated:animated completion:completion];
//    }
//}
//
//#pragma mark - Helpers
//
//- (ViewLifecycle *)viewLifecycle {
//    return [[ViewLifecycle alloc] init];
//}
//
//+ (void)swizzleOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
//    Class class = [self class];
//
//    Method originalMethod = class_getInstanceMethod(class, originalSelector);
//    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//
//    BOOL didAddMethod = class_addMethod(class,
//                                        originalSelector,
//                                        method_getImplementation(swizzledMethod),
//                                        method_getTypeEncoding(swizzledMethod));
//
//    if (didAddMethod) {
//        class_replaceMethod(class,
//                            swizzledSelector,
//                            method_getImplementation(originalMethod),
//                            method_getTypeEncoding(originalMethod));
//    } else {
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
//}
//
//@end
