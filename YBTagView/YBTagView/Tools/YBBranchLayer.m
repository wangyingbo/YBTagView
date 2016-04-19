//
//  YBBranchLayer.m
//  YBTagView
//
//  Created by 王迎博 on 16/3/29.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "YBBranchLayer.h"

@implementation YBBranchLayer
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup {
    self.strokeStart = 0;
    self.strokeEnd = 1;
    
    self.lineWidth = 1.0;
    
    self.strokeColor = [UIColor whiteColor].CGColor;
    self.fillColor = [UIColor clearColor].CGColor;
}


- (void)commitPathWithStartPoint:(CGPoint)startPoint midPoint:(CGPoint)midPoint endPoint:(CGPoint)endPoint withBlock:(void(^)(CGFloat time))block
{
    //隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction commit];
    
    self.path = nil;
    self.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:startPoint];
    [path addLineToPoint:midPoint];
    [path addLineToPoint:endPoint];
    
    //[path closePath];
    self.path = path.CGPath;
    
    //添加动画
    CGFloat time = 1.0;//动画时间
    _animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    _animation.delegate = self;
    _animation.fromValue = @(0);
    _animation.toValue = @(1);
    _animation.duration = time;
    _animation.fillMode = kCAFillModeForwards;
    _animation.removedOnCompletion = NO;
    [self addAnimation:_animation forKey:@"strokeEnd"];
    
    block(time);
    
}






@end
