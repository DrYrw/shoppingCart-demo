//
//  YYToolBar.m
//  YY购物demo
//
//  Created by 杨玥 on 15/11/30.
//  Copyright © 2015年 YY. All rights reserved.
//

#import "YYBottomToolBar.h"

@interface YYBottomToolBar ()
@property (weak, nonatomic) IBOutlet UILabel *totalPriceView;


@end
@implementation YYBottomToolBar

- (void)setTotalPrice:(CGFloat)totalPrice
{
    _totalPrice = totalPrice;
    NSString *priceStr = [NSString stringWithFormat:@"合计:%.1f元", totalPrice];
    self.totalPriceView.text = priceStr;
    
    
}


/**
 *  点击了全选按钮
 */
- (IBAction)selectAllBtnClicked:(UIButton *)selectAllBtn {
    
    if ([self.delegate respondsToSelector:@selector(bottomToolBar:didClickedSelectAllBtn:)]) {
        [self.delegate bottomToolBar:self didClickedSelectAllBtn:selectAllBtn];
    }
}

+ (instancetype)toolBar
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YYBottomToolBar" owner:nil options:nil] lastObject];
}


@end
