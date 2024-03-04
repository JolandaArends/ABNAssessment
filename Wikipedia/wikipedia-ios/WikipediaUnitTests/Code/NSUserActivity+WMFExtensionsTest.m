#import <XCTest/XCTest.h>
#import "NSUserActivity+WMFExtensions.h"


@interface NSUserActivity_WMFExtensions_wmf_activityForWikipediaScheme_Test : XCTestCase
@end

@implementation NSUserActivity_WMFExtensions_wmf_activityForWikipediaScheme_Test

- (void)testURLWithoutWikipediaSchemeReturnsNil {
    NSURL *url = [NSURL URLWithString:@"http://www.foo.com"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertNil(activity);
}

- (void)testInvalidArticleURLReturnsNil {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/Foo"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertNil(activity);
}

- (void)testArticleURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/wiki/Foo"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeLink);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString, @"https://en.wikipedia.org/wiki/Foo");
}

- (void)testExploreURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://explore"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeExplore);
}

- (void)testHistoryURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://history"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeHistory);
}

- (void)testSavedURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://saved"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeSavedPages);
}

- (void)testSearchURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/w/index.php?search=dog"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeLink);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString,
                          @"https://en.wikipedia.org/w/index.php?search=dog&title=Special:Search&fulltext=1");
}

// MARK: wmf_placesActivityWithURL
- (void)testActivityTypePlacesWithArticleURL {
    // Arrange
    NSString *baseURLString = @"wikipedia://places";
    NSString *articleQueryParameter = @"?WMFArticleURL=";
    NSString *articleQueryValue = @"https://en.wikipedia.org/wiki/Amsterdam";
    
    // Act
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@", baseURLString, articleQueryParameter, articleQueryValue]];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    
    // Assert
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString, articleQueryValue);
}

- (void)testActivityTypePlacesWithCoordinates {
    // Arrange
    NSString *baseURLString = @"wikipedia://places";
    NSString *locationQuery = @"?WMFCoordinates=52.366667,4.9";
    CLLocation *location = [[CLLocation alloc] initWithLatitude:52.366667
                                                      longitude:4.9];

    // Act
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@", baseURLString, locationQuery]];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    
    // Assert
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertEqual(activity.wmf_location.coordinate.latitude, location.coordinate.latitude);
    XCTAssertEqual(activity.wmf_location.coordinate.longitude, location.coordinate.longitude);
}

- (void)testActivityTypePlacesWithArticleURLFirstAndCoordinatesLast {
    // Arrange
    NSString *baseURLString = @"wikipedia://places";
    NSString *articleQueryParameter = @"WMFArticleURL=";
    NSString *articleQueryValue = @"https://en.wikipedia.org/wiki/Amsterdam";
    NSString *locationQuery = @"WMFCoordinates=52.366667,4.9";

    // Act
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@%@%@", baseURLString, @"?", articleQueryParameter, articleQueryValue, @"&", locationQuery]];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    
    // Assert
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString, articleQueryValue);
}

- (void)testActivityTypePlacesWithCoordinatesFirstAndArticleURLLast {
    // Arrange
    NSString *baseURLString = @"wikipedia://places";
    NSString *articleQueryParameter = @"WMFArticleURL=";
    NSString *articleQueryValue = @"https://en.wikipedia.org/wiki/Amsterdam";
    NSString *locationQuery = @"WMFCoordinates=52.366667,4.9";
    
    // Act
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@%@%@", baseURLString, @"?", locationQuery, @"&", articleQueryParameter, articleQueryValue]];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    
    // Assert
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString, articleQueryValue);
}
@end

