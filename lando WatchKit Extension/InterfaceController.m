#import "InterfaceController.h"
#import "CALDataRow.h"


@interface InterfaceController()

@property (nonatomic, weak) IBOutlet WKInterfaceTable *managers;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    __block CALDataRow *row;
    NSArray *managers = @[
                          @{@"image": @"cmiller", @"dataId": @"cmiller"},
                          @{@"image": @"jcousins", @"dataId": @"jcousins"},
                          @{@"image": @"mprugh", @"dataId": @"mprugh"},
                          @{@"image": @"sweintraub", @"dataId": @"sweintraub"},
                          @{@"image": @"pperon", @"dataId": @"pperon"},
                          @{@"image": @"dbialek", @"dataId": @"dbialek"},
                          @{@"image": @"ltrempe", @"dataId": @"ltrempe"},
                          ];

    [managers enumerateObjectsUsingBlock:^(NSDictionary *item, NSUInteger idx, BOOL *stop) {
        if (idx % 2 == 0)
        {
            [self.managers insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:idx/2] withRowType:@"CALDataRow"];
            row = (CALDataRow*)[self.managers rowControllerAtIndex:idx/2];
            row.buttonBlock = ^(NSString *dataId){
                [self pushControllerWithName:@"MessageInterfaceController"
                                     context:@{@"dataId": dataId}];
            };
            [row setLeftContent:item];
        } else {
            [row setRightContent:item];
        }
    }];

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self.managers scrollToRowAtIndex:0];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)selectPerson:(id)sender
{

}

@end



