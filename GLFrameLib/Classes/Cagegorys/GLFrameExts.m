//
//  GLFrameExts.m
//  GLUIKit
//
//  Created by liguoliang on 2020/11/23.
//

#import "GLFrameExts.h"
#import <TypeProperty.h>
#import <GLFrameViewProp.h>
#import <SDWebImage/SDWebImage.h>
#import <GLExtensions/UIColor+GLExtension.h>
#import <UIView+Yoga.h>

@implementation GLFrameExts
@end


@implementation UIView (GLFrameExt)
- (void)frameSetProp:(TypeProperty *)prop inContainer:(UIViewController *)container {
    if([prop.key isEqualToString:@"direct"]){
        prop.key = @"flexDirection";
        NSDictionary *propDict = @{
            @"row": @(YGFlexDirectionRow),
            @"col": @(YGFlexDirectionColumn)
        };
        if([propDict.allKeys containsObject:prop.value]) {
            prop.value = propDict[prop.value];
        }
    }
    if([prop.key isEqualToString:@"grow"]){
        prop.key = @"flexGrow";
    }
    if([prop.key isEqualToString:@"alignMainAxis"]) {
        prop.key = @"justifyContent";
        NSDictionary *propDict = @{
            @"start"    :   @(YGJustifyFlexStart),
            @"center"   :   @(YGJustifyCenter),
            @"end"      :   @(YGJustifyFlexEnd),
            @"between"  :   @(YGJustifySpaceBetween),
            @"around"   :   @(YGJustifySpaceAround)
        };
        if([propDict.allKeys containsObject:prop.value]) {
            prop.value = propDict[prop.value];
        }
    }
    if([prop.key isEqualToString:@"alignSubAxis"]) {
        prop.key = @"alignItems";
        NSDictionary *propDict = @{
            @"start"    :   @(YGAlignFlexStart),
            @"center"   :   @(YGAlignCenter),
            @"end"      :   @(YGAlignFlexEnd),
            @"between"  :   @(YGAlignSpaceBetween),
            @"baseline" :   @(YGAlignBaseline),
            @"around"   :   @(YGAlignSpaceAround)
        };
        if([propDict.allKeys containsObject:prop.value]) {
            prop.value = propDict[prop.value];
        }
    }
    [GLFrameViewProp setCommonProp:prop withTarget:self inContainer:container];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"undefinedKey:%@ value:%@", key, value);
}
@end

@implementation UIStackView (GLFrameExt)
- (void)frameSetProp:(TypeProperty *)prop inContainer:(UIViewController *)container {
    if ([prop.key isEqualToString:@"spacing"] || [prop.key isEqualToString:@"sp"]) {
        self.spacing = [prop.value floatValue];
    }
    else if ([prop.key isEqualToString:@"axis"]) {
        self.axis = [prop.value integerValue];
    }
    else if ([prop.key isEqualToString:@"distribution"] || [prop.key isEqualToString:@"dis"]) {
        self.distribution = [prop.value integerValue];
    }
    else if ([prop.key isEqualToString:@"alignment"] || [prop.key isEqualToString:@"ali"]) {
        self.alignment = [prop.value integerValue];
    }
    else {
        [GLFrameViewProp setCommonProp:prop withTarget:self inContainer:container];
    }
}
@end

@implementation UILabel (GLFrameExt)
- (void)frameSetProp:(TypeProperty *)prop inContainer:(UIViewController *)container {
    if ([prop.key isEqualToString:@"color"] || [prop.key isEqualToString:@"textColor"]) {
        self.textColor = [UIColor colorFromHexStr:prop.value];
    }
    else if ([prop.key isEqualToString:@"font"] || [prop.key isEqualToString:@"textFont"]) {
        self.font = [UIFont fontWithName:prop.value size:self.font.pointSize];
    }
    else if ([prop.key isEqualToString:@"size"] || [prop.key isEqualToString:@"textSize"]) {
        self.font = [self.font fontWithSize:[prop.value intValue]];
    }
    else if ([prop.key isEqualToString:@"aligment"] || [prop.key isEqualToString:@"textAlign"]) {
        if([prop.value isEqualToString:@"center"]) {
            self.textAlignment = NSTextAlignmentCenter;
        }else if([prop.value isEqualToString:@"right"]) {
            self.textAlignment = NSTextAlignmentRight;
        }else if([prop.value isEqualToString:@"justified"]) {
            self.textAlignment = NSTextAlignmentJustified;
        }else if([prop.value isEqualToString:@"natural"]) {
            self.textAlignment = NSTextAlignmentNatural;
        }else{
            self.textAlignment = NSTextAlignmentLeft;
        }
    }
    else if ([prop.key isEqualToString:@"line"]) {
        self.numberOfLines = [prop.value intValue];
    }
    else {
        [GLFrameViewProp setCommonProp:prop withTarget:self inContainer:container];
    }
}
@end

