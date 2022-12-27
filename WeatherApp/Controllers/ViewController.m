//
//  ViewController.m
//  WeatherApp
//
//  Created by Mutlu Çalkan on 27.12.2022.
//

#pragma mark - Frameworks
#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "CollectionViewCell.h"

#pragma mark - Interface
@interface ViewController () <UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherConditionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *cloudsLabel;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

#pragma mark - Implementation
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.dataSource = self;
    [self configureNavBar];
}

#pragma mark - ConfigureNavBar
- (void)configureNavBar{
    UIImage *image = [UIImage systemImageNamed:@"magnifyingglass"];
    
    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(segueToSearchVC)];
    
    self.navigationItem.rightBarButtonItem = plusButton;
    self.navigationItem.rightBarButtonItem.tintColor = UIColor.blackColor;
    
    //self.navigationItem.title = @"London";
}

#pragma mark - Segue to Search VC (Search icon pressed)
- (void)segueToSearchVC{
    
}

#pragma mark - CollectionViewDataSource
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}


@end
