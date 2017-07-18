//
//  PANavigationViewController.h
//  PANavigationControllerDemo
//  PA is short for push all.
//  Created by 彦明 on 16/12/20.
//  Copyright © 2016年 Yanming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PANavigationViewController : UINavigationController
/** set before you push the controller into the stack*/
- (void)pa_setTitleTextAttributes:(NSDictionary<NSString *,id> *)textTitleAttributes;
- (void)pa_setTitleTextAttributes:(NSDictionary<NSString *,id> *)textTitleAttributes atIndexInStack:(NSInteger)index;
- (void)pa_setTitleTextAttributes:(NSDictionary<NSString *,id> *)textTitleAttributes forViewControllerNamed:(NSString *)viewControllerName;

/** effect the bar background, set before you push the controller into the stack */
- (void)pa_setBarTintColor:(UIColor *)color;
/** set barTint color in different index level,default effect all */
- (void)pa_setBarTintColor:(UIColor *)color atIndexInStack:(NSInteger )index;
/** set barTint color in different controller,default effect all */
- (void)pa_setBarTintColor:(UIColor *)color forViewControllerNamed:(NSString *)viewControllerName;

/** use as bar tint color, effect the bar item */
- (void)pa_setTintColor:(UIColor *)color;
/** use as bar tint color, effect the bar item */
- (void)pa_setTintColor:(UIColor *)color atIndexInStack:(NSInteger )index;
/** use as bar tint color, effect the bar item */
- (void)pa_setTintColor:(UIColor *)color forViewControllerNamed:(NSString *)viewControllerName;

/** YES for show default bottom line of navigationBar, NO for don't */ 
- (void)pa_isHideBottomLineOfNaviBar:(BOOL)hidden;
- (void)pa_isHideBottomLineOfNaviBar:(BOOL)hidden atIndexAtStack:(NSInteger)index;
- (void)pa_isHideBottomLineOfNaviBar:(BOOL)hidden forViewControllerNamed:(NSString *)viewControllerName;

@end
