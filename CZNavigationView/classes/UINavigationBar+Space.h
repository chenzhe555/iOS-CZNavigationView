//
//  UINavigationBar+Space.h
//  CZNavigationView
//
//  Created by yunshan on 2019/4/27.
//  Copyright © 2019 chenzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 @brief 设置Navi左右间隙宽度
 默认15
 PS: iOS 11之后，是设置layoutMargins置空，然后设置子视图的layoutMargins来达到设置间隙，但是在UIButtonBarStackView上仍然有个8px的View，所以 15 = 7(UIButtonBarStackViewx坐标) + 8(其中UITAMICAdaptorView前面有个8像素View)
     iOS 11之前，barButtonItem数据中添加一个宽度为负的占位item即可
 */
@interface UINavigationBar (Space)

@end

NS_ASSUME_NONNULL_END
