//
//  YBCenterView.m
//  YBTagView
//
//  Created by 王迎博 on 16/3/28.
//  Copyright © 2016年 王迎博. All rights reserved.
//
#import "YBCenterView.h"
#import "YBTagHeader.h"

@interface YBCenterView ()

@property (nonatomic, strong) YBFocusLayer *focusLayer;


@end


@implementation YBCenterView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.button.frame = self.bounds;
    
    static CGFloat width = 8;
    static CGFloat height = 8;
    CGRect rect = CGRectMake(self.bounds.size.width/2 - width/2, self.bounds.size.height/2 - height/2, width, height);
    self.imageView.frame = rect;
//    NSLog(@"..............%@",NSStringFromCGRect(self.imageView.frame));
    
    //CGPoint point = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
//    _imageView.center = point;
}



- (void)setup
{
    [self.layer addSublayer:self.focusLayer];
    [self addSubview:self.button];
    
    _imageView = [[UIImageView alloc]init];
    UIImage *image = [self OriginImage:[UIImage imageNamed:@"yuandian"] scaleToSize:CGSizeMake(10, 10)];
    [_imageView setImage:image];
    [self addSubview:self.imageView];
}





- (void)show
{
    self.alpha = 1.0;
}



- (void)dismiss
{
    self.alpha = 0.0;
}

- (void)startAnimation
{
    [self.focusLayer startAnimation];
}



- (void)stopAnimation
{
    [self.focusLayer stopAnimation];
}



- (YBFocusLayer *)focusLayer
{
    if (!_focusLayer) {
        _focusLayer = [YBFocusLayer new];
        _focusLayer.fromValueForRadius = 0.35;
        _focusLayer.position = [self tagCenterPoint];
    }
    return _focusLayer;
}



- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        //UIImage *image = [self OriginImage:[UIImage imageNamed:@"yuandian"] scaleToSize:CGSizeMake(100, 100)];
        //[_button setBackgroundImage:image forState:UIControlStateNormal];
        //[_button setImage:[UIImage imageNamed:@"yuandian"] forState:UIControlStateNormal];
        
    }
    return _button;
}


- (CGPoint)tagCenterPoint
{
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    return center;
}

/**
 *  ios 改变图片大小缩放方法
 *
 *  @param image 需要改变的图片，传入进来
 *  @param size  需要改变成的尺寸
 *
 *  @return 返回修改后的图片
 */
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}


@end
