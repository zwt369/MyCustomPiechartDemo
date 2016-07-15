//
//  MyCustomPiechartView.m
//  MyCustomPiechartDemo
//
//  Created by Tony Zhang on 16/7/15.
//  Copyright © 2016年 Tony Zhang. All rights reserved.
//

#import "MyCustomPiechartView.h"

#define pieXChartView  self.frame.size.width / 3.2 - sqrt((self.backgroundLayer.cornerRadius * 1.1 *  self.backgroundLayer.cornerRadius * 1.1) / 2)
#define pieYChartView  self.frame.size.width / 3.2 - sqrt((self.backgroundLayer.cornerRadius * 1.1 * self.backgroundLayer.cornerRadius * 1.1) / 2)

@interface MyBasicPiechartView ()

/** data */
@property(nonatomic,strong)NSDictionary *dictionary;

/** 项目颜色数组 */
@property(nonatomic,strong)NSArray<UIColor *> *colorArray;

/** 标题 */
@property(nonatomic,strong)UILabel *titleLab;

/** 副标题 */
@property(nonatomic,strong)UILabel *subTitleLab;

@end

@implementation MyBasicPiechartView


+(instancetype)basicPiechartViewWithDictionary:(NSDictionary *)dictionary andColorArray:(NSArray *)colorArray andFrame:(CGRect)frame{

    MyBasicPiechartView *basic = [[MyBasicPiechartView alloc]initWithFrame:frame];
    basic.colorArray = colorArray;
    basic.dictionary = dictionary;
    return basic;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

-(void)addViews{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.25 , 38, self.frame.size.width * 0.5, self.frame.size.height * 0.3)];
    self.titleLab.numberOfLines = 2;
    self.titleLab.font = [UIFont systemFontOfSize:15];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = [UIColor colorWithRed:247.0/255.0 green:87.0/255.0 blue:38.0/255.0 alpha:1.0];
    [self addSubview:self.titleLab];
    
    self.subTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.25, CGRectGetMaxY(self.titleLab.frame), self.frame.size.width * 0.5, 22)];
    self.subTitleLab.font = [UIFont systemFontOfSize:12];
    self.subTitleLab.textColor = [UIColor lightGrayColor];
    self.subTitleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.subTitleLab];
}

-(void)setDictionary:(NSDictionary *)dictionary{
    _dictionary = dictionary;
     self.subTitleLab.text = dictionary[@"subTitle"];
     self.titleLab.text = dictionary[@"title"];
}


-(void)drawRect:(CGRect)rect{
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    int sum = 0;
    for (int  i = 0 ; i < self.colorArray.count; i++) {
        CGFloat startRadius = 0;
        CGFloat endRadius = 0;
        startRadius = (sum / 100.0) *  M_PI * 2;
        if(i == 3){
            endRadius = 2 * M_PI;
        }else{
            endRadius = ([self.dictionary[@"percentArray"][i] floatValue] / 100) *  M_PI * 2 + startRadius;
        }
        
        CGContextMoveToPoint(ctr, rect.size.width / 2, rect.size.height / 2);
        CGContextAddArc(ctr, rect.size.width / 2, rect.size.height / 2, self.frame.size.width / 2, startRadius, endRadius, 0);
        [self.colorArray[i] set];
        CGContextFillPath(ctr);
        sum += [self.dictionary[@"percentArray"][i] floatValue];
    }
    
    CGContextMoveToPoint(ctr, rect.size.width / 2, rect.size.height / 2);
    CGContextAddArc(ctr, rect.size.width / 2, rect.size.height / 2, self.frame.size.width / 3.0, 0, 2 * M_PI, 0);
    [[UIColor whiteColor]set];
    CGContextFillPath(ctr);
}



@end


@interface MyCustomPiechartView ()

/** 百分比数组 */
@property(nonatomic,strong)NSArray *percentArray;

/** 标题数组 */
@property(nonatomic,strong)NSArray *titleArray;

/** 项目颜色数组 */
@property(nonatomic,strong)NSArray *colorArray;

