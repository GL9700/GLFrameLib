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
    else{
        [GLFrameViewProp setCommonProp:prop withTarget:self inContainer:container];
    }
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
        //        UIStackViewDistributionFill = 0,
        //        UIStackViewDistributionFillEqually = 1,
        //        UIStackViewDistributionFillProportionally = 2,
        //        UIStackViewDistributionEqualSpacing = 3,
        //        UIStackViewDistributionEqualCentering = 4,
    }
    else if ([prop.key isEqualToString:@"alignment"] || [prop.key isEqualToString:@"ali"]) {
        self.alignment = [prop.value integerValue];
        //        UIStackViewAlignmentFill = 0,
        //        UIStackViewAlignmentTop = UIStackViewAlignmentLeading = 1,
        //        UIStackViewAlignmentFirstBaseline = 2
        //        UIStackViewAlignmentCenter = 3
        //        UIStackViewAlignmentBottom = UIStackViewAlignmentTrailing = 4,
        //        UIStackViewAlignmentLastBaseline = 5
    }
    else {
        [GLFrameViewProp setCommonProp:prop withTarget:self inContainer:container];
    }
}
@end

@implementation UILabel (GLFrameExt)
- (void)frameSetProp:(TypeProperty *)prop inContainer:(UIViewController *)container {
    if ([prop.key isEqualToString:@"fontColor"] || [prop.key isEqualToString:@"color"]) {
        self.textColor = [UIColor colorFromHexStr:prop.value];
    }
    else if ([prop.key isEqualToString:@"font"]) {
        self.font = [UIFont fontWithName:prop.value size:self.font.pointSize];
    }
    else if ([prop.key isEqualToString:@"fontSize"] || [prop.key isEqualToString:@"size"]) {
        self.font = [self.font fontWithSize:[prop.value intValue]];
    }
    else if ([prop.key isEqualToString:@"aligment"] || [prop.key isEqualToString:@"ali"]) {
        self.textAlignment = NSTextAlignmentLeft;
        /*
         NSTextAlignmentLeft      = 0,    // Visually left aligned
         NSTextAlignmentCenter    = 1,    // Visually centered
         NSTextAlignmentRight     = 2,    // Visually right aligned
         NSTextAlignmentJustified = 3,    // Fully-justified. The last line in a paragraph is natural-aligned.
         NSTextAlignmentNatural   = 4     // Indicates the default alignment for script
         */
    }
    else if ([prop.key isEqualToString:@"line"]) {
        self.numberOfLines = [prop.value intValue];
    }
    else if ([prop.key isEqualToString:@"textAlign"]) {
//        [0 -- 1 -- 2]
        self.textAlignment = [prop.value intValue];
    }
    else {
        [GLFrameViewProp setCommonProp:prop withTarget:self inContainer:container];
    }
}
@end

@implementation UITextField (GLFrameExt)
- (void)frameSetProp:(TypeProperty *)prop inContainer:(UIViewController *)container {
    if ([prop.key isEqualToString:@"fontColor"] || [prop.key isEqualToString:@"color"]) {
        self.textColor = [UIColor colorFromHexStr:prop.value];
    }
    else if ([prop.key isEqualToString:@"font"]) {
        self.font = [UIFont fontWithName:prop.value size:self.font.pointSize];
    }
    else if ([prop.key isEqualToString:@"fontSize"] || [prop.key isEqualToString:@"size"]) {
        self.font = [self.font fontWithSize:[prop.value intValue]];
    }
    else if([prop.key isEqualToString:@"borderColor"]) {
        self.layer.borderColor = [UIColor colorFromHexStr:prop.value].CGColor;
        self.layer.borderWidth = 2;
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
    if ([prop.key isEqualToString:@"title"] || [prop.key isEqualToString:@"text"]) {
        [(UIButton *)self setTitle:prop.value forState:UIControlStateNormal];
    }
    else if ([prop.key isEqualToString:@"fontSize"] || [prop.key isEqualToString:@"size"]) {
        self.titleLabel.font = [UIFont fontWithName:self.titleLabel.font.fontName size:[prop.value intValue]];
    }
    else if ([prop.key isEqualToString:@"fontColor"] || [prop.key isEqualToString:@"color"]) {
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
        /*
         UIViewContentModeScaleToFill   = 0,
         UIViewContentModeScaleAspectFit = 1,
         UIViewContentModeScaleAspectFill = 2,
         UIViewContentModeRedraw        = 3,
         UIViewContentModeCenter         = 4,
         UIViewContentModeTop            = 5,
         UIViewContentModeBottom         = 6,
         UIViewContentModeLeft       = 7,
         UIViewContentModeRight      = 8,
         UIViewContentModeTopLeft    = 9,
         UIViewContentModeTopRight   = 10,
         UIViewContentModeBottomLeft = 11,
         UIViewContentModeBottomRight =12,
         */
    }
    else {
        [GLFrameViewProp setCommonProp:prop withTarget:self inContainer:container];
    }
}
- (void)frameStyle {
    self.contentMode = UIViewContentModeScaleAspectFit;
}
@end
