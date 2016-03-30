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
    }
    
    return self;
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
