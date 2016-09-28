//
//  NewsModel.h
//  TitanPlus
//
//  Created by 陆斌 on 16/9/17.
//  Copyright © 2016年 陆斌. All rights reserved.
//

/*
 {
 authorAuthentication = 1;
 authorHeadImage = "http://resource.ttplus.cn/editor/headphoto/05f041f1-96fa-49e5-bd70-8a43b7062da3.jpg";
 authorId = "6ec43645-9d15-416d-bc01-516c59452894";
 authorName = "\U5b54\U5fb7\U6615";
 authorSubscribe = 1;
 autohrDescription = "\U4f53\U575b+\U7bee\U7403\U8bb0\U8005";
 columns = "\U4e2d\U56fd\U7bee\U7403";
 commentnum = 0;
 id = 20714;
 imgurl = "http://resource.ttplus.cn/publish/app/data/2016/09/14/20714/7ae4fdf6-073c-4db8-b7cd-466490709e18.jpg";
 label = "\U5feb\U8baf";
 newstime = 1473840461910;
 sharetext = "\U4f53\U575b+\U8bb0\U8005\U5b54\U5fb7\U6615\U62a5\U9053\U5317\U4eac\U65f6\U95f49\U670814\U65e5\Uff0c\U7ee7\U6b64\U524d\U5468\U7426\U660e\U786e\U8868\U793a\U81ea\U5df1\U65b0\U8d5b\U5b63\U4e0d\U4f1a\U53bbNBA\U4e4b\U540e\Uff0c\U53e6\U4e00\U4f4d\U5728\U4eca\U5e74\U88ab\U9009\U4e2d\U7684\U4e2d\U56fd\U7403\U5458\U738b\U54f2\U6797\U4e5f\U80af\U5b9a\U4e86\U5c0f\U8d5b\U5b63\U7559\U5728\U798f\U5efa\U7684\U6d88\U606f\U3002\U81f3\U6b64\Uff0c\U8fd9\U4e2a\U590f\U5929\U7092\U5f97\U6cb8\U6cb8\U626c\U626c\U7684\U4e2d\U56fd\U4e24\U661f\U964d\U843dNBA\U7684\U6d88";
 shareurl = "http://resource.ttplus.cn/publish/app/data/2016/09/14/20714/share1.html";
 shorttitle = "\U738b\U54f2\U6797\U4e0b\U8d5b\U5b63\U4e0d\U4f1a\U767b\U9646NBA\U8d5b\U573a";
 source = "\U4f53\U575bPlus";
 summary = "\U4e00\U6b21\U91cc\U7ea6\U4e4b\U884c\U66b4\U9732\U4e86\U592a\U591a\U95ee\U9898\Uff0c\U7426\U6797\U8ddd\U79bbNBA\U8fd8\U6709\U4e0d\U5c0f\U7684\U8ddd\U79bb\U3002";
 thumbnail = "http://resource.ttplus.cn/publish/app/data/2016/09/14/20714/thumbnail/7ae4fdf6-073c-4db8-b7cd-466490709e18.jpg";
 title = "\U738b\U54f2\U6797\U627f\U8ba4\U4e0b\U8d5b\U5b63\U53bb\U4e0d\U4e86NBA\Uff1a\U7ed9\U6211\U4e00\U5e74\U65f6\U95f4\U53d8\U5f3a";
 type = 2;
 }
 
 */
#import <Foundation/Foundation.h>
@interface NewsModel : NSObject
@property(nonatomic,copy)NSString *authorHeadImage;//作者头像
@property(nonatomic,copy)NSString *imgurl;//图片url
@property(nonatomic,copy)NSString *shareurl;//新闻链接
@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,copy)NSString *authorName;//作者名字

@property(nonatomic,copy)NSString *time;
@end
