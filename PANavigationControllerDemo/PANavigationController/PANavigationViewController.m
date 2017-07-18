//
//  PANavigationViewController.m
//  PANavigationControllerDemo
//
//  Created by 彦明 on 16/12/20.
//  Copyright © 2016年 Yanming. All rights reserved.
//
#define ScreenBounds [UIScreen mainScreen].bounds
#import "PANavigationViewController.h"
#import "PAWrapperViewController.h"
#import "PAWrapperNavigationController.h"
#import "UIViewController+PANavigationControllerCategory.h"
#import "PAAnimationTransition.h"
#import "PANormalDismissAnimationTransition.h"

@interface PANavigationViewController ()<UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) PAAnimationTransition *paPopAnimation;
@property (nonatomic, strong) PANormalDismissAnimationTransition *normalDismissAnimation;

// navigation bar setting about
@property (nonatomic, copy) NSDictionary<NSString *,id> *textTitleAttributes;
@property (nonatomic, strong) NSMutableDictionary *customTextTitleAttributesDictionary;
@property (nonatomic, strong) NSMutableDictionary *viewControllersTextTitleAttributesDictionary;


@property (nonatomic, strong) UIColor *barTintColor;
@property (nonatomic, strong) NSMutableDictionary *customBarTintColorDictionary;
@property (nonatomic, strong) NSMutableDictionary *viewControllersBarTintColorDictionary;

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) NSMutableDictionary *customTintColorDictionary;
@property (nonatomic, strong) NSMutableDictionary *viewControllersTintColorDictionary;

@property (nonatomic, assign) BOOL isHideBottomLine;
@property (nonatomic, strong) NSMutableDictionary *customIsHideBottomlineDictionary;
@property (nonatomic, strong) NSMutableDictionary *viewControllersIsHideBottomlineDictionary;

@end

@implementation PANavigationViewController


#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarHidden:YES];
    self.transitioningDelegate = self;
    self.delegate = self;
}

#pragma mark - 交互动画
- (PAAnimationTransition *)paPopAnimation {
    if (_paPopAnimation == nil) {
        _paPopAnimation = [[PAAnimationTransition alloc] init];
    }
    return _paPopAnimation;
}

#pragma mark - dismiss 动画
- (PANormalDismissAnimationTransition *)normalDismissAnimation {
    if (_normalDismissAnimation == nil) {
        _normalDismissAnimation = [[PANormalDismissAnimationTransition alloc] init];
    }
    return _normalDismissAnimation;
}

#pragma mark - 调用自定义的动画来完成切换
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    // 正在交互中,保持原样即可,不需要再返回
    return self.paPopAnimation.interacting ? self.paPopAnimation : nil;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    // 只有出栈的时候调用,其他用系统的
    if (operation == UINavigationControllerOperationPop) {
        return self.normalDismissAnimation;
    }
    return nil;
}

