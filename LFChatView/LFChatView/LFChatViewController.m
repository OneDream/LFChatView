//
//  LFChatViewController.m
//  LFChatView
//
//  Created by linxiaobin on 15/6/6.
//  Copyright (c) 2015年 linxiaobin. All rights reserved.
//

#import "LFChatViewController.h"
#import "LFChatTextStorage.h"

@interface LFChatViewController ()<UITextViewDelegate>

@end

@implementation LFChatViewController
{
    UITextView *mTextView;
    LFChatTextStorage *mStorage;
    NSDictionary *_replacementMap;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // rect
    CGRect textViewRect = CGRectMake(20, 80, 200, 80);
    
    NSDictionary* attrs = @{NSFontAttributeName:
                                [UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    NSAttributedString* attrString = [[NSAttributedString alloc]
                                      initWithString:@""
                                      attributes:attrs];
    
    // Text Storage
    mStorage = [[LFChatTextStorage alloc] init];
    [mStorage appendAttributedString:attrString];
    
    // Layout Manager
    NSLayoutManager *mLayoutMange = [[NSLayoutManager alloc] init];
    [mStorage addLayoutManager:mLayoutMange];
    
    // Text Container
    NSTextContainer *mTextContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(CGRectGetWidth(textViewRect), CGFLOAT_MAX)];
    [mLayoutMange addTextContainer:mTextContainer];
    
    // Text View
    mTextView = [[UITextView alloc] initWithFrame:textViewRect textContainer:mTextContainer];
    mTextView.delegate = self;
    mTextView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    mTextView.layer.borderWidth = 1.0;
    [self.view addSubview:mTextView];
    
    UIButton *btnEdit = [[UIButton alloc] initWithFrame:CGRectMake(230, 100, 50, 30)];
    [btnEdit setBackgroundColor:[UIColor blueColor]];
    [btnEdit setTitle:@"Send" forState:UIControlStateNormal];
    [btnEdit addTarget:self action:@selector(btnEdit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEdit];
    
    // load emoticons
    [self loadEmoticons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadEmoticons
{
    NSString *emotionsBundlePath = [[NSBundle mainBundle] pathForResource:@"emoj" ofType:@"bundle"];
    NSBundle *emotionsBundle = [NSBundle bundleWithPath:emotionsBundlePath];
    NSString *smileImgPath = [emotionsBundle pathForResource:@"001@2x" ofType:@"png" inDirectory:@"emoticons"];
    NSString *shyImgPath = [emotionsBundle pathForResource:@"002@2x" ofType:@"png" inDirectory:@"emoticons"];
    NSString *naughtyImgPath = [emotionsBundle pathForResource:@"003@2x" ofType:@"png" inDirectory:@"emoticons"];
    NSString *gloatImgPath = [emotionsBundle pathForResource:@"004@2x" ofType:@"png" inDirectory:@"emoticons"];
    
    _replacementMap = @{@"\\/smile\\b"        : smileImgPath,
                        @"\\/shy\\b"          : shyImgPath,
                        @"\\/naughty\\b"      : naughtyImgPath,
                        @"\\/gloatImgPath\\b" : gloatImgPath};
}

- (void)btnEdit:(id)sender
{
    [mTextView becomeFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self performReplacementsForRange:textView.textStorage.editedRange];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (void)performReplacementsForRange:(NSRange)changedRange
{
    NSRange extendedRange = NSMakeRange(0, mTextView.text.length);
    [self analysisTextView:mTextView From:extendedRange];
}

- (void)analysisTextView:(UITextView *)textView From:(NSRange)searchRange
{
    
    for (NSString *key in _replacementMap) {
        
        NSRegularExpression *regex = [NSRegularExpression
                                      regularExpressionWithPattern:key
                                      options:0
                                      error:nil];
        
        NSString *path = _replacementMap[key];
        
        [regex enumerateMatchesInString:textView.text
                                options:0
                                  range:NSMakeRange(0, mTextView.text.length)
                             usingBlock:^(NSTextCheckingResult *match,
                                          NSMatchingFlags flags,
                                          BOOL *stop){
                                 
                                 NSLog(@"获取到匹配的字符串");
                                 NSRange matchRange = [match rangeAtIndex:0];
                                 NSTextAttachment *emoticonAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
                                 UIImage *img = [UIImage imageWithContentsOfFile:path];
                                 emoticonAttachment.image = img;
                                 emoticonAttachment.bounds = CGRectMake(0, 0, 16, 16);
                                 NSAttributedString *attriString = [NSAttributedString attributedStringWithAttachment:emoticonAttachment];
                                 [textView.textStorage replaceCharactersInRange:matchRange withAttributedString:attriString];
                                 
                             }];

        
    }
}

@end
