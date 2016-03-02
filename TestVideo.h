//
//  TestVideo.h
//  VideoTableview
//
//  Created by BuzzLightYear23 on 16/3/2.
//  Copyright © 2016年 Irving. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestVideo : NSObject
/** ID*/
@property(nonatomic ,assign) NSInteger id;
/**视频名字**/
@property(nonatomic,copy) NSString *name;
/** 视频时长**/
@property(nonatomic,assign) NSInteger length;
/**视频图片**/
@property(nonatomic ,copy) NSString *image;
/**视频文件的路径 */
@property(nonatomic,copy) NSString *url;

/**kvc**/
+(instancetype)videoWithDict:(NSDictionary *) dict;
@end
