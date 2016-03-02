//
//  TestVideo.m
//  VideoTableview
//
//  Created by BuzzLightYear23 on 16/3/2.
//  Copyright © 2016年 Irving. All rights reserved.
//

#import "TestVideo.h"

@implementation TestVideo
+(instancetype )videoWithDict:(NSDictionary *)dict
{
    TestVideo *video = [[self alloc] init];
   [video setValuesForKeysWithDictionary:dict];
//    video.name = dict[@"name"];
//    video.length = [dict[@"length"] integerValue];
//    video.url = dict[@"url"];
//    video.image = dict[@"image"];
    
    return video;
    
}
@end
