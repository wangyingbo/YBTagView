//
//  YBTagView.m
//  YBTagView
//
//  Created by 王迎博 on 16/3/28.
//  Copyright © 2016年 王迎博. All rights reserved.
//
#import "YBCenterView.h"
#import "YBTagHeader.h"



@interface YBTagView ()
{
    BOOL isDefault;
}
@property (nonatomic, strong) NSMutableArray *tagWMutArr;

@property (nonatomic, strong) YBTagLabel *tagOne;
@property (nonatomic, strong) YBTagLabel *tagTwo;
@property (nonatomic, strong) YBTagLabel *tagThree;
@property (nonatomic, strong) YBTagLabel *tagFour;

@property (nonatomic, strong) YBBranchLayer *tagBranchOne;
@property (nonatomic, strong) YBBranchLayer *tagBranchTwo;
@property (nonatomic, strong) YBBranchLayer *tagBranchThree;
@property (nonatomic, strong) YBBranchLayer *tagBranchFour;

@property (nonatomic, strong) YBCenterView *tagCenterView;

/**4个tag的时候默认启动顺序*/
@property (nonatomic, assign) NSInteger buttonFourTag;
/**3个tag的时候默认启动顺序*/
@property (nonatomic, assign) NSInteger buttonThirdTag;


@end

@implementation YBTagView

- (instancetype)initWithPoint:(CGPoint)point
{
    self = [super init];
    if (self)
    {
        self.width = TagViewW;
        self.height = TagViewH;
        self.center = point;
        _selfCenter = point;
        
//        self.backgroundColor = [UIColor lightGrayColor];
        self.isPanGestureOnTagViewed = YES;
        
        _buttonFourTag = 2;//4个tag的时候默认启动的顺序
        isDefault = YES;
        _buttonThirdTag = 0;//3个tag的时候默认启动的顺序
    }
    
    return self;
}


- (void)setTagArray:(NSArray *)tagArray
{
    
    
    //获取tag标签字符串的长度
    _tagArray = tagArray;
    NSMutableArray *mutArr = [NSMutableArray array];
    for (int i = 0; i < _tagArray.count; i ++)
    {
        NSString *string = [_tagArray objectAtIndex:i];
        CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0],NSFontAttributeName, nil]];
        //名字的H
        //CGFloat tagStringH = size.height;
        //名字的W
        CGFloat tagStringW = size.width;
        NSString *tagW = [NSString stringWithFormat:@"%f",tagStringW];
        [mutArr addObject:tagW];
    }
    _tagWMutArr = mutArr;

    [self addTag];//默认启动的顺序
}


/**
 *  检查在添加tag的时候是否超出了显示范围，如果超出，移动进显示范围内
 */
- (void)checkIsOut
{
    CGPoint point = self.center;
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
    
    top = point.y - self.height/2;
    bottom = (self.superview.height - point.y) - self.height/2;
    if (point.y < self.superview.height/2)//顶部超出范围时
    {
        if (top < 0)
        {
            point.y += ABS(top);
        }
        
    }else//底部超出范围时
    {
        if (bottom < 0)
        {
            point.y -= ABS(bottom);
        }
    }
    
    left = point.x - self.width/2;
    right =(self.superview.width - point.x) - self.width/2;
    if (point.x < self.superview.width/2)//左边超出范围时
    {
        if (left < 0)
        {
            point.x += ABS(left);
        }
        
    }else//右边超出范围时
    {
        if (right < 0)
        {
            point.x -= ABS(right);
        }
    }
    
    if (point.x == self.center.x && point.y == self.center.y) {
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.center = point;
            
            _selfCenter = point;
        }];
    }
}


/**
 *  根据数组元素数目，决定添加多少个tag
 */
