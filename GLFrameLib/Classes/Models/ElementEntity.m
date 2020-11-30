//
//  ElementEntity.m
//  GLUIKit
//
//  Created by liguoliang on 2020/11/6.
//

#import "ElementEntity.h"

@implementation ElementEntity
- (NSMutableArray<ElementEntity *> *)subs {
    if (!_subs) {
        _subs = [NSMutableArray array];
    }
    return _subs;
}

- (NSMutableArray<TypeProperty *> *)props {
    if (!_props) {
        _props = [NSMutableArray array];
    }
    return _props;
}

@end
