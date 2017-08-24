//
//  GuideView.m
//  Demo
//
//  Created by Cuikeyi on 2017/8/16.
//  Copyright © 2017年 Cuikeyi. All rights reserved.
//

#import "GuideView.h"
#import "AnimationView.h"

static CGFloat const triangleH = 20;
static CGFloat const triangleW = 35;

@interface GuideView ()

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) AnimationView *animationView;

@end

@implementation GuideView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 0;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-triangleH);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:8.f];
    CGPoint startPoint = CGPointMake((rect.size.width -triangleW)*0.5, rect.size.height);
    CGPoint midPoint = CGPointMake(rect.size.width*0.5, self.bounds.size.height);
    CGPoint endPoint = CGPointMake((rect.size.width+triangleW)*0.5, rect.size.height);
    [path moveToPoint:startPoint];
    [path addLineToPoint:midPoint];
    [path addLineToPoint:endPoint];
    [path closePath];
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
}

- (void)updateDataWithImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray
{
    _imageArray = imageArray;
    _titleArray = titleArray;
    
    CGFloat imagePadding = 5.f;
    CGFloat animationX = 5.f;
    CGFloat animationY = 10.f;
    CGFloat animationH = self.bounds.size.height-triangleH-2*animationY;
    CGFloat animationW = animationH+2*imagePadding;
    if (imageArray && imageArray.count) {// 有图片
        
        if (!_animationView) {
            _animationView = [[AnimationView alloc] initWithFrame:CGRectMake(animationX, animationY, animationW, animationH)];
            [self addSubview:_animationView];
        }
        [self.animationView updateImageColor:[UIColor redColor] width:2];
        [self.animationView updateImageData:_imageArray];
        // 文字
        CGFloat labelX = CGRectGetMaxX(self.animationView.frame)+animationX;
        CGFloat labelW = self.bounds.size.width-labelX-30.f;
        self.titleLabel.frame = CGRectMake(labelX, animationY, labelW, animationH);
        self.titleLabel.text = @"同城281位男性正在快聊";
        self.animationView.hidden = NO;
    }
    else {
        _animationView.hidden = YES;
        CGFloat labelX = 30.f;
        CGFloat labelW = self.bounds.size.width-2*labelX;
        self.titleLabel.frame = CGRectMake(labelX, animationY, labelW, animationH);
        
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 2;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (AnimationView *)animationView
{
    if (!_animationView) {
        _animationView = [[AnimationView alloc] init];
        [self addSubview:_animationView];
    }
    return _animationView;
}

@end