/** 背景calayer */
@property(nonatomic,strong)CALayer *backgroundLayer;

/** data */
@property(nonatomic,strong)NSDictionary *dictionary;

@end

@implementation MyCustomPiechartView

+(instancetype)piechartViewWithDictionary:(NSDictionary *)dictionary andColorArray:(NSArray<UIColor *>*)color andFrame:(CGRect)frame{

    MyCustomPiechartView *piechart = [[MyCustomPiechartView alloc]initWithFrame:frame];
    piechart.dictionary = dictionary;
    piechart.colorArray = color;
    piechart.percentArray = dictionary[@"percentArray"];
    piechart.titleArray = dictionary[@"itemArray"];
    return piechart;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setPercentArray:(NSArray *)percentArray{

    _percentArray = percentArray;
    //饼图
    [self addPieChartView];
}

-(void)setTitleArray:(NSArray *)titleArray{

    _titleArray = titleArray;
    //饼图值
    [self addDescriptionSubViews];
}



-(void)addPieChartView{
    self.backgroundLayer = [[CALayer alloc]init];
    self.backgroundLayer.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.width/2);
    self.backgroundLayer.cornerRadius = self.frame.size.width/4;
    self.backgroundLayer.position = CGPointMake(self.frame.size.width / 3.2, self.frame.size.width / 3.2 - 15);
    self.backgroundLayer.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0].CGColor;
    [self.layer addSublayer:self.backgroundLayer];
    //开始图层动画
    [self startAnimationWithStaticLayer:self.backgroundLayer];
    MyBasicPiechartView *piechart = [MyBasicPiechartView basicPiechartViewWithDictionary:self.dictionary andColorArray:self.colorArray andFrame:CGRectMake(pieXChartView - 2, pieYChartView - 17, self.backgroundLayer.cornerRadius * 1.6 , self.backgroundLayer.cornerRadius * 1.6)];
    [self addSubview:piechart];
}


-(void)startAnimationWithStaticLayer:(CALayer *)staticLayer{

    CAAnimationGroup *animaTionGroup = [CAAnimationGroup animation];
    animaTionGroup.delegate = self;
    animaTionGroup.duration = 1;
    animaTionGroup.removedOnCompletion = YES;
    animaTionGroup.autoreverses = YES;
    animaTionGroup.repeatCount = MAXFLOAT;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.90;
    scaleAnimation.toValue = @0.96;
    scaleAnimation.duration = 1;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.autoreverses = YES;
    
    CAKeyframeAnimation *opencityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opencityAnimation.duration = 1;
    opencityAnimation.values = @[@0.4,@0.8,@0.4];
    opencityAnimation.keyTimes = @[@0,@0.5,@1];
    opencityAnimation.removedOnCompletion = YES;
    opencityAnimation.autoreverses = YES;
    opencityAnimation.repeatCount = MAXFLOAT;
    
    NSArray *animations = @[scaleAnimation];
    animaTionGroup.animations = animations;
    [staticLayer addAnimation:animaTionGroup forKey:@"groupAnnimation"];

}


-(void)addDescriptionSubViews{

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(pieXChartView + self.backgroundLayer.cornerRadius * 2.1, pieXChartView - 15 , self.frame.size.width - pieXChartView + self.backgroundLayer.cornerRadius * 1.8 , 22)];
    titleLabel.text = @"百分比分布";
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:titleLabel];
    
    CGFloat blockY = 0;
    for (int i = 0 ; i < self.titleArray.count; i++) {
        blockY = CGRectGetMaxY(titleLabel.frame) + i * 25 + 10;
        UIView *blockView = [[UIView alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x, blockY, 10, 10)];
        blockView.backgroundColor = self.colorArray[i];
        [self addSubview:blockView];
        
        UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(blockView.frame) + 10, blockY - 5, 80, 20)];
        valueLabel.text = [NSString stringWithFormat:@"%@%% %@",self.percentArray[i],self.titleArray[i]];
        valueLabel.font = [UIFont systemFontOfSize:12];
        valueLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:valueLabel];
    }

}



@end
