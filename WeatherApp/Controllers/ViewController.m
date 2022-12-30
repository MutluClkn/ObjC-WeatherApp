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
@import CoreLocation;

#pragma mark - Interface
@interface ViewController () <UICollectionViewDataSource, CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager *myLocationManger;
@property (nonatomic,strong)CLLocation *myLocation;

@property (strong, nonatomic) NSString *searchText;
@property (strong, nonatomic) NSMutableString *lonStr;
@property (strong, nonatomic) NSMutableString *latStr;
@property (strong, nonatomic) NSMutableString *completeCoordinate;
@property (strong, nonatomic) NSMutableArray *lonArrayStr;
@property (strong, nonatomic) NSMutableArray *latArrayStr;

@property (strong, nonatomic) NSMutableDictionary *coord;
@property (strong, nonatomic) NSMutableDictionary *list;
@property (strong ,nonatomic) NSMutableDictionary *secondList;
@property (strong, nonatomic) NSMutableArray *time;
@property (strong, nonatomic) NSMutableArray *cityName;
@property (strong, nonatomic) NSMutableArray *cityTemp;
@property (strong, nonatomic) NSMutableArray *condition;
@property (strong, nonatomic) NSMutableArray *weatherID;
@property (strong, nonatomic) NSMutableArray *wind;
@property (strong, nonatomic) NSMutableArray *humidity;
@property (strong, nonatomic) NSMutableArray *clouds;
@property (strong, nonatomic) NSMutableArray *headerDate;

@end

#pragma mark - Implementation
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.dataSource = self;
    
    self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    
    self.lonArrayStr = [[NSMutableArray alloc] init];
    self.latArrayStr = [[NSMutableArray alloc] init];
    self.list = [[NSMutableDictionary alloc] init];
    self.secondList = [[NSMutableDictionary alloc] init];
    self.time = [[NSMutableArray alloc] init];
    self.cityName = [[NSMutableArray alloc] init];
    self.cityTemp = [[NSMutableArray alloc] init];
    self.condition = [[NSMutableArray alloc] init];
    self.weatherID = [[NSMutableArray alloc] init];
    self.wind = [[NSMutableArray alloc] init];
    self.humidity = [[NSMutableArray alloc] init];
    self.clouds = [[NSMutableArray alloc] init];
    self.headerDate = [[NSMutableArray alloc] init];
    
    [self.myLocationManger requestAlwaysAuthorization];
    [self.myLocationManger requestWhenInUseAuthorization];
    
    self.myLocationManger = [[CLLocationManager alloc] init];
    self.myLocationManger.delegate = self;
    if ([self.myLocationManger respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.myLocationManger requestWhenInUseAuthorization];
        }
    [self.myLocationManger startUpdatingLocation];
}

#pragma mark - CoreLocation
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //This method will show us that we recieved the new location

    CLLocation *newLocation = [locations lastObject];
    NSLog(@"didUpdateLocations %@", newLocation);
    
    self.myLocation = newLocation;
    [self updateUserLocation];
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//Failed to recieve user's location
NSLog(@"failed to recived user's locatio");
}

#pragma mark - Update Location via CoreLocation
- (void)updateUserLocation{
    if (self.myLocation != nil) {
        [self.lonArrayStr removeAllObjects];
        [self.latArrayStr removeAllObjects];
        
        NSString *lat = [NSString stringWithFormat:@"%.8f", self.myLocation.coordinate.latitude];
        NSString *lon = [NSString stringWithFormat:@"%.8f", self.myLocation.coordinate.longitude];
        NSLog(@"%@ and %@",lat,lon);
        [self.lonArrayStr addObject:lon];
        [self.latArrayStr addObject:lat];
        [self mapConfiguration];
        [self fetchWeather];
    } else {
        
        [self.lonArrayStr addObject:@"-2.15"];
        [self.latArrayStr addObject:@"57"];
        [self mapConfiguration];
    }
}

