//
//  YMBaseNavigationController.h
//
//  Created by 樊彦明 on 2019/6/27.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface YMBaseNavigationController : UINavigationController

@end

@interface YMWrapperViewController: UIViewController

+ (YMWrapperViewController *)wrapViewController:(UIViewController *)rootViewController;

@end

@interface YMBaseNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

// call these methods below before you use YMBaseNavigationController
// set default color of the navigation bar background color,
+ (void)setGlobalBarTintColor:(UIColor *)color;

// set default color of the navigation item color, call this method before you use YMBaseNavigationController
+ (void)setGlobalTintColor:(UIColor *)color;

// index 0, means the root view controller
+ (void)setBarTintColor:(UIColor *)color atIndex:(NSInteger)index;

// index 0, means the root view controller
+ (void)setTintColor:(UIColor *)color atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
