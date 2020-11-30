//
//  ElementEntity.h
//  GLUIKit
//
//  Created by liguoliang on 2020/11/6.
//

#import <Foundation/Foundation.h>
@class TypeProperty;


@interface ElementEntity : NSObject
@property (nonatomic) NSString *tagName;
@property (nonatomic) NSMutableArray<ElementEntity *> *subs;
@property (nonatomic) NSMutableArray<TypeProperty *> *props;
@property (nonatomic) NSString *name;
@property (nonatomic) ElementEntity *superObj;
@end