#pragma mark - Map Configuration
- (void)mapConfiguration{
    
    CLLocationDegrees lat = [self.latArrayStr[0] doubleValue];
    CLLocationDegrees lon = [self.lonArrayStr[0] doubleValue];
    
    [_mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(lat, lon), MKCoordinateSpanMake(1.5, 1.5)) animated:true];
    
}

#pragma mark - Fetch Coordinates
-(void)fetchCoordinates{
    [self.myLocationManger stopUpdatingLocation];
    [self.coord removeAllObjects];
    [self.lonArrayStr removeAllObjects];
    [self.latArrayStr removeAllObjects];
    
    self.searchText = [self.searchTextField text];
    NSMutableString *urlString = [NSMutableString stringWithString: @"https://api.openweathermap.org/data/2.5/weather?q=&appid=987329bc91f6216677fbf31bf4b51a8b&units=metric"];
    [urlString insertString:self.searchText atIndex:50];
    NSURL *url = [NSURL URLWithString:urlString];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *coordinatesJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        //NSLog(@"Response data: %@", coordinatesJSON);
        if(err){
            NSLog(@"%@", err);
            return;
        }
        
        self.coord = [coordinatesJSON objectForKey:@"coord"];
        NSNumber *longitude = [self.coord objectForKey:@"lon"];
        NSNumber *latitude = [self.coord objectForKey:@"lat"];
        //NSLog(@"%@ and %@", longitude, latitude);
        
        NSString *longString = [longitude stringValue];
        NSString *latString = [latitude stringValue];
        
        [self.lonStr appendString:[longitude stringValue]];
        [self.latStr appendString:[latitude stringValue]];
        
        
        //NSLog(@"COORDINATES: %@ and %@", longString, latString);
        
        [self.lonArrayStr addObject:longString];
        [self.latArrayStr addObject:latString];
        [self.list removeAllObjects];
        [self mapConfiguration];
        [self fetchWeather];

        
    }] resume];
}

