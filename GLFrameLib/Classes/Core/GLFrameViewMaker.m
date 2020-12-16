//
//  GLFrameViewMaker.m
//  GLFrameLib
//
//  Created by liguoliang on 2020/11/30.
//

#import "GLFrameViewMaker.h"
#import <UIView+Yoga.h>
#import <GLFrameExts.h>
#import <objc/message.h>
#import <TypeProperty.h>
#import "GLFrameLib_Dev_PCH.h"

@interface GLFrameViewMaker ()
@property (nonatomic) NSUInteger index;
@end

@implementation GLFrameViewMaker

- (void)makerView {
    [self renderTree:self.tokenTree];
}

- (void)renderTree:(ElementEntity *)root {
    GLFL_IN_DEV_MODE==0 ? : printf("-> [core]\n\t...start Render\n\n");
    UIView *rootView = [self viewFromElementWithTokenTree:root];
    GLFL_IN_DEV_MODE==0 ? : printf("-> [core]\n\t...complete Render\n\n");
    if (self.handle_Complete) {
        self.handle_Complete(rootView);
    }
    if(CGRectEqualToRect(rootView.frame, CGRectZero)) {
        rootView.frame = rootView.superview.bounds;
    }
    [rootView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    [rootView.yoga applyLayoutPreservingOrigin:YES];
    GLFL_IN_DEV_MODE==0 ? :printf("***** Render Complete *****\n\n");
}

- (UIView *)makeViewFromClassName:(NSString *)name {
    if (name == nil) {
        return nil;
    }
    GLFL_IN_DEV_MODE==0 ? : printf("-> [render]\n\t...not found View...will Create...%s\n\n", name.UTF8String);
    NSString *className = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    UIView *instance = nil;
    
    Class cls;
    if ([self.additional.allValues containsObject:className]) {
        NSString *key = [self.additional allKeysForObject:className].firstObject;
        cls = NSClassFromString(key);
    }
    if ([cls conformsToProtocol:NSProtocolFromString(@"GLFrameBaseProcotol")] &&
        [cls respondsToSelector:NSSelectorFromString(@"frameNew")]) {
        GLFL_IN_DEV_MODE==0 ? :printf("-> [custom init]\n\t...-[%s frameNew]\n\n", NSStringFromClass(cls).UTF8String);
        instance = [cls frameNew];
    }
    else {
        instance = [cls new];
    }
    GLFL_IN_DEV_MODE==0 ? :printf("-> [render]\n\t...not found View... did Create...%s\n\n", NSStringFromClass(instance.class).UTF8String);
    return instance;
}

- (UIView *)viewFromElementWithTokenTree:(ElementEntity *)element {
    UIView *elementInstance;
    if (element.bundleProperty) {
        Method method = class_getInstanceMethod([self.targetContainer class], NSSelectorFromString(element.bundleProperty));
        if (method) {
            SEL select = NSSelectorFromString(element.bundleProperty);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            elementInstance = [self.targetContainer performSelector:select];
#pragma clang diagnostic pop
            if (elementInstance) {
                GLFL_IN_DEV_MODE==0 ? : printf("-> [render]\n\t...finded bundle View...%s\n\n", element.bundleProperty.UTF8String);
            }
        }
        if (elementInstance == nil) {
            GLFL_IN_DEV_MODE==0 ? : printf("-> [ ‼️ Warning ‼️ ]\n\t...Not found BundleName: %s in Container (%s)\n\n", element.bundleProperty.UTF8String, NSStringFromClass([self.targetContainer class]).UTF8String);
        }
    }
    if ([element isKindOfClass:[ElementEntity class]] && elementInstance == nil) {
        elementInstance = [self makeViewFromClassName:element.name];
    }
    if (elementInstance) {
        [elementInstance configureLayoutWithBlock: ^(YGLayout *_Nonnull layout) {
            layout.isEnabled = YES;
        }];
        if ([elementInstance conformsToProtocol:NSProtocolFromString(@"GLFrameBaseProcotol")] &&
            [elementInstance respondsToSelector:NSSelectorFromString(@"frameStyle")]) {
            GLFL_IN_DEV_MODE==0 ? :printf("->[custom style]\n\t...-[%s frameStyle]\n\n", NSStringFromClass(elementInstance.class).UTF8String);
            [elementInstance frameStyle];
        }
        for (ElementEntity *son in element.children) {
            UIView *subitem = [self viewFromElementWithTokenTree:son];
            if ([elementInstance isKindOfClass:[UIStackView class]]) {
                [(UIStackView *)elementInstance addArrangedSubview:subitem];
            }
            else if ([elementInstance isKindOfClass:[UIView class]]) {
                [elementInstance addSubview:subitem];
            }
        }
        for (TypeProperty *prop in element.props) {
            GLFL_IN_DEV_MODE==0 ? :printf("-> [Setting Prop Common]\n\t...%s:%s\n\n", prop.key.UTF8String, [prop.value UTF8String]);
            [elementInstance frameSetProp:prop inContainer:self.targetContainer];
        }
    }
    return elementInstance;
}

@end
