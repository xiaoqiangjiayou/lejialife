//
//  AutoScrollView.m
//  AutoScoll
//
//  Created by lijinghua on 15/8/19.
//  Copyright (c) 2015年 lijinghua. All rights reserved.
//

#import "AutoScrollView.h"
#import "GrayPageControl.h"
//#import "BaseViewController.h"
@interface AutoScrollView ()<UIScrollViewDelegate>

{
    UIScrollView *_scrollView;
    NSTimer      *_timer;
    
    UIImageView  *_leftImageView;
    UIImageView  *_centerImageView;
    UIImageView  *_rightImageView;
    
    NSArray      *_imageArray;
    UIPageControl *_pageController;
    UIButton *_btn;
}
@end

@implementation AutoScrollView

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray*)imageArray
{
    if (self = [super initWithFrame:frame]) {
        
        _imageArray = imageArray;
        
        if (_imageArray.count <= 1) {
            return self;
        }
        
        
        [self createScrollView];
        [self createContentViews];
        [self createPageControl];
        
        //[self startTimer];
    }
    
    return self;
}

- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(3*self.frame.size.width, self.frame.size.height);
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    _scrollView.showsHorizontalScrollIndicator=NO;
    [self addSubview:_scrollView];
}

- (void)createContentViews
{
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _leftImageView.tag = _imageArray.count-1;
    
    _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    _centerImageView.tag = 0;
    
    _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*2, 0, self.frame.size.width, self.frame.size.height)];
    _rightImageView.tag = 1;
    
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_centerImageView];
    [_scrollView addSubview:_rightImageView];
    //
//    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:[_imageArray objectAtIndex:_leftImageView.tag]] placeholderImage:[UIImage imageNamed:@"sugar_bannar_second.png"]];
//    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:[_imageArray objectAtIndex:_centerImageView.tag]] placeholderImage:[UIImage imageNamed:@"sugar_bannar_second.png"]];
//    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:[_imageArray objectAtIndex:_rightImageView.tag]] placeholderImage:[UIImage imageNamed:@"sugar_bannar_second.png"]];
   
    _leftImageView.image   = [_imageArray objectAtIndex:_leftImageView.tag];
    _centerImageView.image = [_imageArray objectAtIndex:_centerImageView.tag];
    _rightImageView.image  = [_imageArray objectAtIndex:_rightImageView.tag];
   _btn=[[UIButton alloc]initWithFrame:_centerImageView.bounds];
//    [_btn addTarget:self action:@selector(btnclick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_centerImageView addSubview:_btn];
    _centerImageView.userInteractionEnabled=YES;
    _btn.tag = 100+_centerImageView.tag;
}
//-(void)btnclick:(UIButton *)button
//{
//    remendetailViewController *detailView = [[remendetailViewController alloc]init];
//    if (self.block) {
//        self.block(detailView);
//    }
//    //NSLog(@"%d",button.tag);
//    if (self.tblock) {
//        self.tblock(button.tag);
//    }
//}
- (void)createPageControl
{
    _pageController = [[GrayPageControl alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
    
    _pageController.center = CGPointMake(self.frame.size.width/2, self.frame.size.height-20);
    _pageController.numberOfPages = _imageArray.count;
    _pageController.pageIndicatorTintColor = [UIColor groupTableViewBackgroundColor];
    _pageController.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:_pageController];
}

- (void)updateContent
{
    if (_scrollView.contentOffset.x > self.frame.size.width) {
        //next
        _leftImageView.tag   = _centerImageView.tag;
        _centerImageView.tag = _rightImageView.tag;
        _rightImageView.tag  = (_rightImageView.tag + 1)%_imageArray.count;
    }else if(_scrollView.contentOffset.x < self.frame.size.width)
    {
        //before
        _rightImageView.tag  = _centerImageView.tag;
        _centerImageView.tag = _leftImageView.tag;
        _leftImageView.tag   = (_leftImageView.tag - 1 + _imageArray.count)%_imageArray.count;
    }

    _leftImageView.image   = [_imageArray objectAtIndex:_leftImageView.tag];
    _centerImageView.image = [_imageArray objectAtIndex:_centerImageView.tag];
    _rightImageView.image  = [_imageArray objectAtIndex:_rightImageView.tag];
    
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    _pageController.currentPage = _centerImageView.tag;
    _btn.tag = _centerImageView.tag+100;
}

- (void)startTimer
{
    if (_imageArray.count <= 1) return;
    
    //[self stopTimer];
    
    //_timer = [[NSTimer alloc]initWithFireDate:nil interval:1 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)nextPage
{
    if (_scrollView.contentOffset.x != 0) {
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width*2, 0) animated:YES];
    }
}

#pragma mark -
#pragma makr UIScollViewDeleage

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //[self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //[self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateContent];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateContent];
}

@end
