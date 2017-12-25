//
//  ViewController.m
//  Robot
//
//  Created by macbook on 25/12/2017.
//  Copyright © 2017 bessem. All rights reserved.
//

#import "ViewController.h"
#import "Message.h"
#import "PTSMessagingCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray* conversationArray;
}

@property (weak, nonatomic) IBOutlet UITableView *messageTableView;

@property (weak, nonatomic) IBOutlet UIView *sendMessageContainer;

@property (weak, nonatomic) IBOutlet UITextView *textViewMessage;

- (IBAction)SendMessageAction:(id)sender;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
     conversationArray =[[NSMutableArray alloc] init];
    [self createConversationArray];
    
    self.messageTableView.delegate =self;
    self.messageTableView.dataSource = self;
    
    
   

    
    NSLog(@"conversationArray count %lu",(unsigned long)conversationArray.count);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) createConversationArray

{
    
    
    for (int i=0; i<10; i++) {
         Message* msg = [[Message alloc] init];
        
        if (i % 2 == 0) {
            
           
            msg.text = @"hellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohello";
            msg.date = @"12:13";
            msg.creatorType = 1;
            
        } else {
            
            msg.text = @"hihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihihi";
            msg.date = @"12:14";
            msg.creatorType = 2;
            
        }
        
        [conversationArray addObject:msg];
    }
    
}

#pragma mark - UITableViewDatasource methods
-(void)awakeFromNib {
    
    
    [super awakeFromNib];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [conversationArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*This method sets up the table-view.*/
    
    static NSString* cellIdentifier = @"messagingCell";
    PTSMessagingCell * cell = (PTSMessagingCell*) [self.messageTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[PTSMessagingCell alloc] initMessagingCellWithReuseIdentifier:cellIdentifier];
        
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods

-(void)configureCell:(id)cell atIndexPath:(NSIndexPath *)indexPath {
    PTSMessagingCell* ccell = (PTSMessagingCell*)cell;
    
    
    Message* message = [conversationArray objectAtIndex:indexPath.row];
    
    
    if (message.creatorType == 1)
    {
        ccell.sent=YES;
        
    }
    
    else {
        ccell.sent=NO;
        
    }
    ccell.messageLabel.text = message.text;
    
        ccell.timeLabel.text=message.date;
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message* message = [conversationArray objectAtIndex:indexPath.row];
    CGSize messageSize = [PTSMessagingCell messageSize:message.text];
    if (indexPath.row==conversationArray.count-1) {
        return messageSize.height + 2*[PTSMessagingCell textMarginVertical]+100 ;
    }
    else {
        int height = messageSize.height + 2*[PTSMessagingCell textMarginVertical]+40 ;
        return height;
    }
    
}


-(void) messageGnerator:(NSString*) text
{
        Message* msg =[[Message alloc] init];
    msg.text = text;
    msg.creatorType =1;
    msg.date = @"00:01";
    [conversationArray addObject:msg];
    
    Message* msgg =[[Message alloc] init];
    msgg.text = @":P :) ;)";
    msgg.creatorType =2;
    msgg.date = @"00:02";
    
    [conversationArray addObject:msgg];
    
    
}


- (IBAction)SendMessageAction:(id)sender {
    
    [self messageGnerator:self.textViewMessage.text];
    
    [self.messageTableView reloadData];
    
    [self scrollToBottomAnimated:YES];
}


- (void)scrollToBottomAnimated:(BOOL)animated
{
    NSInteger bottomRow = [conversationArray count] - 1;
    if (bottomRow >= 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:bottomRow inSection:0];
        [self.messageTableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}
@end