#pragma mark - 进栈控制
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    // 确保每个控制器独立的导航栏,我们把传进来的导航栏,额外包装一个导航控制器:PAWrapperNavigationController

    PAWrapperNavigationController *wrapperNaviVC = [[PAWrapperNavigationController alloc] init];
    // 此处默认是不透明的,方便设置背景色
    wrapperNaviVC.navigationBar.translucent = NO;
    [wrapperNaviVC.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:(UIBarMetricsDefault)];
    
    // bottom line about
    if (self.isHideBottomLine) {
        [wrapperNaviVC.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
    
    if (_customIsHideBottomlineDictionary.count) {
        NSInteger indexToDisplay = self.viewControllers.count;
        BOOL isHideToPlay = [[_customIsHideBottomlineDictionary objectForKey:[NSNumber numberWithInteger:indexToDisplay]] boolValue];
        if (isHideToPlay) {
            [wrapperNaviVC.navigationBar setShadowImage:[[UIImage alloc] init]];
        }
    }
    
    if (_viewControllersIsHideBottomlineDictionary.count) {
        for (NSString *stringKey in _viewControllersIsHideBottomlineDictionary.allKeys) {
            if ([viewController isKindOfClass:NSClassFromString(stringKey)]) {
                BOOL isHideToPlay = [[_viewControllersIsHideBottomlineDictionary objectForKey:stringKey] boolValue];
                if (isHideToPlay) {
                    [wrapperNaviVC.navigationBar setShadowImage:[[UIImage alloc] init]];
                }else {
                    [wrapperNaviVC.navigationBar setShadowImage:nil];
                }
            }
        }
    }

    
    // bar tint color about
    if (self.barTintColor) {
        [wrapperNaviVC.navigationBar setBarTintColor:self.barTintColor];
    }
    
    if (_customBarTintColorDictionary.count) {
        NSInteger indexToDisplay = self.viewControllers.count;
        UIColor *barTintColorToDisplay = [_customBarTintColorDictionary objectForKey:[NSNumber numberWithInteger:indexToDisplay]];
        if ([barTintColorToDisplay isEqual:[UIColor clearColor]]) {
            [wrapperNaviVC.navigationBar setShadowImage:[[UIImage alloc] init]];
            wrapperNaviVC.navigationBar.translucent = YES;
        }
        [wrapperNaviVC.navigationBar setBarTintColor:barTintColorToDisplay ? barTintColorToDisplay : _barTintColor];
        
    }
    
    if (_viewControllersBarTintColorDictionary.count) {
        
        for (NSString *stringKey in _viewControllersBarTintColorDictionary.allKeys) {
            if ([viewController isKindOfClass:NSClassFromString(stringKey)]) {
                UIColor *barTintColorToDisplay = [_viewControllersBarTintColorDictionary objectForKey:stringKey];
                if ([barTintColorToDisplay isEqual:[UIColor clearColor]]) {
                    [wrapperNaviVC.navigationBar setShadowImage:[[UIImage alloc] init]];
                    wrapperNaviVC.navigationBar.translucent = YES;
                }else if ([_viewControllersIsHideBottomlineDictionary objectForKey:stringKey] == NO){
                    [wrapperNaviVC.navigationBar setShadowImage:nil];
                    wrapperNaviVC.navigationBar.translucent = NO;
                }
                [wrapperNaviVC.navigationBar setBarTintColor:barTintColorToDisplay ? barTintColorToDisplay : _barTintColor];
                
            }
        }
    }

    
    // tint color about
    if (self.tintColor) {
        [wrapperNaviVC.navigationBar setTintColor:self.tintColor];
    }
    if (_customTintColorDictionary.count) {
        NSInteger indexToDisplay = self.viewControllers.count;
        UIColor *tintColorToDisplay = [_customTintColorDictionary objectForKey:[NSNumber numberWithInteger:indexToDisplay]];
        [wrapperNaviVC.navigationBar setTintColor:tintColorToDisplay ? tintColorToDisplay : _tintColor];
    }
    if (_viewControllersTintColorDictionary.count) {
        
        for (NSString *stringKey in _viewControllersTintColorDictionary.allKeys) {
            if ([viewController isKindOfClass:NSClassFromString(stringKey)]) {
                UIColor *tintColorToDisplay = [_viewControllersTintColorDictionary objectForKey:stringKey];
                [wrapperNaviVC.navigationBar setTintColor:tintColorToDisplay ? tintColorToDisplay : _tintColor];

            }
        }
    }
    
    
    [wrapperNaviVC pushViewController:viewController animated:YES];
    
    // pop 的时候可以快速找到根导航控制器
    wrapperNaviVC.pa_navigationController = self;
    
    //
    
    if (_textTitleAttributes) {
        [wrapperNaviVC.navigationBar setTitleTextAttributes:_textTitleAttributes];
    }
    
    if (_customTextTitleAttributesDictionary.count) {
        NSInteger indexDisplaying = self.viewControllers.count;
        NSDictionary *textAttributesToDisplay = [_customTextTitleAttributesDictionary objectForKey:[NSNumber numberWithInteger:indexDisplaying]];
        [wrapperNaviVC.navigationBar setTitleTextAttributes:textAttributesToDisplay ? textAttributesToDisplay : _textTitleAttributes];

    }
    
    if (_viewControllersTextTitleAttributesDictionary.count) {
        for (NSString *stringKey in _viewControllersTextTitleAttributesDictionary.allKeys) {
            if ([viewController isKindOfClass:NSClassFromString(stringKey)]) {
                NSDictionary *textTitleAttributesToDisplay = [_viewControllersTextTitleAttributesDictionary objectForKey:stringKey];
                [wrapperNaviVC.navigationBar setTitleTextAttributes:textTitleAttributesToDisplay ? textTitleAttributesToDisplay :_textTitleAttributes];
                
            }
        }

    }
    
    
    // 因为系统不允许导航控制器再压入导航控制器,所以我们还需再包装一层控制器:PAWrapperViewController
    PAWrapperViewController *wrapperVC = [[PAWrapperViewController alloc] init];
    
    [wrapperVC addChildViewController:wrapperNaviVC];
    [wrapperVC.view addSubview:wrapperNaviVC.view];
    
    wrapperVC.pa_navigationController = self;
    // 如果是根控制器,没必要有滑动返回的手势
    if (self.viewControllers.count != 0) {
        [self.paPopAnimation wireToViewController:wrapperVC];
    }
    
    
    // 记录用户设置的tabBar相关
    wrapperVC.tabBarItem = viewController.tabBarItem;
    
    wrapperVC.hidesBottomBarWhenPushed = viewController.hidesBottomBarWhenPushed;
    // 因为每个控制都其实wrapperNavigationContoller的rootVC,所以,返回按钮都市不显示的
    
    [super pushViewController:wrapperVC animated:YES];

#pragma mark - 为非根控制器添加返回按钮
    if (self.viewControllers.count > 1) {
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        backButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/5, 44);
        
        [backButton addSubview:[self backArrwoViewWithColor:viewController.navigationController.navigationBar.tintColor]];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [backButton addTarget:self action:@selector(backButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
        
    }

}

#pragma mark - 自定义返回按钮的监听
- (void)backButtonClicked {
    [self popViewControllerAnimated:YES];
}

#pragma mark - 确保正在显示的控制器有被添加动画相关的控制
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 确保返回后的控制器也会使用自定义的切换动画
    
    // 如果是根控制器,没必要有滑动返回的手势
    if (navigationController.viewControllers.count == 1) {
        return;
    }
    
    [self.paPopAnimation wireToViewController:viewController];
}

#pragma mark - 自定义绘制返回按钮,可以自定义颜色
- (UIView *)backArrwoViewWithColor:(UIColor *)color {
    
    UIView *backArrowView = [[UIView alloc] initWithFrame:CGRectMake(0, 12, 12, 20)];
    backArrowView.userInteractionEnabled = NO;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(9.79, 0)];
    [path addLineToPoint:CGPointMake(0, 9.8)];
    [path addLineToPoint:CGPointMake(9.79, 19.61)];
    [path addLineToPoint:CGPointMake(11.76, 17.62)];
    [path addLineToPoint:CGPointMake(3.96, 9.8)];
    [path addLineToPoint:CGPointMake(11.76, 1.99)];
    [path addLineToPoint:CGPointMake(9.79, 0)];
    
    CAShapeLayer *backArrowLayer = [CAShapeLayer layer];
    backArrowLayer.fillColor = color.CGColor;
    backArrowLayer.path = path.CGPath;
    backArrowLayer.lineWidth = 0;
    backArrowLayer.strokeColor = color.CGColor;
    backArrowLayer.lineCap = @"square";
    [backArrowView.layer addSublayer:backArrowLayer];
    return backArrowView;
}

