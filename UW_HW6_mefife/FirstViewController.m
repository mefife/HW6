//
//  FirstViewController.m
//  UW_HW6_mefife
//
//  Created by Matthew Fife on 11/7/14.
//  Copyright (c) 2014 Matthew Fife. All rights reserved.
//

#import "FirstViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface FirstViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *MEFImageView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)takePicture:(id)sender {
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.mediaTypes = @[ (__bridge NSString *) kUTTypeImage];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
    NSLog(@"Taking a picture");
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //NSString *mediaType = info[UIImagePickerControllerMediaType];
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if(image ==nil){
        image=info[UIImagePickerControllerOriginalImage];
    }
    if (image !=nil) {
        UIImageWriteToSavedPhotosAlbum(image, nil, NULL, NULL);
    }
    self.MEFImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
