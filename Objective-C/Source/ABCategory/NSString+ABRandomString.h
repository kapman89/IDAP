//
//  NSString+ABRandomString.h
//  IDAPCourse
//
//  Created by Andrew Boychuk on 5/2/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ABRandomString)

+ (id)numericAlphabet;
+ (id)alphanumericAlphabet;
+ (id)lowercaseLetterAlphabet;
+ (id)uppercaseLetterAlphabet;
+ (id)letterAlphabet;
+ (id)alphabetWithUnicodeRange:(NSRange)range;
+ (id)randomString;
+ (id)randomStringWithLength:(NSUInteger)length;
+ (id)randomStringWithLength:(NSUInteger)length alphabet:(NSString *)alphabet;

@end
