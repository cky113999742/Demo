//
//  AnimationView.m
//  Demo
//
//  Created by Cuikeyi on 2017/8/16.
//  Copyright © 2017年 Cuikeyi. All rights reserved.
//

#import "AnimationView.h"

@interface AnimationView () <CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *preImageView;
@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UIView *preView;
@property (nonatomic, strong) UIView *curView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) CGRect currentNormalRect;
@property (nonatomic, assign) CGRect preNormalRect;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat borderWidth;

@end

@implementation AnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        _currentNormalRect = CGRectMake(5, 0, self.bounds.size.width-10, self.bounds.size.height);
        _preNormalRect = CGRectMake(self.bounds.size.width+5, 0, self.bounds.size.width-10, self.bounds.size.height);
    }
    return self;
}

- (void)updateImageData:(NSArray *)imageArray
{
    _index = 0;
    _imageArray = imageArray;
    
    if (_imageArray.count <= 1) {
        self.currentImageView.image = [UIImage imageNamed:@"image_1"];
        return;
    }
    [self updateCurrentImageView];
    [self updatePreImageView];
    [self beginAnimation];
}

- (void)updateImageColor:(UIColor *)color width:(CGFloat)width
{
    _borderWidth = width;
    CAShapeLayer *curLayer = [self shapeLayourWithColor:color width:width imageView:self.currentImageView];
    CAShapeLayer *preLayer = [self shapeLayourWithColor:color width:width imageView:self.preImageView];
    [_currentImageView.layer addSublayer:curLayer];
    [_preImageView.layer addSublayer:preLayer];
    CGRect frame = self.bounds;
    frame.size.height = _currentNormalRect.size.height+2*width;
    self.bounds = frame;
    frame = self.currentImageView.frame;
    frame.origin.y = width;
    self.currentImageView.frame = frame;
    frame = self.preImageView.frame;
    frame.origin.y = width;
    self.preImageView.frame = frame;
//    self.preView.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    self.preView.backgroundColor = color;
    self.preView.layer.masksToBounds = YES;
//    self.preView.layer.cornerRadius =
}

- (CAShapeLayer *)shapeLayourWithColor:(UIColor *)color width:(CGFloat)width imageView:(UIImageView *)imageView
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = width;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    
    CGRect rect = CGRectMake(-width, -width, imageView.bounds.size.width+2*width, imageView.bounds.size.height+2*width);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.width*0.5];
    shapeLayer.path = path.CGPath;
    return shapeLayer;
}

- (void)beginAnimation
{
    [self invalidateTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(doAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)doAnimation
{
    CGFloat moveDistence = self.bounds.size.width;
    CAKeyframeAnimation *currentAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    currentAnimation.removedOnCompletion = NO;
    currentAnimation.fillMode = kCAFillModeForwards;
    currentAnimation.values = @[@(0), @(-moveDistence)];
    currentAnimation.duration = 0.25;
    [self.currentImageView.layer addAnimation:currentAnimation forKey:@"current"];
    
    CAKeyframeAnimation *preAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    preAnimation.delegate = self;
    preAnimation.removedOnCompletion = NO;
    preAnimation.fillMode = kCAFillModeForwards;
    preAnimation.values = @[@(0), @(-moveDistence-4), @(-moveDistence+2), @(-moveDistence)];
    preAnimation.keyTimes = @[@(0), @(0.4), @(0.8), @(1)];
    preAnimation.duration = 0.625;
    [self.preImageView.layer addAnimation:preAnimation forKey:@"pre"];
}

- (void)updateCurrentImageView
{
    [self checkIndex];
    UIImage *currentImage = [UIImage imageNamed:[NSString stringWithFormat:@"image_%zd", _index+1]];
    _index++;
    self.currentImageView.image = currentImage;
}

- (void)updatePreImageView
{
    [self checkIndex];
    UIImage *preImage = [UIImage imageNamed:[NSString stringWithFormat:@"image_%zd", _index+1]];
    _index++;
    self.preImageView.image = preImage;
}

- (void)invalidateTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.currentImageView.layer removeAnimationForKey:@"current"];
    [self.preImageView.layer removeAnimationForKey:@"pre"];
    
    UIImageView *tempImageView = _preImageView;
    _preImageView = _currentImageView;
    _currentImageView = tempImageView;
    _preImageView.frame = CGRectMake(_preNormalRect.origin.x, _preNormalRect.origin.y+_borderWidth, _preNormalRect.size.width, _preNormalRect.size.height);//_preNormalRect;
    _currentImageView.frame = CGRectMake(_currentNormalRect.origin.x, _currentNormalRect.origin.y+_borderWidth, _currentNormalRect.size.width, _currentNormalRect.size.height);//_currentNormalRect;
    
    [self updatePreImageView];
}

- (void)checkIndex
{
    if (_index > _imageArray.count - 1) {
        _index = 0;
    }
}

- (UIImageView *)currentImageView
{
    if (!_currentImageView) {
        _currentImageView = [[UIImageView alloc] initWithFrame:_currentNormalRect];
        [self addSubview:_currentImageView];
    }
    return _currentImageView;
}

- (UIImageView *)preImageView
{
    if (!_preImageView) {
        _preImageView = [[UIImageView alloc] initWithFrame:_preNormalRect];
        [self addSubview:_preImageView];
    }
    return _preImageView;
}

- (UIView *)preView
{
    if (!_preView) {
        _preView = [[UIView alloc] init];
        [self addSubview:_preView];
    }
    return _preView;
}

- (UIView *)curView
{
    if (!_curView) {
        _curView = [[UIView alloc] init];
        [self addSubview:_curView];
    }
    return _curView;
}

@end
