//
//  TypeProperty.h
//  GLUIKit
//
//  Created by liguoliang on 2020/11/6.
//

#import <Foundation/Foundation.h>

@interface TypeProperty : NSObject
@property (nonatomic) NSString *key;
@property (nonatomic) id value;
@property (nonatomic, readonly) NSString *row;
+ (instancetype)createPropertyEntityFromElementRow:(NSString *)row;
@end
