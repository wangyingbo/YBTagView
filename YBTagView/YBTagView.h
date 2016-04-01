//
//  YBTagView.h
//  YBTagView
//
//  Created by 王迎博 on 16/3/28.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TagViewW  150 //标签底部view的宽
#define TagViewH  100 //标签底部view的高
#define TagLabelH 30 // 标签上文字label的高
#define CenterViewW 30 //中心点按钮的宽
#define CenterViewH 30 //中心点按钮的高
#define space 10  //从中心点到label之间的间隔距离
#define threeTagSpace 5 // 同上
#define perLabelH 40 //文字label的高
#define addLabelW 5 //

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
