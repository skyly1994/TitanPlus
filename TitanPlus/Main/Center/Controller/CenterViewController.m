//
//  CenterViewController.m
//  TitanPlus
//
//  Created by 陆斌 on 16/9/13.
//  Copyright © 2016年 陆斌. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *_iconView;
    UIImage *_iconImage;
}
@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createHeaderView];

}
- (void)createHeaderView{
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    headerView.backgroundColor = [UIColor redColor];
    headerView.image = [UIImage imageNamed:@"user_top_bg@2x"];
    headerView.userInteractionEnabled = YES;
    
    _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    _iconView.layer.cornerRadius = 20;
    _iconView.layer.masksToBounds = YES;
    _iconView.center = CGPointMake(kScreenWidth/2, 60);
    _iconView.backgroundColor = [UIColor cyanColor];
    
    NSData *data= [[NSUserDefaults standardUserDefaults]objectForKey:@"imageData"];
    if (data) {
        UIImage *image = [UIImage imageWithData:data];
        _iconView.image = image;
    }

    _iconView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
    [_iconView addGestureRecognizer:tap];
    [headerView addSubview:_iconView];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.frame = CGRectMake(0, _iconView.bottom, kScreenWidth, 30);
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.text = @"陆斌最帅";
    
    [headerView addSubview:nameLabel];
    _staticTableView.tableHeaderView = headerView;
}
- (void)tapGesture{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:^{
        NSLog(@"相册以弹出");
    }];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    _iconView.image = image;
    NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
    [[NSUserDefaults standardUserDefaults]setObject:imgData forKey:@"imageData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
