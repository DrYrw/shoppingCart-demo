//
//  YYProductCell.h
//  YY购物demo
//
//  Created by 杨玥 on 15/11/30.
//  Copyright © 2015年 YY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYProductCell;
@protocol YYProductCellDelegate <NSObject>
@optional
/**
 * 点击了+号按钮
 */
- (void)productCell:(YYProductCell *)cell didClickedPlusBtn:(UIButton *)plusBtn;

/**
 *  点击了-号按钮
 */
- (void)productCell:(YYProductCell *)cell didClickedMinusBtn:(UIButton *)minusBtn;
@end

@class YYProduct;
@interface YYProductCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) YYProduct *product;
@property (nonatomic, weak) id<YYProductCellDelegate> delegate;
@end
