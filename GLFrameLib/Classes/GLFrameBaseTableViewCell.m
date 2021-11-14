//
//  GLFrameBaseTableViewCell.m
//  GLFrameLib
//
//  Created by 李国梁 on 2020/12/24.
//

#import "GLFrameBaseTableViewCell.h"

@implementation GLFrameBaseTableViewCell

// 如果不使用xib，则Cell走这里
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        NSLog(@"%s", __func__);
    }
    return self;
}

// 如果不使用xib，则View走这里
- (instancetype)initWithFrame:(CGRect)frame {
    if((self = [super initWithFrame:frame])) {
        NSLog(@"%s" , __func__);
    }
    return self;
}

// 如果使用了xib，那么就走这里
- (instancetype)initWithCoder:(NSCoder *)coder {
    if((self =[super initWithCoder:coder])) {
        NSLog(@"%s" , __func__);
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%s" , __func__);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%s" , __func__);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
