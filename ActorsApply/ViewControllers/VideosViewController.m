//
//  VideosViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 9/5/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "VideosViewController.h"
#import "ProfileVideosTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface VideosViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *errorLbl;

@end

@implementation VideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([self->_profileVideos count] == 0)
    {
        _tableView.hidden = YES;
        _errorLbl.hidden = NO;
    }else{
        _errorLbl.hidden = YES;
        _tableView.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self->_profileVideos count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileVideosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileVideosTableViewCell"];
    NSURL *movieURL = [NSURL URLWithString:[_profileVideos objectAtIndex:indexPath.row]];
   // UIImage *image = [self loadImage:movieURL];
    cell.videoThumbView.image = [UIImage imageNamed:@"video_1"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSURL *movieURL = [NSURL URLWithString:[_profileVideos objectAtIndex:indexPath.row]];
    
    [[UIApplication sharedApplication] openURL:movieURL];
    
    
//   MPMoviePlayerController *theMoviPlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
//    theMoviPlayer.controlStyle = MPMovieControlStyleFullscreen;
//    theMoviPlayer.view.transform = CGAffineTransformConcat(theMoviPlayer.view.transform, CGAffineTransformMakeRotation(M_PI_2));
   // UIWindow *backgroundWindow = [[UIApplication sharedApplication] keyWindow];
    //[theMoviPlayer.view setFrame:backgroundWindow.frame];
    //[backgroundWindow addSubview:theMoviPlayer.view];
//    [theMoviPlayer play];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}

- (UIImage*)loadImage : (NSURL*) url{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generate.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
    NSLog(@"err==%@, imageRef==%@", err, imgRef);
    
    return [[UIImage alloc] initWithCGImage:imgRef];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