- (void)addTag
{
    if (_tagArray.count == 4)
    {
        [self addFourTag:YBFourTagStyleTwoLeft];//4个tag的时候默认启动的顺序
        
    }else if (_tagArray.count == 3)
    {
        [self addThirdTag:YBThreeTagStyleZeroLeft];
        
    }else if (_tagArray.count == 2)
    {
        
        
    }else
    {
        
    }
}

/**
 *  添加有3个分支tag的标签
 */
- (void)addThirdTag:(YBThreeTagStyle)tagStyle
{
    //获得tag上文字的最大宽度
    CGFloat mostW = 0;
    for (NSString *string in _tagWMutArr)
    {
        CGFloat tagW = [string floatValue];
        if (tagW - mostW > 0)
        {
            mostW = tagW;
        }
    }
    
    NSString *tagWStr;
    CGFloat tagW0 = 0;
    CGFloat tagW1 = 0;
    CGFloat tagW2 = 0;
    for (int i = 0; i < _tagWMutArr.count; i ++) {
        tagWStr = [_tagWMutArr objectAtIndex:i];
        if (i == 0) {
            tagW0 = [tagWStr floatValue];
        }else if (i == 1)
        {
            tagW1 = [tagWStr floatValue];
        }else if (i == 2){
            tagW2 = [tagWStr floatValue];
        }
    }

    if (isDefault)
    {
        CGFloat selfW = mostW + CenterViewW;
        CGFloat selfH = TagLabelH * 3;
        self.width = selfW;
        self.height = selfH;
        CGPoint point = CGPointMake(_selfCenter.x + self.width/2 - CenterViewW/2, _selfCenter.y - TagLabelH*0.5);
        self.center = point;
        //检查是否拖动出界
        [self checkIsOut];
        
        YBCenterView *centerView = [[YBCenterView alloc]initWithFrame:CGRectMake(0, TagLabelH*1.5-3, CenterViewW, CenterViewH)];//self.width - mostW - CenterViewW/2 - 30
        _tagViewCenterPoint = centerView.center;
        [centerView.button addTarget:self action:@selector(thirdTagChangeState:) forControlEvents:UIControlEventTouchUpInside];
        [centerView startAnimation];
        [self addSubview:centerView];
        _tagCenterView = centerView;
        
        for (int i = 0; i < _tagArray.count; i ++)
        {
            CGFloat tagW = [[_tagWMutArr objectAtIndex:i] floatValue] + 5;
            NSString *tagString = [_tagArray objectAtIndex:i];
            
            YBTagLabel *label = [[YBTagLabel alloc]initWithFrame:CGRectMake(CenterViewW/2, TagLabelH*i, tagW, TagLabelH) withString:tagString];
            [self addSubview:label];
            
            label.leftPoint = CGPointMake(label.x, label.y + label.height - 0.5);
            label.rightPoint = CGPointMake(label.x + label.width, label.y + label.height);
            YBBranchLayer *branch = [[YBBranchLayer alloc]init];
            [branch commitPathWithStartPoint:_tagViewCenterPoint midPoint:label.leftPoint endPoint:label.rightPoint withBlock:^(CGFloat time) {
                CGFloat timeF = time;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeF * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [label delay];
                });
            }];
            [self.layer addSublayer:branch];
            
            if (i == 0) {
                _tagOne = label;
                _tagBranchOne = branch;
            }else if (i == 1)
            {
                _tagTwo = label;
                _tagBranchTwo = branch;
            }else if (i == 2)
            {
                _tagThree = label;
                _tagBranchThree = branch;
            }
        }
    
        isDefault = NO;
    }else
    {
        switch (tagStyle) {
            case YBThreeTagStyleZeroLeft:
                
                break;
            case YBThreeTagStyleOneLeft:
                
                break;
            case YBThreeTagStyleTwoLeft:
                
                break;
            case YBThreeTagStyleAllLeft:
                
                break;
                
            default:
                break;
        }
 
    }
    
}

/**
 *  3个tag的时候改变标签状态
 */
