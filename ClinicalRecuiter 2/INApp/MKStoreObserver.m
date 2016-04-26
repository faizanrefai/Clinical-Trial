//
//  MKStoreObserver.m
//
//  Created by Mugunth Kumar on 17-Oct-09.
//  Copyright 2009 Mugunth Kumar. All rights reserved.
//

#import "MKStoreObserver.h"
#import "MKStoreManager.h"

@implementation MKStoreObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
	for (SKPaymentTransaction *transaction in transactions)
	{
		switch (transaction.transactionState)
		{
			case SKPaymentTransactionStatePurchased:
				
                [self completeTransaction:transaction];
				
                break;
				
            case SKPaymentTransactionStateFailed:
				
                [self failedTransaction:transaction];
				
                break;
				
            case SKPaymentTransactionStateRestored:
				
                [self restoreTransaction:transaction];
				
            default:
				
                break;
		}			
	}
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{	
    if (transaction.error.code != SKErrorPaymentCancelled)		
    {		
		NSLog(@"failllll");
		NSLog(@"%@",[transaction.error description]);

    }	
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];	
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{	
	NSLog(@"complete");
	//[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
	[[MKStoreManager sharedManager] CompletTranscation:transaction.originalTransaction.payment.productIdentifier];
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{	
	NSLog(@"purchaseeeeeee");
    [[MKStoreManager sharedManager] provideContent: transaction.originalTransaction.payment.productIdentifier shouldSerialize:YES];	
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];	
}

@end
