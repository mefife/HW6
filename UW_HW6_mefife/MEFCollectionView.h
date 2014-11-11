//
//  MEFCollectionView.h
//  UW_HW6_mefife
//
//  Created by Matthew Fife on 11/9/14.
//  Copyright (c) 2014 Matthew Fife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface MEFCollectionView : UICollectionViewController <UICollectionViewDataSource>
@property NSString * titleToDisplay;
@property PHFetchResult * TableAlbums;
@property PHAssetCollection * AlbumSelectedToView;
@property PHFetchResult *Pictures;
@end
