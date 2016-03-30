//
//  YBTagView.h
//  YBTagView
//
//  Created by 王迎博 on 16/3/28.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TagViewW  150
#define TagViewH  100
#define TagLabelH 25
#define CenterViewW 30
#define CenterViewH 30
#define space 10
#define perLabelH 40

@interface YBTagView : UIView

/**按住拖动手势*/
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
/**是否打开按住拖动功能*/
@property (nonatomic, assign) BOOL isPanGestureOnTagViewed;
/**tag的数组*/
@property (nonatomic, strong) NSArray *tagArray;

@property (nonatomic, assign) CGPoint tagViewCenterPoint;

@property (nonatomic, assign) CGPoint selfCenter;
/**
 *  根据点来确定加上的标签页
 */
- (instancetype)initWithPoint:(CGPoint)point;

@end
