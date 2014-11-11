//
//  MEFCollectionView.m
//  UW_HW6_mefife
//
//  Created by Matthew Fife on 11/9/14.
//  Copyright (c) 2014 Matthew Fife. All rights reserved.
//

#import "MEFCollectionView.h"
#import <Photos/Photos.h>
#import "MEFTableViewController.h"


static NSString * const CellIdentifer = @"Cell";


@interface MEFCollectionView () <UICollectionViewDelegateFlowLayout>


@end

@implementation MEFCollectionView


-(id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout;
{
    if (!(self = [super initWithCollectionViewLayout:layout])) {
        return nil;
    }
    
    //self.BirthdayList = [NSMutableArray array];
    return self;
}


-(void)viewDidLoad;
{
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //self.titleToDisplay = [[NSString alloc] init];
    self.navigationItem.title = self.titleToDisplay;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifer];
    
    
}

-(void)viewWillAppear:(BOOL)animated;
{
    //for (UILabel *MEFlabel in self.collectionView.subviews) {
    //    NSLog(@"I have views");
    //    [MEFlabel removeFromSuperview];
    //}
    
    //Get photo album requested
    [self.TableAlbums enumerateObjectsUsingBlock:^(PHAssetCollection *assetCollection, NSUInteger idx, BOOL *stop) {
        //NSLog(@" Here is....%@",assetCollection.localizedTitle);
        if (assetCollection.localizedTitle == self.titleToDisplay) {
            self.AlbumSelectedToView = assetCollection;
            self.Pictures = [[PHFetchResult alloc] init];
            self.Pictures = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            NSLog(@"here is asset %@",assetCollection);
            //NSLog(@"Please display only once");
            NSLog(@"Here is the title %@",assetCollection.localizedTitle);
        }
    }];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSLog(@"Photo Countsdfser %lu",(unsigned long)self.Pictures.count);
    return self.Pictures.count;
    
    //return self.TableAlbums.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifer forIndexPath:indexPath];
    NSAssert(cell != nil, @"Expected a Cell");
    
    
    // Clear contents of old labels
    
    for (UIImageView *MEFlabel in cell.contentView.subviews) {
        [MEFlabel removeFromSuperview];
    }
    //
    
    
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    __block UIImage * image = [[UIImage alloc] init];
    
    PHAsset *thing = [self.Pictures objectAtIndex:indexPath.row];
    
    [[PHImageManager defaultManager] requestImageForAsset:thing
                                               targetSize:cell.contentView.bounds.size
                                              contentMode:PHImageContentModeAspectFill
                                                  options:nil
                                            resultHandler:^(UIImage *result, NSDictionary *info) {
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                            image = result;
                                                        //NSLog(@"image is: %@", image);
                                                        });
    
                                            }];
    

    
    imageView.image = image;
    NSLog(@" Make this non-nil: %@", imageView.image);
    
    [cell.contentView addSubview:imageView];
    
    // Clear contents of old labels
    
    //for (UILabel *MEFlabel in cell.contentView.subviews) {
    //    [MEFlabel removeFromSuperview];
   //}
    
    ////////
    
    // Get the person Object from MEFBirthday
//    NSLog(@"Here is how many items the Collection is seeing: %lu", (unsigned long)self.BirthdayList.count);
//    MEFBirthday * personObject = self.BirthdayList[indexPath.item];
//    
//    cell.backgroundColor = [UIColor lightGrayColor];
//    // Set up two labels to hold the date and name
//    CGRect nameLocation = cell.contentView.bounds;
//    nameLocation.size.width = 100.0f;
//    nameLocation.origin.x = cell.contentView.bounds.origin.x + 60.0f;
//    nameLocation.origin.y  = cell.contentView.bounds.origin.y - 25.0f;
//    
//    
//    UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLocation];
//    nameLabel.text = personObject.Name;
//    [cell.contentView addSubview:nameLabel];
//    
//    /////////////////
//    
//    CGRect dateLocation = cell.contentView.bounds;
//    dateLocation.origin.x   = cell.contentView.bounds.origin.x + 50.0f;
//    UILabel *dateLabel = [[UILabel alloc] initWithFrame:dateLocation];
//    dateLabel.text = [NSDateFormatter localizedStringFromDate:personObject.Bday dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
//    [cell.contentView addSubview:dateLabel];
//    // Configure the cell
   [cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    return cell;
}


#define GAP (0.25f)

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat edgeLength = collectionView.frame.size.width/2.0f - GAP;
    return (CGSize){.width = edgeLength, .height = 80.0f};
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return GAP;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return GAP;
}
@end