#pragma mark - navigation bar setup about

// textTitleAttributes setup
- (void)pa_setTitleTextAttributes:(NSDictionary<NSString *,id> *)textTitleAttributes {
    _textTitleAttributes = textTitleAttributes;
}

- (void)pa_setTitleTextAttributes:(NSDictionary<NSString *,id> *)textTitleAttributes atIndexInStack:(NSInteger)index {
    [self.customTextTitleAttributesDictionary setObject:textTitleAttributes forKey:[NSNumber numberWithInteger:index]];
}

- (void)pa_setTitleTextAttributes:(NSDictionary<NSString *,id> *)textTitleAttributes forViewControllerNamed:(NSString *)viewControllerName {
    [self.viewControllersTextTitleAttributesDictionary setObject:textTitleAttributes forKey:viewControllerName];
}

// bar tint color setup
- (void)pa_setBarTintColor:(UIColor *)color {
    _barTintColor = color;
}

- (void)pa_setBarTintColor:(UIColor *)color atIndexInStack:(NSInteger)index {
    [self.customBarTintColorDictionary setObject:color forKey:[NSNumber numberWithInteger:index]];
}

- (void)pa_setBarTintColor:(UIColor *)color forViewControllerNamed:(NSString *)viewControllerName {
    [self.viewControllersBarTintColorDictionary setObject:color forKey:viewControllerName];
}