#pragma mark - Fetch Weather
- (void)fetchWeather{
    
    NSMutableString *latitude = [NSMutableString stringWithString:@"lat="];
    NSMutableString *longitude = [NSMutableString stringWithString:@"&lon="];
    
    [latitude appendString:self.latArrayStr[0]];
    [longitude appendString:self.lonArrayStr[0]];
    
    //NSLog(@"NEW COORDINATES: %@ and %@",latitude, longitude);
    
    NSMutableString *completeCoordinate = [NSMutableString stringWithString:@""];
    [completeCoordinate appendString:latitude];
    [completeCoordinate appendString:longitude];
    
    NSMutableString *urlStr = [NSMutableString stringWithString: @"https://api.openweathermap.org/data/2.5/forecast?&cnt=9&appid=987329bc91f6216677fbf31bf4b51a8b&units=metric"];
    [urlStr insertString:completeCoordinate atIndex:49];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //NSLog(@"%@", urlStr);
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *weatherData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        //NSLog(@"Response data: %@", weatherData);
        if(err){
            NSLog(@"%@", err);
            return;
        }
        
        NSDictionary *city = [weatherData objectForKey:@"city"];
        
        self.list = [weatherData objectForKey:@"list"];

        for (NSDictionary *listIndex in self.list){
            
            NSString *time = [listIndex objectForKey:@"dt_txt"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *date = [dateFormatter dateFromString:time];
            
            [dateFormatter setDateFormat:@"MMM d, h:mm a"];
            NSString *headerDate = [dateFormatter stringFromDate:date];
            [self.headerDate addObject:headerDate];
            
            [dateFormatter setDateFormat:@"h a"];
            NSString *newDate = [dateFormatter stringFromDate:date];
            [self.time addObject:newDate];
            // NSLog(@"Time: %@", newDate);
            // NSLog(@"Time: %@", headerDate);
            
            NSDictionary *main = [listIndex objectForKey:@"main"];
            NSNumber *temp = [main objectForKey:@"temp"];
            NSNumber *humidity = [main objectForKey:@"humidity"];
            [self.cityTemp addObject:temp];
            //NSLog(@"Temp: %@", temp);
            [self.humidity addObject:humidity];
            //NSLog(@"Humidity: %@", humidity);
            
            NSArray *weather = [listIndex objectForKey:@"weather"];
            NSNumber *weatherID = [weather[0] objectForKey:@"id"];
            
            if ([weatherID intValue] >= 200 && [weatherID intValue] <= 232){
                [self.weatherID addObject:@"Thunderstorm"];
            }
            else if ([weatherID intValue] >= 300 && [weatherID intValue] <= 321){
                [self.weatherID addObject:@"Rain"];
            }
            else if ([weatherID intValue] >= 500 && [weatherID intValue] <= 531){
                [self.weatherID addObject:@"Shower-Rain"];
            }
            else if ([weatherID intValue] >= 600 && [weatherID intValue] <= 622){
                [self.weatherID addObject:@"Shower-Rain"];
            }
            else if ([weatherID intValue] >= 701 && [weatherID intValue] <= 781){
                [self.weatherID addObject:@"Snow"];
            }
            else if ([weatherID intValue] == 800){
                [self.weatherID addObject:@"Clear-Sky"];
            }
            else if ([weatherID intValue] >= 801 && [weatherID intValue] <= 804){
                [self.weatherID addObject:@"Few-Clouds"];
            }

            //NSLog(@"WeatherID: %@", self.weatherID);
            NSString *description = [weather[0] objectForKey:@"description"];
            [self.condition addObject:description];
            //NSLog(@"Description: %@", description);
            
            
            NSDictionary *clouds = [listIndex objectForKey:@"clouds"];
            NSNumber *value = [clouds objectForKey:@"all"];
            [self.clouds addObject:value];
            //NSLog(@"Clouds: %@", value);
            
            
            NSDictionary *wind = [listIndex objectForKey:@"wind"];
            NSNumber *speed = [wind objectForKey:@"speed"];
            [self.wind addObject:speed];
            //NSLog(@"Wind: %@", speed);
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cityLabel.text = [city objectForKey:@"name"];
            
            self.dateLabel.text = self.headerDate[0];
            
            NSString *temp = [self.cityTemp[0] stringValue];
            NSString *newTemp = [NSString stringWithFormat:@"%@°",temp];
            self.tempLabel.text = newTemp;
            
            self.weatherImageView.image = [UIImage imageNamed:self.weatherID[0]];
            
            self.weatherConditionLabel.text = [self.condition[0] uppercaseString];
            
            self.windLabel.text = [self.wind[0] stringValue];
            self.humidityLabel.text = [self.humidity[0] stringValue];
            NSString *cloud = [self.clouds[0] stringValue];
            NSString *newCloud = [NSString stringWithFormat:@"%%%@",cloud];
            self.cloudsLabel.text = newCloud;
            [self.collectionView reloadData];
        });
        
        
    }] resume];
}

#pragma mark - Actions
//Search Button
- (IBAction)searchButtonDidPress:(UIButton *)sender {
    if (![self.searchTextField.text  isEqual: @""]){
        [self fetchCoordinates];
        self.searchTextField.text = @"";
    }
}
//Current Location of User
- (IBAction)currentLocationButtonDidPress:(UIButton *)sender {
    [self.myLocationManger startUpdatingLocation];
}



#pragma mark - CollectionViewDataSource
//Cell For Item at IndexPath
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //View configuration
    cell.myView.layer.cornerRadius = cell.myView.frame.size.height * 0.1;
    //Temp
    NSString *temp = [self.cityTemp[indexPath.row] stringValue];
    cell.tempLabel.text = temp;
    //Time
    cell.timeLabel.text = self.time[indexPath.row];
    //Image
    cell.weatherImage.image = [UIImage imageNamed:self.weatherID[indexPath.row]];
    
    return cell;
}
//Number of Items in Section
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cityTemp.count;
}

@end
