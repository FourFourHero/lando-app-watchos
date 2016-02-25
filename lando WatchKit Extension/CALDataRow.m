#import "CALDataRow.h"

@implementation CALDataRow

- (IBAction)leftButtonTapped:(id)sender
{
    if (self.buttonBlock)
    {
        void (^block)(NSString*) = self.buttonBlock;
        block(self.leftDataId);
    }
}

- (IBAction)rightButtonTapped:(id)sender
{
    if (self.buttonBlock)
    {
        void (^block)(NSString*) = self.buttonBlock;
        block(self.rightDataId);
    }
}

- (void)setLeftContent:(NSDictionary*)leftContent
{
    if (leftContent[@"image"])
    {
        if (leftContent[@"text"])
        {
            [self.leftButton setTitle:leftContent[@"text"]];
            [self.leftButton setBackgroundColor:[UIColor greenColor]];
        } else {
            [self.leftButton setBackgroundImageNamed:leftContent[@"image"]];
        }
        self.leftDataId = leftContent[@"dataId"];
        [self.rightButton setHidden:YES];
    } else {
        [self.leftButton setHidden:YES];
    }
}

- (void)setRightContent:(NSDictionary*)rightContent
{
    if (rightContent[@"image"])
    {
        if (rightContent[@"text"])
        {
            [self.rightButton setTitle:rightContent[@"text"]];
            [self.rightButton setBackgroundColor:[UIColor greenColor]];
        } else {
            [self.rightButton setBackgroundImageNamed:rightContent[@"image"]];
        }
        self.rightDataId = rightContent[@"dataId"];

        [self.rightButton setHidden:NO];
    } else {
        [self.rightButton setHidden:YES];
    }
}

@end
