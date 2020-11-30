//
//  GLFrameExts.h
//  GLUIKit
//
//  Created by liguoliang on 2020/11/23.
//

#import <Foundation/Foundation.h>
#import <GLFrameBaseProcotol.h>

@interface GLFrameExts : NSObject
@end

@interface UIView (GLFrameExt) <GLFrameBaseProcotol>@end

@interface UIStackView (GLFrameExt) <GLFrameBaseProcotol>@end

@interface UILabel (GLFrameExt) <GLFrameBaseProcotol>@end

@interface UITextField (GLFrameExt) <GLFrameBaseProcotol>@end

@interface UIButton (GLFrameExt) <GLFrameBaseProcotol>@end

@interface UIImageView (GLFrameExt) <GLFrameBaseProcotol>@end
