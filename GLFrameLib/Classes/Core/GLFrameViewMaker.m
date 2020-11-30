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

#define kDictFile @"GLUIDict"

@interface GLFrameViewMaker ()
@property (nonatomic) NSUInteger index;
@end

@implementation GLFrameViewMaker

- (void)setAdditional:(NSDictionary *)additional {
    _additional = [additional copy];
    printf("-> [conf]\n\t...sub additional length:%lu\n\n", additional.allKeys.count);
}

- (void)makerView {
    [self renderTree:self.tokenTree];
}

- (void)renderTree:(ElementEntity *)root {
    printf("-> [core]\n\t...start Render\n\n");
    UIView *rootView = [self viewFromElementWithTokenTree:root];
    printf("-> [core]\n\t...complete Render\n\n");
    if (self.handle_Complete) {
        self.handle_Complete(rootView);
    }
    printf("***** Render Complete *****\n\n");
    [rootView.yoga applyLayoutPreservingOrigin:YES];
    [rootView.yoga markDirty];
}

- (UIView *)makeViewFromClassName:(NSString *)name {
    if (name == nil) return nil;
    printf("-> [render]\n\t...not found View...will Create...%s\n\n", name.UTF8String);
    NSString *className = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    UIView *instance = nil;
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSString *path = [bundle pathForResource:kDictFile ofType:@"plist"];
    static NSDictionary *dict;
    if (!dict) {
        dict = [NSDictionary dictionaryWithContentsOfFile:path];
        printf("-> [conf]\n\t...root additional length:%lu\n\n",(unsigned long)dict.allKeys.count);
        if (self.additional != nil) {
            NSMutableDictionary *mdict = [dict mutableCopy];
            [mdict addEntriesFromDictionary:self.additional];
            dict = [mdict copy];
        }
    }
    Class cls;
    if ([dict.allValues containsObject:className]) {
        NSString *key = [dict allKeysForObject:className].firstObject;
        cls = NSClassFromString(key);
    }
    if ([cls conformsToProtocol:NSProtocolFromString(@"GLFrameBaseProcotol")] &&
        [cls respondsToSelector:NSSelectorFromString(@"frameNew")]) {
        printf("-> [custom init]\n\t...-[%s frameNew]\n\n",NSStringFromClass(cls).UTF8String);
        instance = [cls frameNew];
    }
    else {
        instance = [cls new];
    }
    printf("-> [render]\n\t...not found View... did Create...%s\n\n", NSStringFromClass(instance.class).UTF8String);
    return instance;
}

- (UIView *)viewFromElementWithTokenTree:(ElementEntity *)element {
    UIView *elementInstance;
    if (element.tagName) {
        Method method = class_getInstanceMethod([self.targetContainer class], NSSelectorFromString(element.tagName));
        if (method) {
            SEL select = NSSelectorFromString(element.tagName);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            elementInstance = [self.targetContainer performSelector:select];
#pragma clang diagnostic pop
            if(elementInstance){
                printf("-> [render]\n\t...finded bundle View...%s\n\n", element.tagName.UTF8String);
            }
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
            printf("->[custom style]\n\t...-[%s frameStyle]\n\n",NSStringFromClass(elementInstance.class).UTF8String);
            [elementInstance frameStyle];
        }
        for (TypeProperty *prop in element.props) {
            printf("-> [Setting Prop Common]\n\t...%s:%s\n\n", prop.key.UTF8String, [prop.value UTF8String]);
            [elementInstance frameSetProp:prop inContainer:self.targetContainer];
        }
        for (ElementEntity *son in element.subs) {
            UIView *subitem = [self viewFromElementWithTokenTree:son];
            if ([elementInstance isKindOfClass:[UIStackView class]]) {
                [(UIStackView *)elementInstance addArrangedSubview:subitem];
            }
            else if ([elementInstance isKindOfClass:[UIView class]]) {
                [elementInstance addSubview:subitem];
            }
        }
    }
    return elementInstance;
}

@end
