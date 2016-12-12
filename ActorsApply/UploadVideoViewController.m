//
//  UploadVideoViewController.m
//  ActorsApply
//
//  Created by Kalpesh Mahajan on 20/11/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "UploadVideoViewController.h"
#import "ConnectionManager.h"
#import "WebServiceConstants.h"
#import "SVProgressHUD.h"
#import "RKDropdownAlert.h"
#import "UIImageView+AFNetworking.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface UploadVideoViewController ()
{
    NSMutableArray *videosArray;
    __weak IBOutlet UICollectionView *collectionView;
    NSString *filePath;
    UIImage *uploadImage;
}

@end

@implementation UploadVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    videosArray = [NSMutableArray new];
    videosArray = _profileVideos;
    //[collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return videosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:1];
    if([[videosArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]])
    {
        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[videosArray objectAtIndex:indexPath.row]]]];
    }else if([[videosArray objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]])
    {
        [imageView setImage:[videosArray objectAtIndex:indexPath.row]];
    }
    return cell;
}

- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveClicked:(id)sender {
    [self uploadImage : filePath];
}

- (IBAction)addImageClicked:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Select Video", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Present videos from which to choose
    UIImagePickerController *videoPicker = [[UIImagePickerController alloc] init];
    videoPicker.delegate = self; // ensure you set the delegate so when a video is chosen the right method can be called
    
    videoPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
    // This code ensures only videos are shown to the end user
    videoPicker.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
    
    videoPicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    [self presentViewController:videoPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // This is the NSURL of the video object
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    filePath = [videoURL absoluteString];
    NSLog(@"VideoURL = %@", videoURL);
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)uploadImage : (NSString*)videoPath
{
    [SVProgressHUD show];
   
    NSString *path = [NSString stringWithFormat:@"%@%@",BASE_URL,UPLOAD_VIDEO];
    [ConnectionManager uploadVideo:path videoPath:videoPath completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
        [SVProgressHUD dismiss];
        
        if (succeeded)
        {
            [self.navigationController popViewControllerAnimated:YES];
            [videosArray removeObjectAtIndex:[videosArray count] - 1];
            [videosArray addObject:[responseData objectForKey:@"imgName"]];
            [RKDropdownAlert title:@"INFORMATION" message:[responseData objectForKey:@"message"]];
        }
        else{
            [RKDropdownAlert title:@"INFORMATION" message:errorMsg];
        }
    }];
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