@implementation UITextField (GLFrameExt)
- (void)frameSetProp:(TypeProperty *)prop inContainer:(UIViewController *)container {
    if ([prop.key isEqualToString:@"color"] || [prop.key isEqualToString:@"textColor"]) {
        self.textColor = [UIColor colorFromHexStr:prop.value];
    }
    else if ([prop.key isEqualToString:@"font"] || [prop.key isEqualToString:@"textFont"]) {
        self.font = [UIFont fontWithName:prop.value size:self.font.pointSize];
    }
    else if ([prop.key isEqualToString:@"size"] || [prop.key isEqualToString:@"textSize"]) {
        self.font = [self.font fontWithSize:[prop.value intValue]];
    }
    
    else{
        [GLFrameViewProp setCommonProp:prop withTarget:self inContainer:container];
    }
}
@end

@implementation UIButton (GLFrameExt)
+ (instancetype)frameNew {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    return button;
}
- (void)frameSetProp:(TypeProperty *)prop inContainer:(UIViewController *)container {
    if ([prop.key isEqualToString:@"text"]) {
        [(UIButton *)self setTitle:prop.value forState:UIControlStateNormal];
    }
    else if ([prop.key isEqualToString:@"size"] || [prop.key isEqualToString:@"textSize"]) {
        self.titleLabel.font = [UIFont fontWithName:self.titleLabel.font.fontName size:[prop.value intValue]];
    }
    else if ([prop.key isEqualToString:@"color"] || [prop.key isEqualToString:@"textColor"]) {
        [self setTitleColor:[UIColor colorFromHexStr:prop.value] forState:UIControlStateNormal];
    }
    else if([prop.key isEqualToString:@"imgAtClock"]) {
        int postion = [prop.value intValue];
        [self sizeToFit];
        CGSize imageSize = self.imageView.frame.size;
        CGSize titleSize = self.titleLabel.frame.size;
        switch (postion) {
            case 12:
                self.titleEdgeInsets = UIEdgeInsetsMake((imageSize.height),-imageSize.width,0,0);
                self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height),0,0,-titleSize.width);
                break;
            case 3:
                self.titleEdgeInsets = UIEdgeInsetsMake(0,-imageSize.width*2-10,0,0);
                self.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-self.titleLabel.frame.size.width*2);
                break;
            case 6:
                self.titleEdgeInsets = UIEdgeInsetsMake(-(imageSize.height),-imageSize.width-10,0,0);
                self.imageEdgeInsets = UIEdgeInsetsMake((titleSize.height),0,0,-titleSize.width-10);
                break;
            case 9:
                self.titleEdgeInsets = UIEdgeInsetsMake(0,0,0,0);
                self.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,0);
                break;
            default:
                self.titleEdgeInsets = UIEdgeInsetsZero;
                self.imageEdgeInsets = UIEdgeInsetsZero;
                break;
        }
    }
    else {
        [GLFrameViewProp setCommonProp:prop withTarget:self inContainer:container];
    }
}
@end

@implementation UIImageView (GLFrameExt)
- (void)frameSetProp:(TypeProperty *)prop inContainer:(UIViewController *)container {
    if ([prop.key isEqualToString:@"src"]) {
        if([((NSString *)prop.value) hasPrefix:@"http"]) {
            [(UIImageView *)self sd_setImageWithURL:[NSURL URLWithString:prop.value]];
        }else{
            [self setImage:[UIImage imageNamed:prop.value]];
        }
    }
    else if ([prop.key isEqualToString:@"mode"]) {
        self.contentMode = [prop.value intValue];
        if([prop.value isEqualToString:@"scaleToFill"]) {
            self.contentMode = UIViewContentModeScaleToFill;
        }
        else if([prop.value isEqualToString:@"scaleAspectFit"]) {
            self.contentMode = UIViewContentModeScaleAspectFit;
        }
        else if([prop.value isEqualToString:@"scaleAspectFill"]) {
            self.contentMode = UIViewContentModeScaleAspectFill;
        }
    }
    else {
        [GLFrameViewProp setCommonProp:prop withTarget:self inContainer:container];
    }
}
- (void)frameStyle {
    self.contentMode = UIViewContentModeScaleAspectFit;
}
@end
