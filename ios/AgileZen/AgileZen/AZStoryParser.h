#import <Foundation/Foundation.h>


@interface AZStoryParser : NSObject{

}
- (NSArray *)storiesFromJSON:(NSString *)json error:(NSError **)error;
@end

extern NSString *AZStoryParserErrorDomain;

enum {
    AZStoryParserInvalidJSONError,
    AZStoryParserMissingDataError,
};