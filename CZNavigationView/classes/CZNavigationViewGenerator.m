//
//  CZNavigationViewGenerator.m
//  CZNavigationView
//
//  Created by yunshan on 2019/4/26.
//  Copyright © 2019 chenzhe. All rights reserved.
//

#import "CZNavigationViewGenerator.h"
#import <CZConfig/CZConfig.h>
#import <CZCategory/NSString+CZCategory.h>
#import <CZCategory/UIView+CZCategory.h>

@interface CZNavigationViewGenerator ()

/**
 @brief 总高度 默认44
 */
@property (nonatomic, assign) CGFloat containerHeight;

/**
 @brief 显示类型
 */
@property (nonatomic, assign) NSInteger generatorType;

/**
 @brief 为了扩充点击区域增加的左右间隙
 */
@property (nonatomic, assign) CGFloat contentSpace;

/**
 @brief 图片和文本间隔, 默认2
 */
@property (nonatomic, assign) CGFloat imageTextSpace;

/**
 @brief 文本
 */
@property (nonatomic, copy) NSString * textTitle;

/**
 @brief 文本字体
 */
@property (nonatomic, strong) UIFont * textFont;

/**
 @brief 文本颜色
 */
@property (nonatomic, strong) UIColor * textColor;

/**
 @brief 图片名
 */
@property (nonatomic, copy) NSString * imageName;
@end

@implementation CZNavigationViewGenerator

+(instancetype)manager
{
    CZNavigationViewGenerator * generator = [[CZNavigationViewGenerator alloc] init];
    generator.textFont = [UIFont systemFontOfSize:12];
    generator.textColor = [UIColor redColor];
    generator.generatorType = CZNavigationViewGeneratorTypeLeft;
    generator.contentSpace = 5;
    generator.containerHeight = 44;
    generator.imageTextSpace = 2;
    return generator;
}

-(void)generateWithVC:(UIViewController *)vc action:(SEL)clickAction
{
    [self createCustomView:vc action:clickAction];
}

#pragma mark DSL
-(CZNavigationViewGenerator * _Nonnull (^)(CZNavigationViewGeneratorType))type
{
    CZWeak(self)
    return ^CZNavigationViewGenerator * (CZNavigationViewGeneratorType type) {
        weakself.generatorType = type;
        return weakself;
    };
}

-(CZNavigationViewGenerator * _Nonnull (^)(CGFloat))cSpace
{
    CZWeak(self)
    return ^CZNavigationViewGenerator * (CGFloat cSpace) {
        weakself.contentSpace = cSpace;
        return weakself;
    };
}

- (CZNavigationViewGenerator * _Nonnull (^)(CGFloat))itSpace
{
    CZWeak(self)
    return ^CZNavigationViewGenerator * (CGFloat itSpace) {
        weakself.imageTextSpace = itSpace;
        return weakself;
    };
}

- (CZNavigationViewGenerator * _Nonnull (^)(NSString * _Nullable))title
{
    CZWeak(self)
    return ^CZNavigationViewGenerator * (NSString * title) {
        weakself.textTitle = title;
        return weakself;
    };
}

-(CZNavigationViewGenerator * _Nonnull (^)(UIFont * _Nullable))font
{
    CZWeak(self)
    return ^CZNavigationViewGenerator * (UIFont * font) {
        weakself.textFont = font;
        return weakself;
    };
}

-(CZNavigationViewGenerator * _Nonnull (^)(UIColor * _Nullable))color
{
    CZWeak(self)
    return ^CZNavigationViewGenerator * (UIColor * color) {
        weakself.textColor = color;
        return weakself;
    };
}

-(CZNavigationViewGenerator * _Nonnull (^)(NSString * _Nonnull))imgName
{
    CZWeak(self)
    return ^CZNavigationViewGenerator * (NSString * imgName) {
        weakself.imageName = imgName;
        return weakself;
    };
}

#pragma mark 生成UIBarButtonItem

/**
 @brief 创建BarItem 自定义视图

 @param vc 当前VC
 @param clickAction 响应事件
 */
-(void)createCustomView:(UIViewController *)vc action:(SEL)clickAction
{
    UIView * view = [[UIView alloc] init];
    // 添加点击事件
    if (clickAction) [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:vc action:clickAction]];
    CGSize textSize = CGSizeZero;
    CGSize imgSize = CGSizeZero;
    UILabel * label = nil;
    UIImageView * imgView = nil;
    if (self.textTitle.length) {
        label = [[UILabel alloc] init];
        label.font = self.textFont;
        label.text = self.textTitle;
        label.textColor = self.textColor;
        label.textAlignment = NSTextAlignmentCenter;
        textSize = [self.textTitle getTextActualSize:self.textFont lines:0 maxWidth:[UIScreen mainScreen].bounds.size.width];
        [view addSubview:label];
    }
    if (self.imageName.length) {
        imgView = [[UIImageView alloc] init];
        UIImage * image = [UIImage imageNamed:self.imageName];
        imgView.image = image;
        imgSize = image.size;
        [view addSubview:imgView];
    }
    
    // 赋值坐标
    if (self.imageName.length && self.textTitle.length) {
        CGFloat maxWidth = MAX(imgSize.width, textSize.width);
        CGFloat allHeight = imgSize.height + self.imageTextSpace + textSize.height;
        view.frame = CGRectMake(0, 0, maxWidth + self.contentSpace*2, self.containerHeight);
        imgView.frame = CGRectMake((view.width - imgSize.width)/2, (self.containerHeight - allHeight)/2, imgSize.width, imgSize.height);
        label.frame = CGRectMake((view.width - textSize.width)/2, imgView.yPlushHeight + self.imageTextSpace, textSize.width, textSize.height);
    } else if (self.imageName.length) {
        view.frame = CGRectMake(0, 0, imgSize.width + self.contentSpace*2, self.containerHeight);
        imgView.frame = CGRectMake(self.contentSpace, (view.height - imgSize.height)/2, imgSize.width, imgSize.height);
    } else if (self.textTitle.length) {
        view.frame = CGRectMake(0, 0, textSize.width + self.contentSpace*2, self.containerHeight);
        label.frame = view.bounds;
    }
    [self evaluateBarItem:vc view:view];
}


/**
 @brief 赋值到当前BarItem
 */
-(void)evaluateBarItem:(UIViewController *)vc view:(UIView *)view
{
    switch (self.generatorType) {
        case CZNavigationViewGeneratorTypeLeft:
        {
            NSMutableArray * items = [NSMutableArray arrayWithArray:vc.navigationItem.leftBarButtonItems];
            [items addObject:[[UIBarButtonItem alloc] initWithCustomView:view]];
            vc.navigationItem.leftBarButtonItems = items;
        }
            break;
        case CZNavigationViewGeneratorTypeRight:
        {
            NSMutableArray * items = [NSMutableArray arrayWithArray:vc.navigationItem.rightBarButtonItems];
            [items addObject:[[UIBarButtonItem alloc] initWithCustomView:view]];
            vc.navigationItem.rightBarButtonItems = items;
        }
            break;
            
        default:
            break;
    }
}
@end
