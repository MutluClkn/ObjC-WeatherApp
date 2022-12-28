//
//  ViewController.m
//  WeatherApp
//
//  Created by Mutlu Çalkan on 27.12.2022.
//

#pragma mark - Frameworks
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "CollectionViewCell.h"
#import "QDCoordinateData.h"
#import "QTWeatherData.h"
#import "CoordinateModel.h"

#pragma mark - Interface
@interface ViewController () <UICollectionViewDataSource>

@property (strong, nonatomic) NSString *searchText;
@property (strong, nonatomic) NSDictionary *coord;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSMutableString *lonStr;
@property (strong, nonatomic) NSMutableString *latStr;
//@property (strong, nonatomic) NSMutableString *completeCoordinate;

@end

#pragma mark - Implementation
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.dataSource = self;
    
    self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    
    [self mapConfiguration];
    [self fetchWeather];
    
    //self.latStr = @"lat=";
    //self.lonStr = @"&lon=";

}

#pragma mark - Map Configuration
- (void)mapConfiguration{
    
    [_mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(48.8566, 2.3522), MKCoordinateSpanMake(0.5, 0.5)) animated:true];

}

#pragma mark - Fetch Coordinates
-(void)fetchCoordinates{
   // self.latStr = @"lat=";
    //self.lonStr = @"&lon=";
    self.searchText = [self.searchTextField text];
    NSMutableString *urlString = [NSMutableString stringWithString: @"https://api.openweathermap.org/data/2.5/weather?q=&appid=987329bc91f6216677fbf31bf4b51a8b&units=metric"];
    [urlString insertString:self.searchText atIndex:50];
    NSURL *url = [NSURL URLWithString:urlString];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *coordinatesJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        NSLog(@"Response data: %@", coordinatesJSON);
        if(err){
            NSLog(@"%@", err);
            return;
        }
        
        self.coord = [coordinatesJSON objectForKey:@"coord"];
        NSNumber *longitude = [self.coord objectForKey:@"lon"];
        NSNumber *latitude = [self.coord objectForKey:@"lat"];
        NSLog(@"%@ and %@", longitude, latitude);
        
        CoordinateModel *coord = [[CoordinateModel alloc] initWithLongitude:longitude andLatitude:latitude];
        
        [self.lonStr appendString:[coord.longitude stringValue]];
        [self.latStr appendString:[coord.latitude stringValue]];

        [self fetchWeather];
    }] resume];
}

#pragma mark - Fetch Weather
- (void)fetchWeather{

    NSLog(@"HERE BABY: %@",self.lonStr);
    /*
    NSMutableString *completeCoordinate = [NSMutableString stringWithString:@""];
    [completeCoordinate appendString:self.latStr];
    [completeCoordinate appendString:self.lonStr];
    NSMutableString *urlStr = [NSMutableString stringWithString: @"https://api.openweathermap.org/data/2.5/forecast?&appid=987329bc91f6216677fbf31bf4b51a8b&units=metric"];
    [urlStr insertString:completeCoordinate atIndex:49];
    //NSMutableString *urlString = [NSMutableString stringWithString:urlStr];
    //[urlStr insertString:self.lonStr atIndex:58];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSLog(@"%@", urlStr);
    /*
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *weatherData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        NSLog(@"Response data: %@", weatherData);
        if(err){
            NSLog(@"%@", err);
            return;
        }
        /*
        self.coord = [coordinatesJSON objectForKey:@"coord"];
        self.longitude = [self.coord objectForKey:@"lon"];
        self.latitude = [self.coord objectForKey:@"lat"];
*/
        
        /*
        NSMutableArray<List *> *courses = NSMutableArray.new;
        for (NSDictionary *courseDict in courseJSON){
            NSString *name =  courseDict[@"name"];
            List *list = List.new;
            list.name = name;
            [courses addObject:list];
            
            self.courses = courses;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myTableView reloadData];
            });
            
        }
        
    }] resume];*/
}

#pragma mark - Actions
//Search Button
- (IBAction)searchButtonDidPress:(UIButton *)sender {
    [self fetchCoordinates];
    self.searchTextField.text = @"";
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
