//
//  UIView+YMEasyFrame.m
//
//  Created by 樊彦明 on 15/8/15.
//  Copyright (c) 2015年 Yeahming. All rights reserved.
//

#import "UIView+YMEasyFrame.h"

@implementation UIView (YMEasyFrame)
/***********setter**************/
- (void)setYm_x:(CGFloat)X
{
    CGRect frame = self.frame;
    frame.origin.x = X;
    self.frame = frame;
}

- (void)setYm_y:(CGFloat)Y
{
    CGRect frame = self.frame;
    frame.origin.y = Y;
    self.frame = frame;
}
- (void)setYm_width:(CGFloat)Width
{
    CGRect frame = self.frame;
    frame.size.width = Width;
    self.frame = frame;
}
-(void)setYm_height:(CGFloat)Height
{
    CGRect frame = self.frame;
    frame.size.height = Height;
    self.frame = frame;

}
-(void)setYm_centerX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}

- (void)setYm_centerY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

/***********getter**************/
-(CGFloat)ym_x
{
    return self.frame.origin.x;
}

-(CGFloat)ym_y
{
    return self.frame.origin.y;
}

-(CGFloat)ym_width
{
    return self.frame.size.width;
}

- (CGFloat)ym_height
{
    return self.frame.size.height;
}
-(CGFloat)ym_centerX
{
    return self.center.x;
}
-(CGFloat)ym_centerY
{
    return self.center.y;
}
@end
