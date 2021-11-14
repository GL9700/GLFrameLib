//
//  ElementEntity.m
//  GLUIKit
//
//  Created by liguoliang on 2020/11/6.
//

#import "ElementEntity.h"

@implementation ElementEntity
- (NSMutableArray<ElementEntity *> *)children {
    if (!_children) {
        _children = [NSMutableArray array];
    }
    return _children;
}

- (NSMutableArray<TypeProperty *> *)props {
    if (!_props) {
        _props = [NSMutableArray array];
    }
    return _props;
}

@end
