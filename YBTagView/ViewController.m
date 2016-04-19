//
//  ViewController.m
//  YBTagView
//
//  Created by 王迎博 on 16/3/28.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "ViewController.h"
#import "YBTagHeader.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
    [self.imageView addGestureRecognizer:tapGestureRecognizer];
}

/**
 *  根据触摸位置，返回一个点，根据点来确定标签位置
 */
- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer
{
    CGPoint point = [tapGestureRecognizer locationInView:tapGestureRecognizer.view];
    
//    NSLog(@"开始位置：%@",NSStringFromCGPoint(point));
    YBTagView *tagView = [[YBTagView alloc]initWithPoint:point];
    tagView.block = ^(NSString *gestureString){
        NSLog(@"......%@",gestureString);
        SHOW_ALTER(gestureString);
    };
    [self.imageView addSubview:tagView];
    tagView.tagArray = @[@"可儿购",@"面膜",@"￥500.00",@"中国"];//@"可儿购",@"面膜",@"￥500.00",@"中国"
    
}

@end
