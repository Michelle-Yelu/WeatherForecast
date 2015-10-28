//
//  ViewController.m
//  WeatherForecast
//
//  Created by Ye Lu on 10/23/15.
//  Copyright (c) 2015 Raye. All rights reserved.
//

#import "ViewController.h"
#import "DataFetcher.h"


@interface ViewController () <UITextFieldDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) UILabel *labelCity2;
@property (nonatomic,strong) UILabel *labelTemp2;
@property (nonatomic,strong) UILabel *labelHumidity2;
@property (nonatomic,strong) UILabel *labelDescription2;
@property (nonatomic,strong) UITextField *cityTextField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 100, 30)];
    label1.text = @"Please enter city name:";
    [label1 sizeToFit];
    [self.view addSubview:label1];
    
    _cityTextField = [[UITextField alloc] initWithFrame:CGRectMake(label1.frame.origin.x + label1.frame.size.width + 5  , label1.frame.origin.y, self.view.bounds.size.width - label1.frame.origin.x - label1.frame.size.width - 20, label1.frame.size.height)];
    [_cityTextField setBorderStyle:UITextBorderStyleRoundedRect];
    _cityTextField.delegate = self;
    _cityTextField.returnKeyType = UIReturnKeySearch;
    //cityTextField addTarget:self action:@selector() forControlEvents:<#(UIControlEvents)#>
    [self.view addSubview:_cityTextField];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(label1.frame.origin.x, label1.frame.origin.y + label1.frame.size.height + 20, 100, 30)];
    label2.text = @"Or use  ";
    [label2 sizeToFit];
    [self.view addSubview:label2];

    UIButton *currentLocationButton = [[UIButton alloc] initWithFrame:CGRectMake(label2.frame.origin.x + label2.frame.size.width , label2.frame.origin.y, 100, label2.frame.size.height)];
    [currentLocationButton setTitle:@"Current Location" forState:UIControlStateNormal];
    [currentLocationButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [currentLocationButton sizeToFit];
    currentLocationButton.center = CGPointMake(currentLocationButton.center.x, label2.center.y);
    [currentLocationButton addTarget:self action:@selector(currentLocationClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:currentLocationButton];

    
    UILabel *labelCity1 = [[UILabel alloc] init];
    labelCity1.text = @"City:";
    [labelCity1 sizeToFit];
    labelCity1.center = CGPointMake(100, currentLocationButton.center.y + 80);
    [self.view addSubview:labelCity1];
    
    _labelCity2 = [[UILabel alloc] init];
    _labelCity2.text = @"empty";
    [_labelCity2 sizeToFit];
    _labelCity2.center = CGPointMake(labelCity1.center.x + 100, labelCity1.center.y);
    [_labelCity2 setTextColor:[UIColor darkGrayColor]];
    [self.view addSubview:_labelCity2];

    UILabel *labelTemp1 = [[UILabel alloc] init];
    labelTemp1.text = @"Tempreture:";
    [labelTemp1 sizeToFit];
    labelTemp1.center = CGPointMake(labelCity1.center.x, labelCity1.center.y + 30);
    [self.view addSubview:labelTemp1];
    
    _labelTemp2 = [[UILabel alloc] init];
    _labelTemp2.text = @"empty";
    [_labelTemp2 sizeToFit];
    [_labelTemp2 setTextColor:[UIColor darkGrayColor]];
    _labelTemp2.center = CGPointMake(_labelCity2.center.x, labelTemp1.center.y);
    [self.view addSubview:_labelTemp2];
    
    UILabel *labelHumidity1 = [[UILabel alloc] init];
    labelHumidity1.text = @"Humidity:";
    [labelHumidity1 sizeToFit];
    labelHumidity1.center = CGPointMake(labelCity1.center.x, labelTemp1.center.y + 30);
    [self.view addSubview:labelHumidity1];
    
    _labelHumidity2 = [[UILabel alloc] init];
    _labelHumidity2.text = @"empty";
    [_labelHumidity2 sizeToFit];
    [_labelHumidity2 setTextColor:[UIColor darkGrayColor]];
    _labelHumidity2.center = CGPointMake(_labelCity2.center.x, labelHumidity1.center.y);
    [self.view addSubview:_labelHumidity2];
    
    UILabel *labelDescription1 = [[UILabel alloc] init];
    labelDescription1.text = @"Description:";
    [labelDescription1 sizeToFit];
    labelDescription1.center = CGPointMake(labelCity1.center.x, labelHumidity1.center.y + 30);
    [self.view addSubview:labelDescription1];
    
    _labelDescription2 = [[UILabel alloc] init];
    _labelDescription2.text = @"empty";
    [_labelDescription2 sizeToFit];
    [_labelDescription2 setTextColor:[UIColor darkGrayColor]];
    _labelDescription2.center = CGPointMake(_labelCity2.center.x, labelDescription1.center.y);
    [self.view addSubview:_labelDescription2];

    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.cityTextField) {
        [textField resignFirstResponder];
        [DataFetcher fetchDataWithCityName:textField.text completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            [self fetchLocationComplete:data withResponse:response withError:error];
        }];
        return NO;
    }
    return YES;
}


-(void)currentLocationClicked:(id)sender {
    [self.locationManager startUpdatingLocation];
    
}

-(CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
            NSUInteger code = [CLLocationManager authorizationStatus];
            if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
                // choose one request according to your business.
                if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                    [self.locationManager requestAlwaysAuthorization];
                } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                    [self.locationManager  requestWhenInUseAuthorization];
                } else {
                    NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
                }
            }
        }
    }
    
    return _locationManager;
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [_locationManager stopUpdatingLocation];
    CLLocation *location = [_locationManager location];
    [DataFetcher fetchDataWithLocationLatitude:location.coordinate.latitude longitude:location.coordinate.longitude completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self fetchLocationComplete:data withResponse:response withError:error];
    }];
    
}

-(void)fetchLocationComplete:(NSData*)data withResponse:(NSURLResponse*)response withError:(NSError*)error  {
    if (error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showErrorAlert:error];
        });
        return;
    }
    
    NSError *parsingError = nil;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parsingError];
    
    if (parsingError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showErrorAlert:parsingError];
        });
        return;
    }
    
    WeatherData *weatherData = [WeatherData parseData:jsonData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateViewWithWeatherData:weatherData];
    });
}

-(void)updateViewWithWeatherData:(WeatherData*)data {
    self.labelCity2.text = [NSString stringWithFormat:@"%@, %@", data.cityName, data.countryCode];
    [self.labelCity2 sizeToFit];
    self.labelTemp2.text = data.tempreture;
    [self.labelTemp2 sizeToFit];
    self.labelHumidity2.text = data.humidity;
    [self.labelHumidity2 sizeToFit];
    self.labelDescription2.text = data.weatherDesciption;
    [self.labelDescription2 sizeToFit];
    //[self.labelCity2 setNeedsDisplay];
    //[self.labelTemp2 setNeedsDisplay];
    //[self.labelHumidity2 setNeedsDisplay];
    
}

-(void)showErrorAlert:(NSError*)error {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error loading data" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertView show];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
