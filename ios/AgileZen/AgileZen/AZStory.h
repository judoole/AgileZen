#import <Foundation/Foundation.h>


@interface AZStory : NSObject
@property(nonatomic) NSInteger id;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, copy) NSString *size;
@property(nonatomic, copy) NSString *color;
@property(nonatomic, copy) NSString *priority;
@property (nonatomic,copy) NSString *deadline;
@property (nonatomic,copy) NSString *status;
@end