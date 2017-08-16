//
//  UIView+retainCount.m
//  Demo
//
//  Created by Cuikeyi on 2017/8/10.
//  Copyright © 2017年 Cuikeyi. All rights reserved.
//

#import "UIView+retainCount.h"
#import <objc/runtime.h>
#import "DemoTestLabel.h"
#import "DemoTestView.h"

@implementation UIView (retainCount)

//+ (void)load
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//    
//        Method originalMethod = class_getInstanceMethod([self class], @selector(retain));
//        Method swizzledMethod = class_getInstanceMethod([self class], @selector(my_retain));
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//        
//        Method originalMethod1 = class_getInstanceMethod([self class], @selector(release));
//        Method swizzledMethod1 = class_getInstanceMethod([self class], @selector(my_release));
//        method_exchangeImplementations(originalMethod1, swizzledMethod1);
//        });
//}
//
//- (instancetype)my_retain
//{
//    if ([self isKindOfClass:[DemoTestView class]] || [self isKindOfClass:[DemoTestLabel class]]) {
//        NSLog(@"retain -> %@", [self class]);
//    }
//    return [self my_retain];
//}
//
//- (oneway void)my_release
//{
//    if ([self isKindOfClass:[DemoTestView class]] || [self isKindOfClass:[DemoTestLabel class]]) {
//        NSLog(@"release -> %@", [self class]);
//    }
//    [self my_release];
//}

@end
