//
//  YMBaseNavigationController.m
//
//  Created by 樊彦明 on 2019/6/27.
//

#import "YMBaseNavigationController.h"

#pragma mark - wrapper navi view controller

@interface YMWrapperNavigationController: UINavigationController
@property (nonatomic, weak) UIButton *backButton;
@end

@implementation YMWrapperNavigationController
+ (void)initialize {
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[YMBaseNavigationController class]]] setBackgroundImage:[UIImage new] forBarMetrics:(UIBarMetricsDefault)];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar addObserver:self forKeyPath:@"tintColor" options:(NSKeyValueObservingOptionNew) context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"tintColor"] && self.navigationController.viewControllers.count>1) {
        self.topViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self backButtonWithColor:self.topViewController.navigationController.navigationBar.tintColor]];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    YMWrapperViewController *wrapperVC = [YMWrapperViewController wrapViewController:viewController];
    [self.navigationController pushViewController:wrapperVC animated:YES];
    if (self.navigationController.viewControllers.count>1) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self backButtonWithColor:viewController.navigationController.navigationBar.tintColor?:[UIColor whiteColor]]];
    }

}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
}

- (void)backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc {
    [self.navigationBar removeObserver:self forKeyPath:@"tintColor"];
}

- (UIView *)backButtonWithColor:(UIColor *)color {
    
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backButton.frame = CGRectMake(0, 0, 44, 44);
    
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
    
    [backButton addSubview:backArrowView];
    [backButton addTarget:self action:@selector(backButtonClicked) forControlEvents:(UIControlEventTouchUpInside)];
    
    return backButton;
}

#pragma mark - 确保使用者自定义的状态栏属性能通过父子控制器正确传递
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForHomeIndicatorAutoHidden {
    return self.topViewController;
}

@end


#pragma mark - wrapper view controller


@implementation YMWrapperViewController


+ (YMWrapperViewController *)wrapViewController:(UIViewController *)viewController{
    
    // 先包装导航控制器
    YMWrapperNavigationController *wrapperNavigationVC = [[YMWrapperNavigationController alloc] init];
    wrapperNavigationVC.viewControllers = @[viewController];
    
    // 包装一层view controller
    YMWrapperViewController *wrapperVC = [[YMWrapperViewController alloc] init];
    [wrapperVC addChildViewController:wrapperNavigationVC];
    [wrapperVC.view addSubview:wrapperNavigationVC.view];
    
    return wrapperVC;
    
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.childViewControllers.firstObject;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.childViewControllers.firstObject;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
    
}

- (UIViewController *)childViewControllerForHomeIndicatorAutoHidden {
    return self.childViewControllers.lastObject;
}

- (BOOL)hidesBottomBarWhenPushed {
    return self.childViewControllers.firstObject.hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return self.childViewControllers.firstObject.tabBarItem;
}

- (NSString *)title {
    NSLog(@"self.childViewControllers.firstObject:%@",self.childViewControllers.firstObject);
    return self.childViewControllers.firstObject.title;
}

@end


#pragma mark - base navigation view controller

@interface YMBaseNavigationController()
@property (strong, nonatomic) NSMutableArray *barTintColorsArray;
@property (strong, nonatomic) NSMutableArray *tintColorsArray;
@end
@implementation YMBaseNavigationController


UIColor *_globalBarTintColor = nil;
UIColor *_globalTintColor = nil;

UIColor *_barTintColorAtIndex = nil;
UIColor *_tintColorAtIndex = nil;
NSInteger _barTintColorIndex;
NSInteger _tintColorIndex = -1;


+ (void)setGlobalBarTintColor:(UIColor *)color {
    _globalBarTintColor = color;
}

+ (void)setGlobalTintColor:(UIColor *)color {
    _globalTintColor = color;
}

+ (void)setBarTintColor:(UIColor *)color atIndex:(NSInteger)index {
    _barTintColorAtIndex = color;
    _barTintColorIndex = index;
}

+ (void)setTintColor:(UIColor *)color atIndex:(NSInteger)index {
    _tintColorAtIndex = color;
    _tintColorIndex = index;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        self.viewControllers = @[[YMWrapperViewController wrapViewController:rootViewController]];
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController.childViewControllers.firstObject isKindOfClass:[YMWrapperNavigationController class]]) {
        
        YMWrapperNavigationController *wrapperNavigationVC = viewController.childViewControllers.firstObject;
        
        if (_globalBarTintColor) {
            [wrapperNavigationVC.navigationBar setBarTintColor:_globalBarTintColor];
        }
        
        if (_globalTintColor) {
            [wrapperNavigationVC.navigationBar setTintColor:_globalTintColor];
        }
        
        if (_barTintColorIndex > -1) {
            if (self.viewControllers.count == _barTintColorIndex) {
                [wrapperNavigationVC.navigationBar setBarTintColor:_barTintColorAtIndex];
            }
        }
        
        if (_tintColorIndex > -1) {
            if (self.viewControllers.count == _tintColorIndex) {
                [wrapperNavigationVC.navigationBar setTintColor:_tintColorAtIndex];
            }
        }
    }
    
    
    if (self.viewControllers.count>0) {
        viewController.childViewControllers.firstObject.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果是根控制, 无需再有滑动返回
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    self.interactivePopGestureRecognizer.enabled = !isRootVC;
}

#pragma mark - 确保使用者自定义的状态栏属性能通过父子控制器正确传递
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForHomeIndicatorAutoHidden {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}


@end
