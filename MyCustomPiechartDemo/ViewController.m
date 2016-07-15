//
//  ViewController.m
//  MyCustomPiechartDemo
//
//  Created by Tony Zhang on 16/7/15.
//  Copyright © 2016年 Tony Zhang. All rights reserved.
//

#import "ViewController.h"
#import "MyCustomPiechartView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //高度必须要大于等于290
    NSArray *percent = @[@"20",@"30",@"50"];
    NSArray *itemArray = @[@"25岁及以下",@"25岁-35岁",@"其他"];
    NSDictionary *dict = @{@"title":@"核心客户分析图",@"subTitle":@"消费年龄",@"percentArray":percent,@"itemArray":itemArray};
    NSArray *color = @[[UIColor colorWithRed:247.0/255.0 green:87.0/255.0 blue:38.0/255.0 alpha:1.0],[UIColor colorWithRed:123.0/255.0 green:162.0/255.0 blue:34.0/255.0 alpha:1.0],[UIColor colorWithRed:251.0/255.0 green:137.0/255.0 blue:30.0/255.0 alpha:1.0]];
    MyCustomPiechartView *pieView = [MyCustomPiechartView piechartViewWithDictionary:dict andColorArray:color andFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width,160)];
   
    [self.view addSubview:pieView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
