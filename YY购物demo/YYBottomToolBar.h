//
//  YYToolBar.h
//  YY购物demo
//
//  Created by 杨玥 on 15/11/30.
//  Copyright © 2015年 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYBottomToolBar;
@protocol YYBottomToolBarDelegate <NSObject>
@optional
- (void)bottomToolBar:(YYBottomToolBar *)bottomToolBar didClickedSelectAllBtn:(UIButton *)selectAllBtn;
@end

@interface YYBottomToolBar : UIView
+ (instancetype)toolBar;
@property (nonatomic, assign) CGFloat totalPrice;
@property (nonatomic, weak) id<YYBottomToolBarDelegate> delegate;

@end
