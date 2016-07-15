//
//  MyCustomPiechartView.h
//  MyCustomPiechartDemo
//
//  Created by Tony Zhang on 16/7/15.
//  Copyright © 2016年 Tony Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MyBasicPiechartView : UIView

+(instancetype)basicPiechartViewWithDictionary:(NSDictionary *)dictionary andColorArray:(NSArray *)colorArray andFrame:(CGRect)frame;

@end


@interface MyCustomPiechartView : UIView

/**
 *  饼状图及项目说明
 *
 *  @param dictionary 数据源 结构为：@{@"title":@"",@"subTitle":@"",@"percentArray":@[],@"itemArray":@[]};
 *  @param color      项目颜色
 *  @param frame      fame
 */

+(instancetype)piechartViewWithDictionary:(NSDictionary *)dictionary andColorArray:(NSArray<UIColor *>*)color andFrame:(CGRect)frame;

@end