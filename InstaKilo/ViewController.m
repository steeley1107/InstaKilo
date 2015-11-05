//
//  ViewController.m
//  InstaKilo
//
//  Created by Steele on 2015-11-04.
//  Copyright © 2015 Steele. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "Photos.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSMutableArray *photosArray;
@property (nonatomic) NSArray *locationNames;
@property (nonatomic) NSMutableArray *locationsphotosArray;
@property (nonatomic)NSMutableDictionary *imageDictionary;
@property (nonatomic)NSArray *keysArray;
@property (nonatomic)NSArray *images;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photosArray = [NSMutableArray new];
    self.locationNames = [NSArray new];
    
    Photos *photo01 = [[Photos alloc]initWithImage:[UIImage imageNamed:@"IMG_1013.JPG"] location:@"Toronto" andGroup:@"Nature"];
    Photos *photo02 = [[Photos alloc]initWithImage:[UIImage imageNamed:@"IMG_1017.JPG"] location:@"Toronto" andGroup:@"Nature"];
    Photos *photo03 = [[Photos alloc]initWithImage:[UIImage imageNamed:@"IMG_1018.JPG"] location:@"Vancouver" andGroup:@"Nature"];
    Photos *photo04 = [[Photos alloc]initWithImage:[UIImage imageNamed:@"IMG_1262.JPG"] location:@"Toronto" andGroup:@"Travel"];
    Photos *photo05 = [[Photos alloc]initWithImage:[UIImage imageNamed:@"IMG_1009.JPG"] location:@"Toronto" andGroup:@"Nature"];
    Photos *photo06 = [[Photos alloc]initWithImage:[UIImage imageNamed:@"IMG_1361.JPG"] location:@"Toronto" andGroup:@"Travel"];
    Photos *photo07 = [[Photos alloc]initWithImage:[UIImage imageNamed:@"IMG_1263.JPG"] location:@"Toronto" andGroup:@"Travel"];
    Photos *photo08 = [[Photos alloc]initWithImage:[UIImage imageNamed:@"IMG_1377.JPG"] location:@"Toronto" andGroup:@"Travel"];
    Photos *photo09 = [[Photos alloc]initWithImage:[UIImage imageNamed:@"IMG_1374.JPG"] location:@"Toronto" andGroup:@"Travel"];
    Photos *photo10 = [[Photos alloc]initWithImage:[UIImage imageNamed:@"IMG_1421.JPG"] location:@"Vancouver" andGroup:@"Travel"];
    
    [self.photosArray addObject:photo01];
    [self.photosArray addObject:photo02];
    [self.photosArray addObject:photo03];
    [self.photosArray addObject:photo04];
    [self.photosArray addObject:photo05];
    [self.photosArray addObject:photo06];
    [self.photosArray addObject:photo07];
    [self.photosArray addObject:photo08];
    [self.photosArray addObject:photo09];
    [self.photosArray addObject:photo10];
    
    [self sortByLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  self.keysArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSString * location = [self.keysArray objectAtIndex:section];
    NSArray *thisArray = [self.imageDictionary objectForKey:location];
    return thisArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    NSString *location = [self.keysArray objectAtIndex:indexPath.section];
    self.images = [self.imageDictionary objectForKey:location];
    
    Photos *photo = [self.images objectAtIndex:indexPath.item];
    cell.imageView.image = photo.image;
    
    return cell;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headerView.sectionTitle.text = [self.keysArray objectAtIndex:indexPath.section];
        return headerView;
    }
    return nil;
}


-(void)sortByLocation {
    
    NSMutableArray *dataArray = [NSMutableArray array];
    self.imageDictionary = [NSMutableDictionary new];
    
    for (Photos *photo in self.photosArray) {
        
        dataArray = [self.imageDictionary[photo.location] mutableCopy];
        if (!dataArray) {
            dataArray = [NSMutableArray new];
        }
        [dataArray addObject:photo];
        self.imageDictionary[photo.location] = dataArray;
    }
    self.keysArray = [self.imageDictionary allKeys];
    [self.collectionView reloadData];
}

-(void)sortByGroup {
    
    NSMutableArray *dataArray = [NSMutableArray array];
    self.imageDictionary = [NSMutableDictionary new];
    
    for (Photos *photo in self.photosArray) {
        
        dataArray = [self.imageDictionary[photo.group] mutableCopy];
        if (!dataArray) {
            dataArray = [NSMutableArray new];
        }
        [dataArray addObject:photo];
        self.imageDictionary[photo.group] = dataArray;
    }
    self.keysArray = [self.imageDictionary allKeys];
    [self.collectionView reloadData];
}


- (IBAction)sortSelctor:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self sortByLocation];
            break;
        case 1:
            [self sortByGroup];
            break;
            
        default:
            break;
    }
}

@end
