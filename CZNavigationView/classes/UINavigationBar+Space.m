//
//  UINavigationBar+Space.m
//  CZNavigationView
//
//  Created by yunshan on 2019/4/27.
//  Copyright © 2019 chenzhe. All rights reserved.
//

#import "UINavigationBar+Space.h"
#import <objc/runtime.h>
#import <CZConfig/CZConfig.h>
#import <CZCategorys/NSObject+CZCategory.h>

#define kSpacerWidth 0

@implementation UINavigationBar (Space)
+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self replaceInstanceMethodWithOriginSEL:@selector(layoutSubviews) newSEL:@selector(sw_layoutSubviews) class:nil];
    });
}

-(void)sw_layoutSubviews
{
    [self sw_layoutSubviews];
    
    if (kiOS11_or_Later) {
        CGFloat space = 15;
        NSString * bundlePath = [[NSBundle mainBundle] pathForResource:@"CZConfig" ofType:@"plist"];
        if (bundlePath.length) {
            NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:bundlePath];
            space = [dic[@"naviSpace"] floatValue];
        }
        self.layoutMargins = UIEdgeInsetsZero;
        for (UIView *subview in self.subviews) {
            if ([NSStringFromClass(subview.class) containsString:@"ContentView"]) {
                subview.layoutMargins = UIEdgeInsetsMake(0, space, 0, space);
                break;
            }
        }
    }
    
    
    
}

@end
