//
//  ElementEntity.h
//  GLUIKit
//
//  Created by liguoliang on 2020/11/6.
//

#import <Foundation/Foundation.h>
#import <TypeProperty.h>


@interface ElementEntity : NSObject

/// [GLFrameLib] bundle name
@property (nonatomic) NSString *tagName;

/// [GLFrameLib] <ElementEntity *>sub name
@property (nonatomic) NSMutableArray<ElementEntity *> *children;

/// [GLFrameLib] <TypeProperty *>props
@property (nonatomic) NSMutableArray<TypeProperty *> *props;

/// [GLFrameLib] Name
@property (nonatomic) NSString *name;

/// [GLFrameLib] super ElementEntity
@property (nonatomic) ElementEntity *parent;
@end