- (void)thirdTagChangeState:(UIButton *)button
{
    _buttonThirdTag ++;
    if (_buttonThirdTag == 4) {
        _buttonThirdTag = 0;
    }
    
    switch (_buttonThirdTag) {
        case YBThreeTagStyleZeroLeft:
            NSLog(@"0个在左边");
            break;
        case YBThreeTagStyleOneLeft:
            NSLog(@"1个在左边，两个右边");
            break;
        case YBThreeTagStyleTwoLeft:
            NSLog(@"2个在左边,1个在右边");
            break;
        case YBThreeTagStyleAllLeft:
            NSLog(@"都在左边");
            break;
            
        default:
            break;
    }
}



/**
 *  添加有四个tag的标签
 */
- (void)addFourTag:(YBFourTagStyle)tagStyle
{
    //获得tag上文字的最大宽度
    CGFloat mostW = 0;
    for (NSString *string in _tagWMutArr)
    {
        CGFloat tagW = [string floatValue];
        if (tagW - mostW > 0)
        {
            mostW = tagW;
        }
    }
    
    NSString *tagWStr;
    CGFloat tagW0 = 0;
    CGFloat tagW1 = 0;
    CGFloat tagW2 = 0;
    CGFloat tagW3 = 0;
    for (int i = 0; i < _tagWMutArr.count; i ++) {
        tagWStr = [_tagWMutArr objectAtIndex:i];
        if (i == 0) {
            tagW0 = [tagWStr floatValue];
        }else if (i == 1)
        {
            tagW1 = [tagWStr floatValue];
        }else if (i == 2){
            tagW2 = [tagWStr floatValue];
        }else if (i == 3)
        {
            tagW3 = [tagWStr floatValue];
        }
    }
    
    switch (tagStyle)
    {
        case YBFourTagStyleZeroLeft:
        {
//            NSLog(@"全部都在右边");
            [self dismiss];
            CGFloat selfW = mostW + CenterViewW + space;
            CGFloat selfH = TagLabelH * 4;
            self.width = selfW;
            self.height = selfH;
            CGPoint point = CGPointMake(_selfCenter.x + self.width/2- CenterViewW/2, _selfCenter.y-TagLabelH/2);
            self.center = point;
            //检查是否拖动出界
            [self checkIsOut];
            
            YBCenterView *centerView = [[YBCenterView alloc]initWithFrame:CGRectMake(0, TagLabelH*2.5- CenterViewH/2, CenterViewW, CenterViewH)];//self.width - mostW - CenterViewW/2 - 30
            _tagViewCenterPoint = centerView.center;
            [centerView.button addTarget:self action:@selector(fourTagChangeState:) forControlEvents:UIControlEventTouchUpInside];
            [centerView startAnimation];
            [self addSubview:centerView];
            _tagCenterView = centerView;
            
            for (int i = 0; i < _tagArray.count; i ++)
            {
                CGFloat tagW = [[_tagWMutArr objectAtIndex:i] floatValue];
                NSString *tagString = [_tagArray objectAtIndex:i];
                YBTagLabel *label = [[YBTagLabel alloc]initWithFrame:CGRectMake(self.width - mostW, TagLabelH*i, tagW, TagLabelH) withString:tagString];
                [self addSubview:label];
                
                label.leftPoint = CGPointMake(label.x, label.y + label.height - 0.5);
                label.rightPoint = CGPointMake(label.x + label.width, label.y + label.height);
                YBBranchLayer *branch = [[YBBranchLayer alloc]init];
                [branch commitPathWithStartPoint:_tagViewCenterPoint midPoint:label.leftPoint endPoint:label.rightPoint withBlock:^(CGFloat time) {
                    CGFloat timeF = time;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeF * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [label delay];
                    });
                }];
                //NSLog(@"******%@",NSStringFromCGPoint(_tagViewCenterPoint));
                [self.layer addSublayer:branch];
                
                if (i == 0) {
                    _tagOne = label;
                    _tagBranchOne = branch;
                }else if (i == 1)
                {
                    _tagTwo = label;
                    _tagBranchTwo = branch;
                }else if (i == 2)
                {
                    _tagThree = label;
                    _tagBranchThree = branch;
                }else if (i == 3)
                {
                    _tagFour = label;
                    _tagBranchFour = branch;
                }
            }
        }
            break;
        case YBFourTagStyleOneLeft:
        {
//            NSLog(@"只有一个在左边，三个在右边");
            [self dismiss];
            CGFloat selfW = mostW * 2 + CenterViewW + space * 2;
            CGFloat selfH = TagLabelH * 3;
            self.width = selfW;
            self.height = selfH;
            self.center = _selfCenter;
            [self checkIsOut];
            
            YBCenterView *centerView = [[YBCenterView alloc]initWithFrame:CGRectMake(self.width/2-CenterViewW/2, self.height/2 - CenterViewH/2, CenterViewW, CenterViewH)];
            _tagViewCenterPoint = centerView.center;
            [centerView.button addTarget:self action:@selector(fourTagChangeState:) forControlEvents:UIControlEventTouchUpInside];
            [centerView startAnimation];
            [self addSubview:centerView];
            _tagCenterView = centerView;

            for (int i = 0; i < _tagArray.count; i ++)
            {
                CGFloat tagW = [[_tagWMutArr objectAtIndex:i] floatValue];
                NSString *tagString = [_tagArray objectAtIndex:i];
                
                if (i == 0) {
                    YBTagLabel *label = [[YBTagLabel alloc]initWithFrame:CGRectMake(self.width/2-CenterViewW/2-space-tagW0, TagLabelH*1.5, tagW, TagLabelH) withString:tagString];
                    [self addSubview:label];
                    
                    label.leftPoint = CGPointMake(label.x, label.y + label.height - 0.5);
                    label.rightPoint = CGPointMake(label.x + label.width, label.y + label.height);
                    YBBranchLayer *branch = [[YBBranchLayer alloc]init];
                    [branch commitPathWithStartPoint:_tagViewCenterPoint midPoint:label.rightPoint endPoint:label.leftPoint withBlock:^(CGFloat time) {
                        CGFloat timeF = time;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeF * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [label delay];
                        });
                    }];
                    //NSLog(@"******%@",NSStringFromCGPoint(_tagViewCenterPoint));
                    [self.layer addSublayer:branch];
                    
                    _tagOne = label;
                    _tagBranchOne = branch;
                    
                }else{
                    YBTagLabel *label = [[YBTagLabel alloc]initWithFrame:CGRectMake(self.width/2+CenterViewW/2+space, TagLabelH*(i-1), tagW, TagLabelH) withString:tagString];
                    [self addSubview:label];
                    
                    label.leftPoint = CGPointMake(label.x, label.y + label.height - 0.5);
                    label.rightPoint = CGPointMake(label.x + label.width, label.y + label.height);
                    YBBranchLayer *branch = [[YBBranchLayer alloc]init];
                    [branch commitPathWithStartPoint:_tagViewCenterPoint midPoint:label.leftPoint endPoint:label.rightPoint withBlock:^(CGFloat time) {
                        CGFloat timeF = time;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeF * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [label delay];
                        });
                    }];
                    //NSLog(@"******%@",NSStringFromCGPoint(_tagViewCenterPoint));
                    [self.layer addSublayer:branch];
                    if (i == 1)
                    {
                        _tagTwo = label;
                        _tagBranchTwo = branch;
                    }else if (i == 2)
                    {
                        _tagThree = label;
                        _tagBranchThree = branch;
                    }else if (i == 3)
                    {
                        _tagFour = label;
                        _tagBranchFour = branch;
                    }

                }
            }//

        }
            break;
        case YBFourTagStyleTwoLeft:
        {
//            NSLog(@"两个在左边，两个在右边");
            [self dismiss];
            CGFloat selfW = mostW * 2 + CenterViewW + space * 2;
            CGFloat selfH = TagLabelH * 3.5;
            self.width = selfW;
            self.height = selfH;
            CGPoint point = CGPointMake(_selfCenter.x, _selfCenter.y);//TagLabelH/2
            self.center = point;
            [self checkIsOut];
            
            YBCenterView *centerView = [[YBCenterView alloc]initWithFrame:CGRectMake(self.width/2-CenterViewW/2, self.height/2 - CenterViewH/2, CenterViewW, CenterViewH)];
            _tagViewCenterPoint = centerView.center;
            [centerView.button addTarget:self action:@selector(fourTagChangeState:) forControlEvents:UIControlEventTouchUpInside];
            [centerView startAnimation];
            [self addSubview:centerView];
            _tagCenterView = centerView;
            
            for (int i = 0; i < _tagArray.count; i ++)
            {
                CGFloat tagW = [[_tagWMutArr objectAtIndex:i] floatValue];
                NSString *tagString = [_tagArray objectAtIndex:i];
                
                if (i < 2)
                {
                    YBTagLabel *label = [[YBTagLabel alloc]initWithFrame:CGRectMake(self.width/2 - CenterViewW/2-space -tagW, (TagLabelH*1.5)*i, tagW, TagLabelH) withString:tagString];
                    [self addSubview:label];
                    label.leftPoint = CGPointMake(label.x, label.y + label.height - 0.5);
                    label.rightPoint = CGPointMake(label.x + label.width, label.y + label.height);
                    YBBranchLayer *branch = [[YBBranchLayer alloc]init];
                    [branch commitPathWithStartPoint:_tagViewCenterPoint midPoint:label.rightPoint endPoint:label.leftPoint withBlock:^(CGFloat time) {
                        CGFloat timeF = time;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeF * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [label delay];
                        });
                    }];
                    
                    [self.layer addSublayer:branch];
                    
                    if (i == 0)
                    {
                        _tagOne = label;
                        _tagBranchOne = branch;
                    }else if (i == 1)
                    {
                        _tagTwo = label;
                        _tagBranchTwo = branch;
                    }
                }
                
                
                if (i > 1 && i < 4)
                {
                    YBTagLabel *label = [[YBTagLabel alloc]initWithFrame:CGRectMake(self.width/2 +CenterViewW/2 + space, (TagLabelH*1.5)*(i - 2), tagW, TagLabelH) withString:tagString];
                    [self addSubview:label];
                    label.leftPoint = CGPointMake(label.x, label.y + label.height - 0.5);
                    label.rightPoint = CGPointMake(label.x + label.width, label.y + label.height);
                    YBBranchLayer *branch = [[YBBranchLayer alloc]init];
                    [branch commitPathWithStartPoint:_tagViewCenterPoint midPoint:label.leftPoint endPoint:label.rightPoint withBlock:^(CGFloat time) {
                        CGFloat timeF = time;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeF * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [label delay];
                        });
                    }];
                    
                    [self.layer addSublayer:branch];
                    
                    if (i == 2)
                    {
                        _tagThree = label;
                        _tagBranchThree = branch;
                    }else if (i == 3)
                    {
                        _tagFour = label;
                        _tagBranchFour = branch;
                    }
                }
                
            }

        }
            break;
        case YBFourTagStyleThreeLeft:
        {
//            NSLog(@"三个在左边，一个在右边");
            [self dismiss];
            CGFloat selfW = mostW * 2 + CenterViewW + space * 2;
            CGFloat selfH = TagLabelH * 3;
            self.width = selfW;
            self.height = selfH;
            self.center = _selfCenter;
            
            YBCenterView *centerView = [[YBCenterView alloc]initWithFrame:CGRectMake(self.width/2-CenterViewW/2, self.height/2 - CenterViewH/2, CenterViewW, CenterViewH)];
            _tagViewCenterPoint = centerView.center;
            [centerView.button addTarget:self action:@selector(fourTagChangeState:) forControlEvents:UIControlEventTouchUpInside];
            [centerView startAnimation];
            [self addSubview:centerView];
            _tagCenterView = centerView;
            
            for (int i = 0; i < _tagArray.count; i ++)
            {
                CGFloat tagW = [[_tagWMutArr objectAtIndex:i] floatValue];
                NSString *tagString = [_tagArray objectAtIndex:i];
                
                if (i == 3) {
                    YBTagLabel *label = [[YBTagLabel alloc]initWithFrame:CGRectMake(self.width/2+CenterViewW/2+space, TagLabelH*1.5, tagW, TagLabelH) withString:tagString];
                    [self addSubview:label];
                    
                    label.leftPoint = CGPointMake(label.x, label.y + label.height - 0.5);
                    label.rightPoint = CGPointMake(label.x + label.width, label.y + label.height);
                    YBBranchLayer *branch = [[YBBranchLayer alloc]init];
                    [branch commitPathWithStartPoint:_tagViewCenterPoint midPoint:label.leftPoint endPoint:label.rightPoint withBlock:^(CGFloat time) {
                        CGFloat timeF = time;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeF * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [label delay];
                        });
                    }];
                    //NSLog(@"******%@",NSStringFromCGPoint(_tagViewCenterPoint));
                    [self.layer addSublayer:branch];
                    
                    _tagFour = label;
                    _tagBranchFour = branch;
                    
                }else{
                    YBTagLabel *label = [[YBTagLabel alloc]initWithFrame:CGRectMake(self.width/2-CenterViewW/2-space-tagW, TagLabelH*i, tagW, TagLabelH) withString:tagString];
                    [self addSubview:label];
                    
                    label.leftPoint = CGPointMake(label.x, label.y + label.height - 0.5);
                    label.rightPoint = CGPointMake(label.x + label.width, label.y + label.height);
                    YBBranchLayer *branch = [[YBBranchLayer alloc]init];
                    [branch commitPathWithStartPoint:_tagViewCenterPoint midPoint:label.rightPoint endPoint:label.leftPoint withBlock:^(CGFloat time) {
                        CGFloat timeF = time;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeF * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [label delay];
                        });
                    }];
                    //NSLog(@"******%@",NSStringFromCGPoint(_tagViewCenterPoint));
                    [self.layer addSublayer:branch];
                    if (i == 0)
                    {
                        _tagOne = label;
                        _tagBranchOne = branch;
                    }else if (i == 1)
                    {
                        _tagTwo = label;
                        _tagBranchTwo = branch;
                    }else if (i == 2)
                    {
                        _tagThree = label;
                        _tagBranchThree = branch;
                    }
                    
                }
            }//
        }
            break;
        case YBFourTagStyleAllLeft:
        {
//            NSLog(@"全部都在左边");
            [self dismiss];
            CGFloat selfW = mostW + CenterViewW + space;
            CGFloat selfH = TagLabelH * 4;
            self.width = selfW;
            self.height = selfH;
            CGPoint point = CGPointMake(_selfCenter.x - self.width/2 + CenterViewW/2, _selfCenter.y - TagLabelH/2);
            self.center = point;
            
            YBCenterView *centerView = [[YBCenterView alloc]initWithFrame:CGRectMake(self.width- CenterViewW, TagLabelH*2.5- CenterViewH/2, CenterViewW, CenterViewH)];//self.width - mostW - CenterViewW/2 - 30
            _tagViewCenterPoint = centerView.center;
            [centerView.button addTarget:self action:@selector(fourTagChangeState:) forControlEvents:UIControlEventTouchUpInside];
            [centerView startAnimation];
            [self addSubview:centerView];
            _tagCenterView = centerView;
            
            for (int i = 0; i < _tagArray.count; i ++)
            {
                CGFloat tagW = [[_tagWMutArr objectAtIndex:i] floatValue];
                NSString *tagString = [_tagArray objectAtIndex:i];
                YBTagLabel *label = [[YBTagLabel alloc]initWithFrame:CGRectMake(self.width - CenterViewW - space -tagW, TagLabelH*i, tagW, TagLabelH) withString:tagString];
                [self addSubview:label];
                
                label.leftPoint = CGPointMake(label.x, label.y + label.height - 0.5);
                label.rightPoint = CGPointMake(label.x + label.width, label.y + label.height);
                YBBranchLayer *branch = [[YBBranchLayer alloc]init];
                [branch commitPathWithStartPoint:_tagViewCenterPoint midPoint:label.rightPoint endPoint:label.leftPoint withBlock:^(CGFloat time) {
                    CGFloat timeF = time;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeF * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [label delay];
                    });
                }];
                [self.layer addSublayer:branch];
                
                if (i == 0) {
                    _tagOne = label;
                    _tagBranchOne = branch;
                }else if (i == 1)
                {
                    _tagTwo = label;
                    _tagBranchTwo = branch;
                }else if (i == 2)
                {
                    _tagThree = label;
                    _tagBranchThree = branch;
                }else if (i == 3)
                {
                    _tagFour = label;
                    _tagBranchFour = branch;
                }
            }

        }
            break;
            
        default:
            break;
    }


}


