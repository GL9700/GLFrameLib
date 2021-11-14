//
//  GLHomeViewController.m
//  GLFrameLib_Example
//
//  Created by 李国梁 on 2020/12/22.
//  Copyright © 2020 36617161@qq.com. All rights reserved.
//

#import "GLHomeViewController.h"

@interface GLHomeCell : GLFrameBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation GLHomeCell

@end

@interface UITableView(ext)
@property (nonatomic) void(^handleOnSelectCell)(NSUInteger section, NSUInteger row);
@property (nonatomic) NSString *(^headerTitle)(NSUInteger section);
- (void)buildListWithArray:(NSArray *)dataSource onCell:(UITableViewCell *(^)(id Element, NSIndexPath* indexPath))cell;
- (void)buildListWithArray:(NSArray *)dataSource onCellClass:(Class)class;
@end

@interface GLHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView *mainTableView;
@end

@implementation GLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray<NSString *> *arrayData;
    self.mainTableView.frame = self.view.bounds;
    [self.mainTableView registerNib:[UINib nibWithNibName:@"cell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    [self.mainTableView registerClass:[GLHomeCell class] forCellReuseIdentifier:@"cell"];
    
    
    [self.mainTableView buildListWithArray:arrayData onCell:^UITableViewCell *(NSString *Element, NSIndexPath *indexPath) {
        
    }];
    
    self.mainTableView.handleOnSelectCell=^(NSUInteger section, NSUInteger row){
        
    };
    
    self.mainTableView.headerTitle = ^NSString *(NSUInteger section) {
        
    };
    
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    GLHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.label.text = @"Hello";
//    return cell;
//}
//- (UITableView *)mainTableView {
//    if(!_mainTableView) {
//        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//        _mainTableView.delegate = self;
//        _mainTableView.dataSource = self;
//        _mainTableView.tableFooterView = [UIView new];
//        _mainTableView.tableHeaderView = [UIView new];
//        [self.view addSubview:_mainTableView];
//    }
//    return _mainTableView;
//}

@end
