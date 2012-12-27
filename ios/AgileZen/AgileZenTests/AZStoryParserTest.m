#import <SenTestingKit/SenTestingKit.h>
#import "AZStoryParserTest.h"
#import "AZStoryParser.h"
#import "AZStory.h"

static NSString *oneStoryJSON = @"{\n"
        "    \"page\": 1,\n"
        "    \"pageSize\": 100,\n"
        "    \"totalPages\": 1,\n"
        "    \"totalItems\": 1,\n"
        "    \"items\": [\n"
        "        {\n"
        "            \"id\": 1,\n"
        "            \"text\": \"List all stories of phase\",\n"
        "            \"size\": \"M\",\n"
        "            \"color\": \"blue\",\n"
        "            \"priority\": \"\",\n"
        "            \"status\": \"started\",\n"
        "            \"project\": {\n"
        "                \"id\": 49864,\n"
        "                \"name\": \"Personal Kanban\"\n"
        "            },\n"
        "            \"phase\": {\n"
        "                \"id\": 290187,\n"
        "                \"name\": \"Ready\"\n"
        "            },\n"
        "            \"creator\": {\n"
        "                \"id\": 7788,\n"
        "                \"name\": \"Ole Christian Langfjæran\",\n"
        "                \"userName\": \"judoole\",\n"
        "                \"email\": \"judoole@gmail.com\"\n"
        "            },\n"
        "            \"owner\": {\n"
        "                \"id\": 7788,\n"
        "                \"name\": \"Ole Christian Langfjæran\",\n"
        "                \"userName\": \"judoole\",\n"
        "                \"email\": \"judoole@gmail.com\"\n"
        "            }\n"
        "        }\n"
        "    ]\n"
        "}";

static NSString *stringIsNotJSON = @"Not JSON";
static NSString *emptyPhasesArray = @"{\n"
        "    \"page\": 1,\n"
        "    \"pageSize\": 100,\n"
        "    \"totalPages\": 0,\n"
        "    \"totalItems\": 0,\n"
        "    \"items\": []\n"
        "}";

@implementation AZStoryParserTest

- (void)setUp {
    storyParser = [[AZStoryParser alloc] init];
}

- (void)tearDown {
    storyParser = nil;
}

- (void)test_nil_is_not_accepted {
    STAssertThrows([storyParser storiesFromJSON:nil error:NULL], @"Lack of data should have been handled elsewhere");
}

- (void)test_nil_returned_when_not_json {
    STAssertNil([storyParser storiesFromJSON:stringIsNotJSON error:NULL], @"This parameter should not be parsable");
}

- (void)test_passing_Null_Error_does_not_cause_crash{
    STAssertNoThrow([storyParser storiesFromJSON:stringIsNotJSON error: NULL], @"Using a NULL error parameter should not be a problem");
}

- (void)test_should_set_error_when_string_is_not_JSONtestErrorSetWhenStringIsNotJSON {
    NSError *error = nil;
    [storyParser storiesFromJSON:stringIsNotJSON error:&error];
    STAssertNotNil(error, @"An error occurred, we should be told");
}

- (void)test_json_with_one_story_returns_array_of_same_size {
    NSError *error = nil;
    NSArray *stories = [storyParser storiesFromJSON:oneStoryJSON error:&error];
    STAssertEquals([stories count], (NSUInteger) 1, @"The builder should have created one story");
}

- (void)test_properties_are_equal_to_json{
    AZStory *story = [[storyParser storiesFromJSON:oneStoryJSON error:NULL] objectAtIndex: 0];
    STAssertEquals(story.id, 1, @"The story ID should match the data we sent");
    STAssertEqualObjects(story.text, @"List all stories of phase", @"Text is not equal");
}

- (void)test_empty_items{
    NSString *emptyItems = @"{ \"items\": [ {} ] }";
    NSArray *questions = [storyParser storiesFromJSON:emptyItems error:NULL];
    STAssertEquals([questions count], (NSUInteger)1, @"Must handle empty items");
}

@end