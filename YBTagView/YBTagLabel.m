//
//  YBTagLabel.m
//  YBTagView
//
//  Created by 王迎博 on 16/3/28.
//  Copyright © 2016年 王迎博. All rights reserved.
//
#import "YBTagLabel.h"
#import "YBTagHeader.h"

#define lineH 1

@implementation YBTagLabel

- (instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string
{
    if (self = [super initWithFrame:frame]) {
        
        //用Attribute添加带下划线的label
//        [self addAttributeLabelWithStr:string];
        
        //直接在label上加线
        [self addLineLabelWithStr:string withFrame:frame];
        
        //添加点击手势
        YBTagGestureRecognizer *gesture = [[YBTagGestureRecognizer alloc]initWithTarget:self action:@selector(tagGesture:)];
        gesture.gestureString = string;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:gesture];
    }
    
    return self;
}



- (void)tagGesture:(YBTagGestureRecognizer *)gesture
{
    NSLog(@"........手势方法");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagLabelDelegateMethod:)]) {
        
        [self.delegate tagLabelDelegateMethod:gesture.gestureString];
    }
    
    //TODO: 通知第一步
//    NSDictionary *text =[[NSDictionary alloc] initWithObjectsAndKeys:gesture.gestureString,@"gestureString",nil];
//    NSNotification *notification =[NSNotification notificationWithName:@"noticeMethod" object:self userInfo:text];
    //TODO: 通知第二步
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
}




/**
 *  用Attribute添加带下划线的label
 */
- (void)addAttributeLabelWithStr:(NSString *)string
{
    self.backgroundColor = [UIColor redColor];
    self.numberOfLines = 1;
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange contentRange = NSMakeRange(0, [content length]);
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    self.attributedText = content;
}

/**
 *  直接在label上加线
 */
- (void)addLineLabelWithStr:(NSString *)string  withFrame:(CGRect)frame
{
    
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:12.0];
    
    _selfW = frame.size.width;
    _selfStr = string;

}



- (void)delay
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.text = _selfStr;
    } completion:^(BOOL finished) {
        
    }];
}
@end
