//
//  YYProduct.h
//  YY购物demo
//
//  Created by 杨玥 on 15/11/30.
//  Copyright © 2015年 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYProduct : NSObject
/**商品标题*/
@property (nonatomic, copy) NSString *name;
/**商品图标*/
@property (nonatomic, copy) NSString *icon;
/**商品单价*/
@property (nonatomic, copy) NSString *price;
/**购买数量*/
@property (nonatomic, assign) int buyCount;
/**是否被选中*/
@property (nonatomic, assign, getter=isSelected) BOOL selected;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)productWithDict:(NSDictionary *)dict;
@end
