//
//  UIViewController+PANavigationControllerCategory.m
//  PANavigationControllerDemo
//
//  Created by 彦明 on 2016/12/21.
//  Copyright © 2016年 Yanming. All rights reserved.
//
#import <objc/runtime.h>
#import "UIViewController+PANavigationControllerCategory.h"

@implementation UIViewController (PANavigationControllerCategory)
- (PANavigationViewController *)pa_navigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setPa_navigationController:(PANavigationViewController *)pa_navigationController {
    objc_setAssociatedObject(self, @selector(pa_navigationController), pa_navigationController, OBJC_ASSOCIATION_ASSIGN);
}

@end