/**
 *  四个tag的时候改变标签状态
 */
- (void)fourTagChangeState:(UIButton *)button
{
    _buttonFourTag ++;
    if (_buttonFourTag == 5) {
        _buttonFourTag = 0;
    }
    
    switch (_buttonFourTag) {
        case YBFourTagStyleZeroLeft:
            [self addFourTag:YBFourTagStyleZeroLeft];
            break;
        case YBFourTagStyleOneLeft:
            [self addFourTag:YBFourTagStyleOneLeft];
            break;
        case YBFourTagStyleTwoLeft:
            [self addFourTag:YBFourTagStyleTwoLeft];
            break;
        case YBFourTagStyleThreeLeft:
            [self addFourTag:YBFourTagStyleThreeLeft];
            break;
        case YBFourTagStyleAllLeft:
            [self addFourTag:YBFourTagStyleAllLeft];
            break;
            
        default:
            break;
    }
}


- (void)dismiss
{
    [_tagOne removeFromSuperview];
    [_tagTwo removeFromSuperview];
    [_tagThree removeFromSuperview];
    [_tagFour removeFromSuperview];
    
    [_tagBranchOne removeFromSuperlayer];
    [_tagBranchTwo removeFromSuperlayer];
    [_tagBranchThree removeFromSuperlayer];
    [_tagBranchFour removeFromSuperlayer];
    
    [_tagCenterView removeFromSuperview];
}



#pragma mark -- 按住拖动的手势
- (void)setIsPanGestureOnTagViewed:(BOOL)isPanGestureOnTagViewed {
    _isPanGestureOnTagViewed = isPanGestureOnTagViewed;
    if (isPanGestureOnTagViewed) {
        if (![self validatePanGesture]) {
            [self addGestureRecognizer:self.panGestureRecognizer];
        }
    } else {
        if ([self validatePanGesture]) {
            [self removeGestureRecognizer:self.panGestureRecognizer];
        }
    }
}

- (BOOL)validatePanGesture {
    return [self.gestureRecognizers containsObject:self.panGestureRecognizer];
}

- (UIPanGestureRecognizer *)panGestureRecognizer {
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
    }
    return _panGestureRecognizer;
}

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint point = [panGestureRecognizer translationInView:panGestureRecognizer.view];
    
    self.center = CGPointMake(self.center.x + point.x, self.center.y + point.y);
//    NSLog(@"拖动后的位置：%@",NSStringFromCGPoint(self.center));
    _selfCenter = self.center;
    
    //检查是否拖动出界
    [self checkIsOut];
    
    [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
}

@end
