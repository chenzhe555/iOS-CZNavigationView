//
//  CZNavigationViewGenerator.h
//  CZNavigationView
//
//  Created by yunshan on 2019/4/26.
//  Copyright © 2019 chenzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CZNavigationViewGeneratorType) {
    CZNavigationViewGeneratorTypeLeft = 1,
    CZNavigationViewGeneratorTypeRight
};

NS_ASSUME_NONNULL_BEGIN

@interface CZNavigationViewGenerator : NSObject
#pragma mark 供外部调用方法 Demo: [[CZNavigationViewGenerator manager].title(@"测试") generateWithVC:self action:@selector(ceshi)];
/**
 @brief 获取当前实例
 */
+(instancetype)manager;

/**
 @brief 生成NavigationView

 @param vc 当前VC
 @param clickAction 点击事件
 */
-(void)generateWithVC:(UIViewController *)vc action:(SEL _Nullable)clickAction;

/**
 @brief 自定义视图生成NavigationView

 @param view 自定义视图
 @param vc 当前VC
 @param clickAction 点击事件
 */
-(void)generateWithCustomView:(UIView *)view vc:(UIViewController *)vc action:(SEL _Nullable)clickAction;

#pragma mark DSL创建组件相关方法

/**
 @brief Bar显示类型 默认左边
 */
-(CZNavigationViewGenerator *(^)(CZNavigationViewGeneratorType))type;

/**
 @brief 为了扩充点击区域增加的左右间隙, 默认0
 */
-(CZNavigationViewGenerator *(^)(CGFloat))cSpace;

/**
 @brief 图片和文本间隔, 默认2
 */
-(CZNavigationViewGenerator *(^)(CGFloat))itSpace;

/**
 @brief 文本
 */
-(CZNavigationViewGenerator *(^)(NSString *))title;

/**
 @brief 文本字体
 */
-(CZNavigationViewGenerator *(^)(UIFont *))font;

/**
 @brief 文本颜色
 */
-(CZNavigationViewGenerator *(^)(UIColor *))color;

/**
 @brief 图片名
 */
-(CZNavigationViewGenerator *(^)(NSString *))imgName;
@end

NS_ASSUME_NONNULL_END
