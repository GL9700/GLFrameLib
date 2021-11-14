//
//  GLMainListViewController.m
//  GLFrameLib_Example
//
//  Created by 李国梁 on 2020/12/21.
//  Copyright © 2020 36617161@qq.com. All rights reserved.
//

#import "GLMainListViewController.h"

@interface GLMainListViewController () <UITableViewDelegate , UITableViewDataSource>
@property (nonatomic) NSArray<NSDictionary *> *listdata;
@property (nonatomic) UITableView *mainTableView;
@end

@implementation GLMainListViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"GLFrameLib Demo list";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.mainTableView.tableFooterView = [UIView new];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
}

#pragma mark- TableView Delegate & datasources
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.listdata[indexPath.row][@"name"];
    cell.detailTextLabel.text = self.listdata[indexPath.row][@"state"];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    if(NSClassFromString(self.listdata[indexPath.row][@"class"])) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class class = NSClassFromString(self.listdata[indexPath.row][@"class"]);
    if(class) {
        UIViewController *instance = [class new];
        [self.navigationController pushViewController:instance animated:YES];
        instance.view.backgroundColor = [UIColor whiteColor];
        instance.title = self.listdata[indexPath.row][@"name"];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark- Lazy Getter
- (NSArray<NSDictionary *> *)listdata {
    if(!_listdata) {
        _listdata = @[
            @{@"state":@"未完成", @"name":@"首页页面", @"class":@"GLHomeViewController"},
            @{@"state":@"未完成", @"name":@"TableView页面", @"class":@""},
            @{@"state":@"未完成", @"name":@"静态TableView页面(Scroll+Views)", @"class":@""},
            @{@"state":@"未完成", @"name":@"关于页面", @"class":@""}
        ];
    }
    return _listdata;
}

@end
