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

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

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
    self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    [self mapConfiguration];
}

#pragma mark - Methods
- (void)mapConfiguration{
    
    [_mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(48.8566, 2.3522), MKCoordinateSpanMake(0.5, 0.5)) animated:true];
    
}


#pragma mark - Actions
//Search Button
- (IBAction)searchButtonDidPress:(UIButton *)sender {
}
//Current Location of User
- (IBAction)currentLocationButtonDidPress:(UIButton *)sender {
}

#pragma mark - CollectionViewDataSource
//Cell For Item at IndexPath
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.myView.layer.cornerRadius = cell.myView.frame.size.height * 0.1;
    return cell;
}
//Number of Items in Section
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

@end
