#import <WatchKit/WatchKit.h>

@interface CALDataRow : NSObject

@property (nonatomic, weak) IBOutlet WKInterfaceButton *leftButton;
@property (nonatomic, weak) IBOutlet WKInterfaceButton *rightButton;

@property (nonatomic, copy) NSString *leftDataId;
@property (nonatomic, copy) NSString *rightDataId;

@property (nonatomic, strong) id buttonBlock;

- (void)setLeftContent:(NSDictionary*)leftContent;
- (void)setRightContent:(NSDictionary*)leftContent;

@end
