//
//  ViewController.m
//  VideoTableview
//
//  Created by BuzzLightYear23 on 16/3/2.
//  Copyright © 2016年 Irving. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "TestVideo.h"
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
@interface ViewController ()
/** 视频数据 */
@property (nonatomic, strong) NSArray *videos;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [TestVideo mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id"};
    }];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/video"]];
    //request.HTTPMethod = @"POST"; // 请求方法
    
    
    //2.创建任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // 解析JSON
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        // 获得视频的模型数组
          self.videos = [TestVideo mj_objectArrayWithKeyValuesArray:dict[@"videos"]];
//        //获得视频数组
//        NSArray *dictArray  = dict[@"videos"];
//        
//        //字典数组->模型数组
//        NSMutableArray  *videoArray = [NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            
//            [videoArray addObject:[TestVideo videoWithDict:dict]];
//        }
//        
//        self.videos = videoArray;
        
        //
        // 刷新表格
        [self.tableView reloadData];
    }];
    
    //启动任务
    [task resume];
}

#pragma mark -数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.videos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *ID = @"video";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    TestVideo *video =self.videos[indexPath.row];
    cell.textLabel.text = video.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时长：%zd" ,video.length];
    

    NSString *image = [@"http://120.25.226.186:32812/" stringByAppendingString:video.image];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    return cell;
    
}

#pragma mark -  代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    TestVideo *video = self.videos[indexPath.row];
    NSString *urlStr = [@"http://120.25.226.186:32812/" stringByAppendingString:video.url];
    
    //创建视频播放器
    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:urlStr]];
    
    //显示视频
    [self presentViewController:vc animated:YES completion:nil];
}



@end
