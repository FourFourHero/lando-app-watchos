//
//  MessageInterfaceController.m
//  lando
//
//  Created by CS Cory Sitko (5264) on 2/25/16.
//  Copyright © 2016 American Greetings. All rights reserved.
//

#import "MessageInterfaceController.h"
#import "CALDataRow.h"

@interface MessageInterfaceController ()
@property (nonatomic, strong) NSString *managerId;
@property (nonatomic, weak) IBOutlet WKInterfaceTable *messages;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup *spinner;
@property (nonatomic, weak) IBOutlet WKInterfaceImage *spinnerImage;

@end

@implementation MessageInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.managerId = ((NSDictionary*)context)[@"dataId"];

    __block CALDataRow *row;
    NSArray *messages = @[
                          @{@"image": @"message_1", @"dataId": @"1", @"text": @"1"},
                          @{@"image": @"message_2", @"dataId": @"2", @"text": @"2"},
                          @{@"image": @"message_3", @"dataId": @"3", @"text": @"3"},
                          @{@"image": @"message_4", @"dataId": @"4", @"text": @"4"},
                          @{@"image": @"message_5", @"dataId": @"5", @"text": @"5"},
                          ];

    [messages enumerateObjectsUsingBlock:^(NSDictionary *item, NSUInteger idx, BOOL *stop) {
        if (idx % 2 == 0)
        {
            [self.messages insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:idx/2] withRowType:@"CALDataRow"];
            row = (CALDataRow*)[self.messages rowControllerAtIndex:idx/2];
            row.buttonBlock = ^(NSString *dataId){
                [self sendMessage:dataId user:self.managerId];
            };
            [row setLeftContent:item];
        } else {
            [row setRightContent:item];
        }
    }];

    [self.spinnerImage setImageNamed:@"spinner_"];
    [self.spinnerImage startAnimatingWithImagesInRange:NSMakeRange(0, 8)
                                               duration:1.0f
                                            repeatCount:0];

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self.messages scrollToRowAtIndex:0];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)selectPerson:(id)sender
{

}

- (void)sendMessage:(NSString*)message user:(NSString*)user
{
    [self.spinner setHidden:NO];
    [self.messages setHidden:YES];
    NSString *requestURL = [NSString stringWithFormat:@"http://cloudcityadmin.io/lobot/push?namespace=lobot&username=%@&message_num=%@", user, message];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *request = [session dataTaskWithURL:[NSURL URLWithString:requestURL]
                                           completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                     {
                                         NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                         [self.spinner setHidden:YES];
                                         [self.messages setHidden:NO];

                                         if (((NSHTTPURLResponse*)response).statusCode == 200)
                                         {
                                             [[WKInterfaceDevice currentDevice]playHaptic:WKHapticTypeNotification];
                                             [self presentAlertControllerWithTitle:@"Excellent!"
                                                                           message:@"The Force is strong with this one."
                                                                    preferredStyle:WKAlertControllerStyleAlert
                                                                           actions:@[[WKAlertAction actionWithTitle:@"OK" style:WKAlertActionStyleDefault handler:^
                                                                                      {
                                                                                          [self popToRootController];
                                                                                      }]]];
                                         } else {
                                             [[WKInterfaceDevice currentDevice]playHaptic:WKHapticTypeFailure];
                                             [self presentAlertControllerWithTitle:@"NOOOOOOO!"
                                                                           message:responseDictionary[@"error_msg"]
                                                                    preferredStyle:WKAlertControllerStyleAlert
                                                                           actions:@[[WKAlertAction actionWithTitle:@"OK" style:WKAlertActionStyleDefault handler:^
                                                                                      {
                                                                                          NSLog(@"Failure OK tapped");
                                                                                      }]]];
                                         }
                                     }];
    
    [request resume];
}

@end



