//
//  InterfaceController.m
//  lando WatchKit Extension
//
//  Created by CS Cory Sitko (5264) on 2/25/16.
//  Copyright © 2016 American Greetings. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@property (nonatomic, weak) IBOutlet WKInterfaceTable *table;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)selectPerson:(id)sender
{

}

- (IBAction)sendMessage:(id)sender
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [session dataTaskWithURL:[NSURL URLWithString:@""]
           completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
               NSLog(@"response: %@", response);
    }];
}

@end



