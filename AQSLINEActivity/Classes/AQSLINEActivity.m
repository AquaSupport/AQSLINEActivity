//
//  AQSLINEActivity.m
//  AQSLINEActivity
//
//  Created by kaiinui on 2014/11/08.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import "AQSLINEActivity.h"

NSString *const kAQSLINEURLScheme = @"line://";

@interface AQSLINEActivity ()

@property (nonatomic, strong) NSArray *activityItems;

@end

@implementation AQSLINEActivity

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    [super prepareWithActivityItems:activityItems];
    
    self.activityItems = activityItems;
}

+ (UIActivityCategory)activityCategory {
    return UIActivityCategoryShare;
}

- (NSString *)activityType {
    return @"org.openaquamarine.line";
}

- (NSString *)activityTitle {
    return @"LINE";
}

- (UIImage *)activityImage {
    if ([[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue] >= 8) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"color_%@", NSStringFromClass([self class])]];
    } else {
        return [UIImage imageNamed:NSStringFromClass([self class])];
    }
}

/**
 *  To perform share, activityItems should contain `NSString` or `NSURL`, `UIImage`.
 */
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    if ([self isLINEInstalled] == NO) { return NO; }
    
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[NSString class]] || [activityItem isKindOfClass:[NSURL class]] || [activityItem isKindOfClass:[UIImage class]]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)performActivity {
    // Because LINE does not provide any callbacks.
    [self activityDidFinish:YES];
    
    [[UIApplication sharedApplication] openURL:[self lineShareURLWithActivityItems:_activityItems]];
}

# pragma mark - Helpers (LINE)

- (NSURL *)lineShareURLWithActivityItems:(NSArray *)activityItems {
    NSString *nilOrString = [self nilOrFirstStringFromArray:activityItems];
    NSURL *nilOrURL = [self nilOrFirstURLFromArray:activityItems];
    UIImage *nilOrImage = [self nilOrFirstImageFromArray:activityItems];
    
    if (!!nilOrImage) {
        return [self lineShareURLWithImage:nilOrImage];
    } else if (!!nilOrString && !!nilOrURL) {
        return [self lineShareURLWithText:[NSString stringWithFormat:@"%@ %@", nilOrString, nilOrURL]];
    } else if (!!nilOrString) {
        return [self lineShareURLWithText:nilOrString];
    } else if (!!nilOrURL) {
        return [self lineShareURLWithText:nilOrURL.absoluteString];
    }
    return nil;
}

/**
 *  @return An URL that should be opened for sharing the image.
 */
- (NSURL *)lineShareURLWithImage:(UIImage *)image {
    UIPasteboard *pasteboard;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        pasteboard = [UIPasteboard generalPasteboard];
    } else {
        pasteboard = [UIPasteboard pasteboardWithUniqueName];
    }
    [pasteboard setData:UIImagePNGRepresentation(image) forPasteboardType:@"public.png"];
    return [NSURL URLWithString:[NSString stringWithFormat:@"line://msg/image/%@", pasteboard.name]];
}

/**
 *  @return An URL that should be opened for sharing the text.
 */
- (NSURL *)lineShareURLWithText:(NSString *)text {
    NSString *urlEncodeString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( NULL, (CFStringRef)text, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 ));
    return [NSURL URLWithString:[NSString stringWithFormat:@"line://msg/text/%@", urlEncodeString]];
}

- (BOOL)isLINEInstalled {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kAQSLINEURLScheme]];
}

# pragma mark - Helpers (Activity Items)

- (UIImage *)nilOrFirstImageFromArray:(NSArray *)array {
    for (id item in array) {
        if ([item isKindOfClass:[UIImage class]]) {
            return item;
        }
    }
    return nil;
}

- (NSString *)nilOrFirstStringFromArray:(NSArray *)array {
    for (id item in array) {
        if ([item isKindOfClass:[NSString class]]) {
            return item;
        }
    }
    return nil;
}

- (NSURL *)nilOrFirstURLFromArray:(NSArray *)array {
    for (id item in array) {
        if ([item isKindOfClass:[NSURL class]]) {
            return item;
        }
    }
    return nil;
}

@end
