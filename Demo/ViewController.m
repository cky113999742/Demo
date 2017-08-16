//
//  ViewController.m
//  Demo
//
//  Created by Cuikeyi on 2017/8/10.
//  Copyright © 2017年 Cuikeyi. All rights reserved.
//

#import "ViewController.h"
#import "DemoTestView.h"
#import "GuideView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    CGRect frame = CGRectMake(0, 0, 100, 30);
//    CAShapeLayer *borderLayer = [CAShapeLayer layer];
//    borderLayer.frame = frame;
//    borderLayer.lineWidth = 0.5;
//    borderLayer.strokeColor = [[UIColor blackColor] CGColor];
//    borderLayer.fillColor = [[UIColor clearColor] CGColor];
//    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 30) cornerRadius:5.f];
//    borderLayer.path = path.CGPath;
//    
//    UIButton *button = [[UIButton alloc] init];
//    button.frame = CGRectMake(100, 100, 100, 30);
//    [button.layer addSublayer:borderLayer];
//    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    [button setTitle:@"demoTest" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button release];
    self.view.backgroundColor = [UIColor grayColor];
    GuideView *guideView = [[GuideView alloc] initWithFrame:CGRectMake(100, 100, 200, 80)];
    [self.view addSubview:guideView];
    [guideView updateDataWithImageArray:@[@1, @2, @3] titleArray:@[@"aaa", @"awdasdd"]];
}

- (void)buttonAction
{
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
