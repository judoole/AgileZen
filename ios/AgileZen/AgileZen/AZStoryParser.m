#import "AZStoryParser.h"
#import "AZStory.h"


@implementation AZStoryParser {

}
- (NSArray *)storiesFromJSON:(NSString *)json error:(NSError **)error {
    NSParameterAssert(json != nil);
    NSData *unicodeNotation = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];
    NSDictionary *parsedObject = (id) jsonObject;
    if (parsedObject == nil) {
        if (error != NULL) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
            if (localError != nil) {
                [userInfo setObject:localError forKey:NSUnderlyingErrorKey];
            }
            *error = [NSError errorWithDomain:AZStoryParserErrorDomain code:AZStoryParserInvalidJSONError userInfo:userInfo];
        }
        return nil;
    }
    NSArray *stories = [parsedObject objectForKey:@"items"];
    if (stories == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:AZStoryParserErrorDomain code:AZStoryParserMissingDataError userInfo:nil];
        }
        return nil;
    }
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:[stories count]];
    for (NSDictionary *parsedStory in stories) {
        AZStory *thisStory = [[AZStory alloc] init];
        thisStory.id = [[parsedStory objectForKey:@"id"] integerValue];
        thisStory.text = [parsedStory objectForKey:@"text"];
        [results addObject:thisStory];
    }
    return [results copy];

}
@end

NSString *AZStoryParserErrorDomain = @"AZStoryParserErrorDomain";