//
//  AddressBookModel.m
//  cardloan
//
//  Created by zhuayi on 16/6/15.
//  Copyright © 2016年 renxin. All rights reserved.
//

#import "AddressBookPage.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "JSONKit.h"

@implementation AddressBookPage

/**
 *  开始上传
 */
+ (void)starUpload {
    
    // 上传通讯录
//    if ([[UserModel sharedInstance].isLogin boolValue]
//        && [[UserModel sharedInstance].isUploadAddress boolValue] == NO
//        && ![[UserModel sharedInstance].addressBookPath isBlankString]
//        && [[UserModel sharedInstance].addressBookPath isFileExist]) {
//
//        [CommonDao uploadContact:[UserModel sharedInstance].addressBookPath successBlock:^(CardLoanBaseModel *responseObject) {
//
//             NSLog(@"上传通讯录成功%@", [UserModel sharedInstance].addressBookPath);
//
//            [UserModel sharedInstance].isUploadAddress = @(YES);
//
//        } failure:^(CardLoanBaseModel *error) {
//
//            [CardLoanBaseDataAppear dataAppearUploadAddressBookFail];
//
//        }];
//    }
}

/**
 *  获取通讯录数组
 */
+ (void)getAddressBookList {
    
//    if ([UserModel sharedInstance].addressBookPath && [[UserModel sharedInstance].addressBookPath isFileExist]) {
//
//        // 如果已经有值了, 那就不获取了, 直接上传
//        if ([[UserModel sharedInstance].isUploadAddress boolValue] == NO) {
//            [AddressBookPage starUpload];
//        }
//        return;
//    }
    
    if ([kCacheAddressDataFileName isFileExist]) {
        
        //上传
        
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *dataFileArray = [NSMutableArray new];
        
        // 获取通讯录
        ABAddressBookRef addressBook = ABAddressBookCreate();
        CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
        
        NSInteger resultsCount = CFArrayGetCount(results);
        for(int i = 0; i < resultsCount; i++) {
            
            NSString *book;
            ABRecordRef person = CFArrayGetValueAtIndex(results, i);
            
            ABMutableMultiValueRef name = ABRecordCopyCompositeName(person);
            
            ABMutableMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
            NSMutableArray *phoneArray = [NSMutableArray new];
            NSInteger index = ABMultiValueGetCount(phone);
            for (int k = 0; k < index; k++) {
                CFStringRef phoneRef = ABMultiValueCopyValueAtIndex(phone, k);
                [phoneArray addObject:(__bridge NSString *)(phoneRef)];
            }
            
            book = [NSString stringWithFormat:@"%@:%@", name, [phoneArray componentsJoinedByString:@","]];
            [dataFileArray addObject:book];

        }
        CFRelease(results);
        CFRelease(addressBook);

        // 写入目录
        NSError *error;
        NSData *dataStrings = [[dataFileArray componentsJoinedByString:@"\n"] dataUsingEncoding:NSUTF8StringEncoding];
        error = nil;
        BOOL isOK = [dataStrings writeToFile:[kCacheAddressDataFileName fileNameToPath] atomically:YES];
        if (isOK == YES) {
            
            [AddressBookPage starUpload];
        } else {
            
            NSLog(@"error %@", error);
        }

    });
}

@end

