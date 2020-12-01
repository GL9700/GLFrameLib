//
//  GLFrameManager.m
//  GLFrameLib
//
//  Created by liguoliang on 2020/11/30.
//

#import "GLFrameManager.h"
#import <GLFrameFileManager.h>
#import <ElementEntity.h>
#import <GLFrameRubyParser.h>
#import <GLFrameXMLParser.h>
#import <GLFrameViewMaker.h>

@interface GLFrameManager()
@property (nonatomic) NSDictionary *additional;
@end

@implementation GLFrameManager

+ (void)enableDebug:(BOOL)debug {
    
}

+ (void)registerFrameDict:(NSString *)path {
    NSMutableDictionary *sub = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if(sub){
        [sub addEntriesFromDictionary:[GLFrameManager SharedKit].additional];
        [GLFrameManager SharedKit].additional = [sub copy];
    }
}

+ (instancetype)SharedKit {
    static dispatch_once_t onceToken;
    static GLFrameManager *kitInstance;
    dispatch_once(&onceToken, ^{
        kitInstance = [GLFrameManager new];
    });
    return kitInstance;
}

+ (void)frameFile:(NSString *)NameOrPath inContainer:(id)container complete:(void(^)(UIView *rootView))handleComplete {
    NSString *path = NameOrPath;
    if(path.pathComponents.count==1) {
        path = [[NSBundle mainBundle] pathForResource:NameOrPath.stringByDeletingPathExtension ofType:NameOrPath.pathExtension];
    }
    
    printf("\n***** Start GLUIKit *****\n");
    printf("-> path:\n\t%s\n\n", [path UTF8String]);
    printf("-> container:\n\t%s\n\n", [[NSString stringWithFormat:@"%@", container] UTF8String]);
    NSString *content = [GLFrameFileManager contentFromLocalPath:path];
    ElementEntity *tree = [[GLFrameXMLParser new] treeForContent:content];
    
    GLFrameViewMaker *maker = [GLFrameViewMaker new];
    maker.additional = [GLFrameManager SharedKit].additional;
    maker.handle_Complete = handleComplete;
    maker.targetContainer = container;
    maker.tokenTree = tree;
    [maker makerView];
}

- (NSDictionary *)additional {
    if(!_additional) {
        _additional = [NSDictionary dictionary];
    }
    return _additional;
}
@end