// tint color setup
- (void)pa_setTintColor:(UIColor *)color {
    _tintColor = color;
}

- (void)pa_setTintColor:(UIColor *)color atIndexInStack:(NSInteger)index {
    [self.customTintColorDictionary setObject:color forKey:[NSNumber numberWithInteger:index]];
}

- (void)pa_setTintColor:(UIColor *)color forViewControllerNamed:(NSString *)viewControllerName {
    [self.viewControllersTintColorDictionary setObject:color forKey:viewControllerName];

}

// bottom line of navigation bar setup
- (void)pa_isHideBottomLineOfNaviBar:(BOOL)hidden {
    _isHideBottomLine = hidden;
}

- (void)pa_isHideBottomLineOfNaviBar:(BOOL)hidden atIndexAtStack:(NSInteger)index {
    [self.customIsHideBottomlineDictionary setObject:[NSNumber numberWithBool:hidden] forKey:[NSNumber numberWithInteger:index]];
}

- (void)pa_isHideBottomLineOfNaviBar:(BOOL)hidden forViewControllerNamed:(NSString *)viewControllerName {
    [self.viewControllersIsHideBottomlineDictionary setObject:[NSNumber numberWithBool:hidden] forKey:viewControllerName];
}

#pragma mark - lazy load
- (NSMutableDictionary *)customTextTitleAttributesDictionary {
    if (_customTextTitleAttributesDictionary == nil) {
        _customTextTitleAttributesDictionary = [NSMutableDictionary dictionary];
    }
    
    return _customTextTitleAttributesDictionary;
}
- (NSMutableDictionary *)viewControllersTextTitleAttributesDictionary {
    if (_viewControllersTextTitleAttributesDictionary == nil) {
        _viewControllersTextTitleAttributesDictionary = [NSMutableDictionary dictionary];
    }
    
    return _viewControllersTextTitleAttributesDictionary;
}

- (NSMutableDictionary *)customBarTintColorDictionary {
    if (_customBarTintColorDictionary == nil) {
        _customBarTintColorDictionary = [NSMutableDictionary dictionary];
    }
    
    return _customBarTintColorDictionary;
}

- (NSMutableDictionary *)viewControllersBarTintColorDictionary {
    if (_viewControllersBarTintColorDictionary == nil) {
        _viewControllersBarTintColorDictionary = [NSMutableDictionary dictionary];
    }
    
    return _viewControllersBarTintColorDictionary;
}

- (NSMutableDictionary *)customTintColorDictionary {
    if (_customTintColorDictionary == nil) {
        _customTintColorDictionary = [NSMutableDictionary dictionary];
    }
    
    return _customTintColorDictionary;
}

- (NSMutableDictionary *)viewControllersTintColorDictionary {
    if (_viewControllersTintColorDictionary == nil) {
        _viewControllersTintColorDictionary = [NSMutableDictionary dictionary];
    }
    
    return _viewControllersTintColorDictionary;
}

- (NSMutableDictionary *)customIsHideBottomlineDictionary {
    if (_customIsHideBottomlineDictionary == nil) {
        _customIsHideBottomlineDictionary = [NSMutableDictionary dictionary];
    }
    return _customIsHideBottomlineDictionary;
}

- (NSMutableDictionary *)viewControllersIsHideBottomlineDictionary {
    if (_viewControllersIsHideBottomlineDictionary == nil) {
        _viewControllersIsHideBottomlineDictionary = [NSMutableDictionary dictionary];
    }
    return _viewControllersIsHideBottomlineDictionary;
}


#pragma mark - 确保使用者自定义的状态栏属性能挺过父子控制器正确传递
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

@end
