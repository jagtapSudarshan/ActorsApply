//
//  UpdateImageViewController.m
//  ActorsApply
//
//  Created by Sandip Mahajan on 11/4/16.
//  Copyright © 2016 Bhushan mahajan. All rights reserved.
//

#import "UpdateImageViewController.h"
#import "ConnectionManager.h"
#import "WebServiceConstants.h"
#import "SVProgressHUD.h"
#import "RKDropdownAlert.h"
#import <UIImageView+AFNetworking.h>

@interface UpdateImageViewController ()
{
    NSMutableArray *imagesArray;
    __weak IBOutlet UICollectionView *collectionView;
}

@end

@implementation UpdateImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imagesArray = [NSMutableArray new];
    imagesArray = _profileImages;
    [collectionView reloadData];
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
    return imagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:1];
    [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[imagesArray objectAtIndex:indexPath.row]]]];
    return cell;
}

- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveClicked:(id)sender {

}

- (IBAction)addImageClicked:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Gallery", @"Camera", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        // Camera
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.allowsEditing = YES;
            
            [self presentModalViewController:imagePicker animated:YES];
        }
    }
    else{
        // Gallery
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
        
        [self presentModalViewController:imagePicker animated:YES];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Get Image URL from Library
 //   UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
//    NSString *str = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    UIImage *image = (UIImage *)info[UIImagePickerControllerOriginalImage];
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imageSubdirectory = [documentsDirectory stringByAppendingPathComponent:@"photos"];
    
    NSString *filePath = [imageSubdirectory stringByAppendingPathComponent:@"photo.png"];
    
    // Convert UIImage object into NSData (a wrapper for a stream of bytes) formatted according to PNG spec
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:filePath atomically:YES];
    
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self uploadImage : image : filePath];
        
       
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)uploadImage : (UIImage*) image : (NSString*)imagePath
{
    [SVProgressHUD show];
    
   // [ConnectionManager callDeleteMethod:[NSString stringWithFormat:@"%@%@",BASE_URL,UPLOAD_PHOTO] completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
    [ConnectionManager uploadimage:image Path:[NSString stringWithFormat:@"%@%@",BASE_URL,UPLOAD_PHOTO] imggName:imagePath completionBlock:^(BOOL succeeded, id responseData, NSString *errorMsg) {
        
        [SVProgressHUD dismiss];
        
        if (succeeded) {
            [self.navigationController popViewControllerAnimated:YES];
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
