//
//  YBTagStyle.h
//  YBTagView
//
//  Created by 王迎博 on 16/3/29.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, YBFourTagStyle) {
    YBFourTagStyleZeroLeft = 0,
    YBFourTagStyleOneLeft,
    YBFourTagStyleTwoLeft,
    YBFourTagStyleThreeLeft,
    YBFourTagStyleAllLeft,
};

typedef NS_ENUM(NSInteger, YBThreeTagStyle) {
    YBThreeTagStyleZeroLeft = 0,
    YBThreeTagStyleOneLeft,
    YBThreeTagStyleTwoLeft,
    YBThreeTagStyleAllLeft,
};

typedef NS_ENUM(NSInteger, YBTwoTagStyle) {
    YBTwoTagStyleBothRightAskew = 0,
    YBTwoTagStyleBothLeftAskew,
    YBTwoTagStyleBothLeftVertical,
    YBTwoTagStyleBothRightVertical,
};

typedef NS_ENUM(NSInteger, YBOneTagStyle) {
    YBOneTagStyleRightAskew=0,
    YBOneTagStyleLeftAskew,
    YBOneTagStyleLeftVertical,
    YBOneTagStyleRightVertical,
};


@interface YBTagStyle : NSObject

@property (nonatomic, assign) YBFourTagStyle YBFourTagStyle;
@property (nonatomic, assign) YBThreeTagStyle YBThreeTagStyle;
@property (nonatomic, assign) YBTwoTagStyle YBTwoTagStyle;
@property (nonatomic, assign) YBOneTagStyle YBOneTagStyle;

@end
