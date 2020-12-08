//
//  GLFrameViewProp.m
//  GLFrameLib
//
//  Created by liguoliang on 2020/11/30.
//

#import "GLFrameViewProp.h"
#import <TypeProperty.h>
#import <UIView+Yoga.h>
#import "UIColor+GLExtension.h"


@implementation GLFrameViewProp
+ (void)setCommonProp:(TypeProperty *)prop withTarget:(UIView *)target inContainer:(UIViewController *)container {
    if([prop.value isKindOfClass:[NSString class]]) {
        printf("-> [Setting Prop Common]\n\t...%s:%s\n\n", prop.key.UTF8String, [prop.value UTF8String]);
    }else if([prop.value isKindOfClass:[NSNumber class]]){
        printf("-> [Setting Prop Common]\n\t...%s:%.2f\n\n", prop.key.UTF8String, [prop.value floatValue]);
    }
    if ([target isKindOfClass:[UIView class]]) {
        if ([[self keywords_enum] containsObject:prop.key]) {
            [target configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
                layout.isEnabled = YES;
                [layout setValue:[NSNumber numberWithInt:[prop.value intValue]] forKey:prop.key];
            }];
        }
        else if ([[self keywords_float] containsObject:prop.key]) {
            [target configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
                layout.isEnabled = YES;
                [layout setValue:[NSNumber numberWithFloat:[prop.value floatValue]] forKey:prop.key];
            }];
        }
        else if ([[self keywords_value] containsObject:prop.key]) {
            
            [target configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
                layout.isEnabled = YES;
                NSValue *v;
                YGValue value;
                if([prop.value hasSuffix:@"%"]){
                    value = YGPercentValue([prop.value floatValue]);
                }else{
                    value = YGPointValue([prop.value floatValue]);
                }
                v = [NSValue value:&value withObjCType:@encode(YGValue)];
                [layout setValue:v forKey:prop.key];
            }];
        }
        
        /// MARK: --- common property ---
        else if ([prop.key isEqualToString:@"bgColor"]) {
            [target setValue:[UIColor colorFromHexStr:prop.value] forKey:@"backgroundColor"];
        }
        else if([prop.key isEqualToString:@"borderColor"]) {
            target.layer.borderColor = [UIColor colorFromHexStr:prop.value].CGColor;
        }
        else if([prop.key isEqualToString:@"borderWidth"]) {
            target.layer.borderWidth = [prop.value floatValue];
        }
        else if([prop.key isEqualToString:@"cornerRadius"]) {
            target.layer.cornerRadius = [prop.value floatValue];
        }
        
        /// MARK: --- Event ---
        else if ([prop.key isEqualToString:@"onTouch"] && container!=nil) {
            if([container respondsToSelector:NSSelectorFromString(prop.value)]) {
                target.userInteractionEnabled = YES;
                if([target isKindOfClass:[UIButton class]]) {
                    [(UIButton *)target addTarget:container action:NSSelectorFromString(prop.value) forControlEvents:UIControlEventTouchUpInside];
                }else{
                    [target addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:container action:NSSelectorFromString(prop.value)]];
                }
            }else{
                printf("-> [ ‼️ Warning ‼️ ]\n\t...Not found Method: 🔝🔝🔝🔝🔝 in Container (%s)\n\n", NSStringFromClass(container.class).UTF8String);
            }
        }
        
        /// MARK: --- Other ---
        else {
            [target setValue:prop.value forKey:prop.key];
        }
    }
}
+ (NSArray<NSString *> *)keywords_value {
    return @[
        @"flexBasis",
        @"start", @"end", @"left", @"top", @"right", @"bottom",  @"width", @"height", @"minWidth", @"minHeight", @"maxWidth", @"maxHeight" ,
        @"margin", @"marginLeft", @"marginTop", @"marginRight", @"marginBottom", @"marginStart", @"marginEnd", @"marginHorizontal", @"marginVertical",
        @"padding", @"paddingLeft", @"paddingTop", @"paddingRight", @"paddingBottom", @"paddingStart", @"paddingEnd", @"paddingHorizontal", @"paddingVertical",
    ];
}
+ (NSArray<NSString *> *)keywords_float {
    return @[
        @"flex", @"flexShrink",
        @"flexGrow", @"borderLeftWidth", @"borderTopWidth", @"borderRightWidth", @"borderBottomWidth", @"borderStartWidth", @"borderEndWidth", @"borderWidth"
    ];
}
+ (NSArray<NSString *> *)keywords_enum {
    return @[
        @"direction",
        @"flexDirection", @"justifyContent", @"alignContent", @"alignItems", @"alignSelf", @"position", @"flexWrap", @"overflow", @"display"
    ];
}
@end
