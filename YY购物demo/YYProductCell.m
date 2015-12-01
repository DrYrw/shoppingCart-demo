//
//  YYProductCell.m
//  YY购物demo
//
//  Created by 杨玥 on 15/11/30.
//  Copyright © 2015年 YY. All rights reserved.
//

#import "YYProductCell.h"
#import "YYProduct.h"

@interface YYProductCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *priceView;
@property (weak, nonatomic) IBOutlet UILabel *buyCountView;
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;



@end
@implementation YYProductCell
- (IBAction)plusBtnClicked {
    if ([self.delegate respondsToSelector:@selector(productCell:didClickedPlusBtn:)]) {
        [self.delegate productCell:self didClickedPlusBtn:nil];
    }

}

- (IBAction)minusBtnClicked {
    if ([self.delegate respondsToSelector:@selector(productCell:didClickedMinusBtn:)]) {
        [self.delegate productCell:self didClickedMinusBtn:nil];
    }
}




- (void)setProduct:(YYProduct *)product
{
    _product = product;
    [self.iconView setImage:[UIImage imageNamed:product.icon]];
    self.titleView.text = product.name;
    self.priceView.text = product.price;
    self.buyCountView.text = [NSString stringWithFormat:@"%d", product.buyCount];
    self.selectedButton.userInteractionEnabled = NO;
    
    if (product.isSelected) {
        self.selectedButton.selected = YES;
    } else {
        self.selectedButton.selected = NO;
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"product";
    YYProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYProductCell" owner:nil options:nil] lastObject];
    }
    return cell;
}




@end
