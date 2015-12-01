//
//  ViewController.m
//  YY购物demo
//
//  Created by 杨玥 on 15/11/30.
//  Copyright © 2015年 YY. All rights reserved.
//

#import "ViewController.h"
#import "YYProduct.h"
#import "YYProductCell.h"
#import "YYFooterView.h"
#import "YYBottomToolBar.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, YYProductCellDelegate, YYBottomToolBarDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSArray *products; // 数据模型数组（存放货品模型）
@property (nonatomic, assign) CGFloat totalPrice; // 所有选中的商品总价值
@property (nonatomic, weak) YYBottomToolBar *toolbar; // 底部工具条
@property (nonatomic, assign, getter=isAllSelected) BOOL allSelected; // 商品是否被全选


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"购物车";
    
    // 设置tableView
    [self setupTableView];
    
    // 设置底部工具条
    [self setupToolbar];
}

/**
 *  设置底部工具条
 */
- (void)setupToolbar
{
    YYBottomToolBar *toolbar = [YYBottomToolBar toolBar];
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbar.frame.size.height;
    CGFloat toolbarW = toolbar.frame.size.width;
    CGFloat toolbarH = toolbar.frame.size.height;
    CGRect toolbarRect = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    toolbar.frame = toolbarRect;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:toolbar];
    toolbar.delegate = self;
    self.toolbar = toolbar;
}

/**
 *  设置tableView
 */
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - UITableView datasource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYProductCell *cell = [YYProductCell cellWithTableView:tableView];
    
    cell.delegate = self;
    
    cell.product = self.products[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 拿到点击行的数据模型
    YYProduct *product = self.products[indexPath.row];
    // 设置选中状态
    if (product.isSelected == NO) {
        product.selected = YES;
    } else{
        product.selected = NO;
    }
    
    
    // 拿到底部条中的全选按钮，当某一个模型取消选中，则取消全选
    UIButton *selectAllBtn = [self.toolbar viewWithTag:1000];
    if (product.isSelected == NO) {
        selectAllBtn.selected = NO;
    }
    
    // 当模型数组中每个模型都被选中，则显示全选状态
    self.allSelected = YES;
    for (YYProduct *prod in self.products) {
        if (prod.isSelected == NO) {
            self.allSelected = NO;
        }
    }
    if (self.isAllSelected) {
        selectAllBtn.selected = YES;
    }
    
    // 刷新所选行
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    // 计算显示总价格
    [self countingTotalPrice];
    
}

#pragma mark - YYProductCell 代理
// 点击了加号按钮
- (void)productCell:(YYProductCell *)cell didClickedPlusBtn:(UIButton *)plusBtn
{

    // 拿到点击的cell对应的indexpath
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    // 拿到对应row的模型，购买数++
    YYProduct *product = self.products[indexPath.row];
    product.buyCount++;
    
    // 刷新
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    // 计算总显示价格
    [self countingTotalPrice];
}
// 点击了减号按钮
- (void)productCell:(YYProductCell *)cell didClickedMinusBtn:(UIButton *)minusBtn
{

    // 拿到点击的cell对应的indexpath
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    // 拿到对应row的模型，购买数--
    YYProduct *product = self.products[indexPath.row];
    // 购买数量不能小于1
    if (product.buyCount == 1) return;
    product.buyCount--;
    
    // 刷新对应行
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

    // 计算总价格
    [self countingTotalPrice];
}

- (void)countingTotalPrice
{
    // 遍历模型数组，检查每个模型的selected状态
    for (int i = 0; i < self.products.count; i++) {
        
        YYProduct *product = self.products[i];
        
        if (product.isSelected) { // 如果是被选中的模型，总价累加
            self.totalPrice += product.buyCount * [product.price floatValue];
        }
    }
    NSLog(@"%f", self.totalPrice);
    // 设置底部条显示总价
    self.toolbar.totalPrice = self.totalPrice;
    [self.toolbar setNeedsDisplay];
    
    // 总价清零（每次要重新计算）
    self.totalPrice = 0;

}

#pragma mark - YYBottomToolBar代理
// 点击了全选按钮
- (void)bottomToolBar:(YYBottomToolBar *)bottomToolBar didClickedSelectAllBtn:(UIButton *)selectAllBtn
{
    if (selectAllBtn.isSelected == NO) {
        selectAllBtn.selected = YES;
        for (YYProduct *product in self.products) {
            product.selected = YES;
        }
    } else {
        selectAllBtn.selected = NO;
        for (YYProduct *product in self.products) {
            product.selected = NO;
        }
    }
    [self countingTotalPrice];
    [self.tableView reloadData];
}


#pragma mark - 懒加载
- (NSArray *)products
{
    if (_products == nil) {
        _products = [NSArray array];
        
        NSMutableArray *ary = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"name"] = [NSString stringWithFormat:@"测试商品%d", i];
            dict[@"icon"] = @"1.png";
            dict[@"price"] = @"2000";
            dict[@"buyCount"] = [NSNumber numberWithInt:1];
            dict[@"selected"] = [NSNumber numberWithBool:NO];
            
            YYProduct *product = [[YYProduct alloc] initWithDict:dict];
            [ary addObject:product];
        }
        _products = ary;
    }
    return _products;
}
@end
