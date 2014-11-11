//
//  MEFTableViewController.m
//  UW_HW6_mefife
//
//  Created by Matthew Fife on 11/9/14.
//  Copyright (c) 2014 Matthew Fife. All rights reserved.
//

#import "MEFTableViewController.h"
#import <Photos/Photos.h>
#import "MEFCollectionView.h"


@interface MEFTableViewController () <UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *albumNames;
@property MEFCollectionView * collectionView;
//@property UINavigationController * navControllerCollectionView;
@end

@implementation MEFTableViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.collectionView = [[MEFCollectionView alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    //[self.navigationController pushViewController:self.collectionView animated:YES];
    
    self.albumNames = [[NSMutableArray alloc]init];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized){
            return;
        }
        self.albumsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
        
        //Enumeration Block
        [self.albumsFetchResult enumerateObjectsUsingBlock:^(PHAssetCollection *collection, NSUInteger idx, BOOL *stop) {
            [self.albumNames addObject:collection.localizedTitle];
        }];
        
        NSLog(@"This view will appear has run");
        //[self.tableView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
            }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSLog(@"%lu",(unsigned long)self.albumsFetchResult.count);
    return self.albumsFetchResult.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //cell.textLabel.text = @"hello";
    cell.textLabel.text = [self.albumNames objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSLog(@"Called");
    return cell;
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    //NSLog(@"When is this called? Segue");
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"My Cell has been tapped");
    //self.collectionView = [[MEFCollectionView alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    //[self.navigationController presentViewController:self.collectionView animated:YES completion:nil];
    self.collectionView.titleToDisplay = [self.albumNames objectAtIndex:indexPath.row];
    self.collectionView.TableAlbums = self.albumsFetchResult;
    [self.navigationController pushViewController:self.collectionView animated:YES];
}

@end
