//
//  ABAlphabetSpec.m
//  IDAPCourse
//
//  Created by Andrew Boychuk on 5/24/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

#import "Kiwi.h"

#import "ABAlphabet.h"
#import "ABClasterAlphabet.h"
#import "ABRangeAlphabet.h"
#import "ABStringsAlphabet.h"

SPEC_BEGIN(ABAlphabetSpec)

describe(@"ABAlphabet", ^{
    __block ABAlphabet *alphabet = nil;
    
//    + (instancetype)alphabetWithRange:(NSRange)range;
//    + (instancetype)alphabetWithStrings:(NSString *)strings;
//    + (instancetype)alphabetWithAlphabets:(NSArray *)alphabets;
//    + (instancetype)alphabetWithSymbols:(NSString *)strings;
//    
//    - (instancetype)initWithAlphabets:(NSArray *)alphabets;
//    - (instancetype)initWithRange:(NSRange)range;
//    - (instancetype)initWithStrings:(NSString *)strings;
//    - (instancetype)initWithSymbols:(NSString *)strings;
//    
//    - (NSUInteger)count;
//    - (NSString *)stringAtIndex:(NSUInteger)index;
//    - (NSString *)objectAtIndexedSubscript:(NSUInteger)index;
    
    context(@"when initialized with +alphabetWithRange: with range 'A'-'B' ;", ^{
        beforeAll(^{
            alphabet = [ABAlphabet alphabetWithRange:ABAlphabetRange('A', 'B')];
        });

        it(@"should be of class ABAlphabet", ^{
            [[alphabet should] beKindOfClass:[ABAlphabet class]];
        });
        
        it(@"should be of count 2", ^{
//            [[theValue([alphabet count]) should] equal:@(2)];
            [[alphabet should] haveCountOf:2];
        });
        
        it(@"should contain @\"A\" at index = 0", ^{
            [[[alphabet stringAtIndex:0] should] equal:@"A"];
        });
        
        it(@"should contain @\"B\" at index = 1", ^{
            [[[alphabet stringAtIndex:1] should] equal:@"B"];
        });
        
        it(@"should raise, when requesting object at index 3", ^{
            [[theBlock(^{
                [alphabet stringAtIndex:3];
            }) should] raise];
            
            [[theBlock(^{
                id a = alphabet[3];
                [a description];
            }) should] raise];

        });
        
        it(@"should return @\"AB\" from -string", ^{
            [[[alphabet string] should] equal:@"AB"];
        });
    });
    
    context(@"when initialized with -initWithRange: with range 'A'-'B' ;", ^{
        beforeAll(^{
            alphabet = [[ABAlphabet alloc] initWithRange:NSMakeRange('A', 'B' - 'A')];
        });
        
        it(@"should be of class ABAlphabet", ^{
            [[alphabet should] beKindOfClass:[ABAlphabet class]];
        });
    });
    
    context(@"when initialized with +alphabetWithRange: with range 'A'-'z' when enumerated ;", ^{
        NSRange range = ABAlphabetRange('A', 'z');
        
        beforeEach(^{
            alphabet = [[ABAlphabet alloc] initWithRange:range];
        });
        
        it(@"should raise", ^{
            [[theBlock(^{
                for (id symbol in alphabet) {
                    [symbol description];
                }
            }) shouldNot] raise];
        });
        
        it(@"should return count of symbols equql to 'A'-'z' range", ^{
            NSUInteger count = 0;
            for (NSString *symbol in alphabet) {
                [symbol description];
                count++;
            }
            
            [[theValue(count) should] equal:@(range.length)];
        });
        
        it(@"should return symbols in range 'A'-'z'", ^{
            unichar character = 'A';
            for (NSString *symbol in alphabet) {
                [[symbol should] equal:[NSString stringWithFormat:@"%c", character]];
                character++;
            }
        });
    });
});

SPEC_END
