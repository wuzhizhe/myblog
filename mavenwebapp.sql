/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50715
Source Host           : localhost:3306
Source Database       : mavenwebapp

Target Server Type    : MYSQL
Target Server Version : 50715
File Encoding         : 65001

Date: 2017-02-10 16:35:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog` (
  `ID` varchar(255) NOT NULL,
  `BLOGNAME` varchar(255) NOT NULL,
  `USERID` int(11) NOT NULL,
  `TAGS` varchar(255) DEFAULT NULL,
  `STATUS` int(11) NOT NULL DEFAULT '1',
  `CRTDATE` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `blog_ID_uindex` (`ID`),
  KEY `blog_user_id_fk` (`USERID`),
  CONSTRAINT `blog_user_id_fk` FOREIGN KEY (`USERID`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户博客';

-- ----------------------------
-- Records of blog
-- ----------------------------
INSERT INTO `blog` VALUES ('0beb248d-765b-4e6e-84aa-4b5e954828d2', '测试2', '1', '', '0', '2016-12-07 16:07:38');
INSERT INTO `blog` VALUES ('0ea6f5d1-8c99-4c7a-ae16-c688f83f3e23', '这个是桌面截图', '1', '', '0', '2016-12-13 17:03:55');
INSERT INTO `blog` VALUES ('1211f63a-19e4-4788-9f65-ce6f019e1f9a', '哈哈哈', '1', '', '0', '2016-12-13 17:37:31');
INSERT INTO `blog` VALUES ('2355d1bd-fbb3-4b38-87bc-feae98e3d97e', '第一篇博客', '1', '', '0', '2016-12-07 17:40:26');
INSERT INTO `blog` VALUES ('a2676b27-89a0-497c-a63b-de5e5c6abea7', '我擦', '1', '', '0', '2016-12-13 17:37:57');
INSERT INTO `blog` VALUES ('be56c6e1-65d7-4601-be8a-6abf758fe30a', '测试1', '1', '', '0', '2016-12-07 16:07:21');
INSERT INTO `blog` VALUES ('c67ea7e8-a526-4b22-bc75-00c9bbffeeda', '你好啊', '1', '', '0', '2016-12-07 16:22:16');
INSERT INTO `blog` VALUES ('d1367b78-a06f-4d3b-a6ee-52e530b74698', '测试4', '1', '', '0', '2016-12-07 16:16:23');
INSERT INTO `blog` VALUES ('e42dd0ec-7b68-4ca0-93ff-fb7af7af6374', '测试3', '1', '', '0', '2016-12-07 16:15:59');
INSERT INTO `blog` VALUES ('e9d3441d-8d4c-4b4f-b190-452cc59f22e4', '第22篇博客', '1', '', '0', '2017-01-04 09:48:00');
INSERT INTO `blog` VALUES ('ef537d9e-251b-4283-bc84-7d0f9104442a', '测试博客', '1', '', '0', '2016-12-07 10:06:57');

-- ----------------------------
-- Table structure for blogcomment
-- ----------------------------
DROP TABLE IF EXISTS `blogcomment`;
CREATE TABLE `blogcomment` (
  `ID` int(11) NOT NULL DEFAULT '0',
  `BLOGID` varchar(255) NOT NULL,
  `CONTENT` longtext,
  `STATUS` int(11) NOT NULL DEFAULT '1',
  `CRTTIME` datetime DEFAULT CURRENT_TIMESTAMP,
  `USERID` int(11) DEFAULT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `BLOGCOMMENT_user_id_fk` (`USERID`),
  KEY `BLOG_ID` (`BLOGID`),
  CONSTRAINT `BLOGCOMMENT_user_id_fk` FOREIGN KEY (`USERID`) REFERENCES `user` (`id`),
  CONSTRAINT `BLOG_ID` FOREIGN KEY (`BLOGID`) REFERENCES `blog` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='博客留言';

-- ----------------------------
-- Records of blogcomment
-- ----------------------------

-- ----------------------------
-- Table structure for blogdetail
-- ----------------------------
DROP TABLE IF EXISTS `blogdetail`;
CREATE TABLE `blogdetail` (
  `BLOGDETAILID` int(11) NOT NULL AUTO_INCREMENT,
  `BLOGID` varchar(255) NOT NULL,
  `BLOGTEXT` longtext,
  PRIMARY KEY (`BLOGDETAILID`),
  KEY `BLOGID` (`BLOGID`),
  CONSTRAINT `BLOGID` FOREIGN KEY (`BLOGID`) REFERENCES `blog` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='博客详细内容';

-- ----------------------------
-- Records of blogdetail
-- ----------------------------
INSERT INTO `blogdetail` VALUES ('1', '0ea6f5d1-8c99-4c7a-ae16-c688f83f3e23', '<p><br></p><p>桌面截图啊</p><p><br></p><p><img src=\"http://127.0.0.1:8089/images/96dec3d2-39e5-4a7d-b24c-3a8f5c0d6f52.png\"></p><p><br></p>');
INSERT INTO `blogdetail` VALUES ('2', 'ef537d9e-251b-4283-bc84-7d0f9104442a', '<p><br></p><p><img src=\"http://127.0.0.1:8089/images/0f8fea61-49d0-4576-b982-701f21a839b9.png\"></p>');
INSERT INTO `blogdetail` VALUES ('3', 'e9d3441d-8d4c-4b4f-b190-452cc59f22e4', '<p>个人小博客可以写文章展示文章了。</p><p><br></p><p>终于算是开始有点样子了，哈哈，这个是第一篇博客，写下来记录下，时间是2016-12-07 16:04，嘿嘿嘿</p><p><br></p><p><br></p><p>记下来再接再厉啊，哈哈哈哈哈哈哈哈哈哈。</p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p>向着未来进发。</p>');
INSERT INTO `blogdetail` VALUES ('4', 'be56c6e1-65d7-4601-be8a-6abf758fe30a', '<p>测试1，呵呵呵呵呵呵</p>');
INSERT INTO `blogdetail` VALUES ('5', '0beb248d-765b-4e6e-84aa-4b5e954828d2', '<p><br></p><p>测试2，呵呵呵呵呵呵。</p><p><br></p><p>救命啊，我不要跟这白痴在一起！</p><p><br></p><p>。。。。。</p>');
INSERT INTO `blogdetail` VALUES ('6', 'e42dd0ec-7b68-4ca0-93ff-fb7af7af6374', '<p>测试3，呵呵呵呵呵呵</p>');
INSERT INTO `blogdetail` VALUES ('7', 'd1367b78-a06f-4d3b-a6ee-52e530b74698', '<p>测试4，呵呵呵呵呵呵</p>');
INSERT INTO `blogdetail` VALUES ('8', 'c67ea7e8-a526-4b22-bc75-00c9bbffeeda', '<p>哈哈哈哈哈</p>');
INSERT INTO `blogdetail` VALUES ('9', 'a2676b27-89a0-497c-a63b-de5e5c6abea7', '<p><a href=\"true\" target=\"_blank\"><strong>&lt;a&gt;你好&lt;/a&gt;</strong></a></p><p><strong>&lt;&lt;a</strong>&gt;你好啊啊 啊&lt;/a&gt;a&gt;你好啊啊 啊&lt;/a&gt;</p>');
INSERT INTO `blogdetail` VALUES ('10', '1211f63a-19e4-4788-9f65-ce6f019e1f9a', '<p>你好啊啊 啊</p>');
INSERT INTO `blogdetail` VALUES ('11', '2355d1bd-fbb3-4b38-87bc-feae98e3d97e', '<p>个人小博客可以写文章展示文章了。</p><p><br></p><p>终于算是开始有点样子了，哈哈，这个是第一篇博客，写下来记录下，时间是2016-12-07 16:04，嘿嘿嘿</p><p><br></p><p><br></p><p>记下来再接再厉啊，哈哈哈哈哈哈哈哈哈哈。</p><p><br></p><p><br></p><p><br></p><p><strong>更新一下。</strong></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p>向着未来进发。</p>');

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image` (
  `imageId` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`imageId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of image
-- ----------------------------
INSERT INTO `image` VALUES ('015c4351-804b-473e-a4c6-06b0cec95b6c', 'NinjaHead_100.png', 'headeimages/015c4351-804b-473e-a4c6-06b0cec95b6c.png', 'image/png');
INSERT INTO `image` VALUES ('01dca8e7-04e6-4cd9-8efc-03fe5068a72d', '260c98b2-e3d4-4d3d-979c-b2dfde84e382.jpeg', 'images/01dca8e7-04e6-4cd9-8efc-03fe5068a72d.jpeg', 'image/jpeg');
INSERT INTO `image` VALUES ('03f1909e-2ada-4cfd-9849-5dadb1021c61', 'NinjaHead_100.png', 'headeimages/03f1909e-2ada-4cfd-9849-5dadb1021c61.png', 'image/png');
INSERT INTO `image` VALUES ('0992f2ef-b363-41b6-9f20-43d09d1c5b21', '1483497279960787601431.jpg', 'headeimages/0992f2ef-b363-41b6-9f20-43d09d1c5b21.jpeg', 'image/jpeg');
INSERT INTO `image` VALUES ('0a5c2a25-ba9a-452f-b17b-00b323fc0307', 'NinjaHead_100.png', 'headeimages/0a5c2a25-ba9a-452f-b17b-00b323fc0307.png', 'image/png');
INSERT INTO `image` VALUES ('0f8fea61-49d0-4576-b982-701f21a839b9', '自动调整.png', 'images/0f8fea61-49d0-4576-b982-701f21a839b9.png', 'image/png');
INSERT INTO `image` VALUES ('15eb19b6-3bcf-4f0d-80a6-2ed87a6dd688', 'NinjaHead_100.png', 'headeimages/15eb19b6-3bcf-4f0d-80a6-2ed87a6dd688.png', 'image/png');
INSERT INTO `image` VALUES ('18a4224b-3d30-4e5f-9fbd-8b90b0b8fd8c', 'NinjaHead_100.png', 'headeimages/18a4224b-3d30-4e5f-9fbd-8b90b0b8fd8c.png', 'image/png');
INSERT INTO `image` VALUES ('1bcd33c9-20b7-4d52-9c47-7d0dad037f35', 'NinjaHead_100.png', 'headeimages/1bcd33c9-20b7-4d52-9c47-7d0dad037f35.png', 'image/png');
INSERT INTO `image` VALUES ('1d4140c7-4ef6-4278-b664-78333143bd42', '3db714e7-1c45-41fb-912d-1d64b1ec2e95.jpeg', 'images/1d4140c7-4ef6-4278-b664-78333143bd42.jpeg', 'image/jpeg');
INSERT INTO `image` VALUES ('20343cf2-f180-4e7b-bf93-a001d248e6d7', 'NinjaHead_100.png', 'headeimages/20343cf2-f180-4e7b-bf93-a001d248e6d7.png', 'image/png');
INSERT INTO `image` VALUES ('209e1677-491c-4886-9a51-534e4c4c9ad5', 'NinjaHead_100.png', 'headeimages/209e1677-491c-4886-9a51-534e4c4c9ad5.png', 'image/png');
INSERT INTO `image` VALUES ('241749ce-95bf-4edc-b3dc-410ab0a90790', 'jirebel--crack--server.jpg', 'images/241749ce-95bf-4edc-b3dc-410ab0a90790.jpeg', 'image/jpeg');
INSERT INTO `image` VALUES ('260c98b2-e3d4-4d3d-979c-b2dfde84e382', 'jirebel--crack--server.jpg', 'images/260c98b2-e3d4-4d3d-979c-b2dfde84e382.jpeg', 'image/jpeg');
INSERT INTO `image` VALUES ('2d8ddb8d-a31e-415c-80e5-f94b2e8fa462', 'NinjaHead_100.png', 'headeimages/2d8ddb8d-a31e-415c-80e5-f94b2e8fa462.png', 'image/png');
INSERT INTO `image` VALUES ('31afb750-3487-487f-b383-b726a52e167c', 'NinjaHead_100.png', 'headeimages/31afb750-3487-487f-b383-b726a52e167c.png', 'image/png');
INSERT INTO `image` VALUES ('36d96a85-15ef-4098-9651-ee5d1ebedc49', '自动调整.png', 'images/36d96a85-15ef-4098-9651-ee5d1ebedc49.png', 'image/png');
INSERT INTO `image` VALUES ('3942d1df-e8b7-4040-be76-82e56640cad5', 'NinjaHead_100.png', 'headeimages/3942d1df-e8b7-4040-be76-82e56640cad5.png', 'image/png');
INSERT INTO `image` VALUES ('3d8501f7-6d0f-4d69-bc22-b33e0c8706d6', 'NinjaHead_100.png', 'headeimages/3d8501f7-6d0f-4d69-bc22-b33e0c8706d6.png', 'image/png');
INSERT INTO `image` VALUES ('3db714e7-1c45-41fb-912d-1d64b1ec2e95', '534141aa-0b53-4365-9535-7317ac8cae5d.jpeg', 'images/3db714e7-1c45-41fb-912d-1d64b1ec2e95.jpeg', 'image/jpeg');
INSERT INTO `image` VALUES ('3fc9b295-b812-44c0-87ce-e9f927bf040d', '1d4140c7-4ef6-4278-b664-78333143bd42.jpeg', 'images/3fc9b295-b812-44c0-87ce-e9f927bf040d.jpeg', 'image/jpeg');
INSERT INTO `image` VALUES ('4c8aa4e3-5f39-420d-9c2f-3bc2298b2f46', 'NinjaHead_100.png', 'headeimages/4c8aa4e3-5f39-420d-9c2f-3bc2298b2f46.png', 'image/png');
INSERT INTO `image` VALUES ('534141aa-0b53-4365-9535-7317ac8cae5d', 'jirebel--crack--server.jpg', 'images/534141aa-0b53-4365-9535-7317ac8cae5d.jpeg', 'image/jpeg');
INSERT INTO `image` VALUES ('56f30e43-80cf-4c45-a117-5d242d495ef1', 'NinjaHead_100.png', 'headeimages/56f30e43-80cf-4c45-a117-5d242d495ef1.png', 'image/png');
INSERT INTO `image` VALUES ('593b153f-56d7-4f29-a0df-a34884c44636', '01dca8e7-04e6-4cd9-8efc-03fe5068a72d.jpeg', 'images/593b153f-56d7-4f29-a0df-a34884c44636.jpeg', 'image/jpeg');
INSERT INTO `image` VALUES ('5ebfa7b6-cb56-4d00-9355-dac7cfe4464e', 'NinjaHead_100.png', 'headeimages/5ebfa7b6-cb56-4d00-9355-dac7cfe4464e.png', 'image/png');
INSERT INTO `image` VALUES ('5fb54bf2-1212-41bd-8c6b-39792e64c823', 'NinjaHead_100.png', 'headeimages/5fb54bf2-1212-41bd-8c6b-39792e64c823.png', 'image/png');
INSERT INTO `image` VALUES ('6ce35047-3b45-4ed2-9f31-49b4c22cc92a', '01dca8e7-04e6-4cd9-8efc-03fe5068a72d.jpeg', 'images/6ce35047-3b45-4ed2-9f31-49b4c22cc92a.jpeg', 'image/jpeg');
INSERT INTO `image` VALUES ('6f7d4b73-432e-46c2-b516-2b937399585f', 'NinjaHead_100.png', 'headeimages/6f7d4b73-432e-46c2-b516-2b937399585f.png', 'image/png');
INSERT INTO `image` VALUES ('74afe32f-4cfc-4c22-8454-14a23d8be6e7', 'user-96.png', 'headeimages/74afe32f-4cfc-4c22-8454-14a23d8be6e7.png', 'image/png');
INSERT INTO `image` VALUES ('77128bf0-9dca-4333-9a43-32e3d4bd2ffc', 'NinjaHead_100.png', 'headeimages/77128bf0-9dca-4333-9a43-32e3d4bd2ffc.png', 'image/png');
INSERT INTO `image` VALUES ('77d77f64-dc51-4765-8bfe-d6531ee77cf4', 'NinjaHead_100.png', 'headeimages/77d77f64-dc51-4765-8bfe-d6531ee77cf4.png', 'image/png');
INSERT INTO `image` VALUES ('7c901b59-ebd8-40cd-87eb-badd66bfad74', 'NinjaHead_100.png', 'headeimages/7c901b59-ebd8-40cd-87eb-badd66bfad74.png', 'image/png');
INSERT INTO `image` VALUES ('8ff1896b-a01c-43e4-8465-a3f306fde828', 'NinjaHead_100.png', 'headeimages/8ff1896b-a01c-43e4-8465-a3f306fde828.png', 'image/png');
INSERT INTO `image` VALUES ('96bbf845-721f-4881-9ac2-3a0ed1480aaa', 'NinjaHead_100.png', 'headeimages/96bbf845-721f-4881-9ac2-3a0ed1480aaa.png', 'image/png');
INSERT INTO `image` VALUES ('96dec3d2-39e5-4a7d-b24c-3a8f5c0d6f52', '2016-11-29_155718.png', 'images/96dec3d2-39e5-4a7d-b24c-3a8f5c0d6f52.png', 'image/png');
INSERT INTO `image` VALUES ('9bb938b7-03ca-485b-bb38-e15c6308da19', '首页-50.png', 'images/9bb938b7-03ca-485b-bb38-e15c6308da19.png', 'image/png');
INSERT INTO `image` VALUES ('9c6e53c4-4c6a-4944-b4b2-ad12dd109fd8', '首页-50.png', 'images/9c6e53c4-4c6a-4944-b4b2-ad12dd109fd8.png', 'image/png');
INSERT INTO `image` VALUES ('a1696344-84a0-4c3f-95cb-b2d016e106d8', 'NinjaHead_100.png', 'headeimages/a1696344-84a0-4c3f-95cb-b2d016e106d8.png', 'image/png');
INSERT INTO `image` VALUES ('a1c4c599-6bcf-42f7-bf3f-5b837e92bf72', '自动调整.png', 'images/a1c4c599-6bcf-42f7-bf3f-5b837e92bf72.png', 'image/png');
INSERT INTO `image` VALUES ('aa53f31d-29d9-4d99-9bde-4168aabf95ad', 'NinjaHead_100.png', 'headeimages/aa53f31d-29d9-4d99-9bde-4168aabf95ad.png', 'image/png');
INSERT INTO `image` VALUES ('ada8e3c0-04e9-43c8-9a3d-64e81347b939', 'NinjaHead_100.png', 'headeimages/ada8e3c0-04e9-43c8-9a3d-64e81347b939.png', 'image/png');
INSERT INTO `image` VALUES ('afa8b1f6-ce22-43f8-8577-5df74cf4d292', 'NinjaHead_100.png', 'headeimages/afa8b1f6-ce22-43f8-8577-5df74cf4d292.png', 'image/png');
INSERT INTO `image` VALUES ('b31d7d8e-9e42-466f-a62e-e15542f9667c', 'NinjaHead_50.png', 'headeimages/b31d7d8e-9e42-466f-a62e-e15542f9667c.png', 'image/png');
INSERT INTO `image` VALUES ('b88a8f14-4cfd-41b8-86ef-e6d7bc7efe87', 'NinjaHead_100.png', 'headeimages/b88a8f14-4cfd-41b8-86ef-e6d7bc7efe87.png', 'image/png');
INSERT INTO `image` VALUES ('ba115875-ef10-4595-9b16-c3207a57ada5', 'NinjaHead_100.png', 'headeimages/ba115875-ef10-4595-9b16-c3207a57ada5.png', 'image/png');
INSERT INTO `image` VALUES ('c604e4af-92b6-49d7-8f3d-e1e6f3ddf0fd', '1483497338278283221237.jpg', 'headeimages/c604e4af-92b6-49d7-8f3d-e1e6f3ddf0fd.jpeg', 'image/jpeg');
INSERT INTO `image` VALUES ('c8156ea9-85e6-4ba5-94de-a2cf1890b74d', 'Screenshot_2016-10-24-11-43-44.png', 'images/c8156ea9-85e6-4ba5-94de-a2cf1890b74d.png', 'image/png');
INSERT INTO `image` VALUES ('c9a06d98-4e04-49f6-aaaf-c7b3913f787e', 'jirebel--crack--server.jpg', 'images/c9a06d98-4e04-49f6-aaaf-c7b3913f787e.jpeg', 'image/jpeg');
INSERT INTO `image` VALUES ('d083edd3-5c8a-4b1f-ba3c-df78c74e87aa', 'Home-96.png', 'images/d083edd3-5c8a-4b1f-ba3c-df78c74e87aa.png', 'image/png');
INSERT INTO `image` VALUES ('dc7aa9e1-7ab2-475c-9279-6e41cd181013', '01dca8e7-04e6-4cd9-8efc-03fe5068a72d.jpeg', 'images/dc7aa9e1-7ab2-475c-9279-6e41cd181013.jpeg', 'image/jpeg');
INSERT INTO `image` VALUES ('e09844a6-2579-4088-9712-fdbb161813ad', 'jirebel--crack--server.jpg', 'images/e09844a6-2579-4088-9712-fdbb161813ad.jpeg', 'image/jpeg');
INSERT INTO `image` VALUES ('e2571aa2-563c-4351-9ba4-1aa7ebf2c9fd', 'user-96.png', 'headeimages/e2571aa2-563c-4351-9ba4-1aa7ebf2c9fd.png', 'image/png');
INSERT INTO `image` VALUES ('ee4c14f5-b430-487b-b1b2-a68638f78377', 'NinjaHead_100.png', 'headeimages/ee4c14f5-b430-487b-b1b2-a68638f78377.png', 'image/png');
INSERT INTO `image` VALUES ('ef355c2e-d579-4aa4-9247-ec776bc48d5f', 'NinjaHead_100.png', 'headeimages/ef355c2e-d579-4aa4-9247-ec776bc48d5f.png', 'image/png');
INSERT INTO `image` VALUES ('f6ab7b98-4308-4166-9f1d-af4620204ace', 'lg2.png', 'headeimages/f6ab7b98-4308-4166-9f1d-af4620204ace.png', 'image/png');

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `id` int(100) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `createtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES ('1', 'zhangzemu', '1234567890', '2016-09-29 14:48:26');
INSERT INTO `test` VALUES ('2', 'lanchong', '1234567890', '2016-09-29 12:02:10');
INSERT INTO `test` VALUES ('3', 'shagua', '123456', '2016-09-29 11:59:49');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `telphone` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `email` varchar(255) DEFAULT NULL,
  `headimage` varchar(255) DEFAULT NULL,
  `lastlogintime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'zhangzemu', 'CFCD208495D565EF66E7DFF9F98764DA', '泽木', '1', 'zemu', 'male', '13356897412', '2016-10-18 09:28:22', '2016-12-26 11:23:09', null, 'headeimages/c604e4af-92b6-49d7-8f3d-e1e6f3ddf0fd.jpeg', '2017-02-10 15:55:48');
INSERT INTO `user` VALUES ('5', 'admin', '0', 'stupid boy', null, null, null, '13730901505', null, null, null, null, '2016-12-30 10:22:05');
INSERT INTO `user` VALUES ('6', 'admin', '0', 'stupid boy', null, null, null, '13730901505', null, null, null, null, '2016-12-30 10:22:05');
INSERT INTO `user` VALUES ('7', 'admin', '0', 'stupid boy', null, null, null, '13730901505', null, null, null, null, '2016-12-30 10:22:05');
INSERT INTO `user` VALUES ('10', '111', 'BFB1920063276CAA4A44CF4B3B188897', '222', null, null, null, '123', null, null, null, null, '2016-12-30 10:22:05');
INSERT INTO `user` VALUES ('11', '111吧', 'BFB1920063276CAA4A44CF4B3B188897', '222', null, null, null, '123', null, null, null, null, '2016-12-30 10:22:05');

-- ----------------------------
-- Table structure for userloginhis
-- ----------------------------
DROP TABLE IF EXISTS `userloginhis`;
CREATE TABLE `userloginhis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `logintime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `loginip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  CONSTRAINT `username` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userloginhis
-- ----------------------------
INSERT INTO `userloginhis` VALUES ('1', 'zhangzemu', '2016-12-30 10:44:34', null);
INSERT INTO `userloginhis` VALUES ('2', 'zhangzemu', '2016-12-30 10:48:37', null);
INSERT INTO `userloginhis` VALUES ('3', 'zhangzemu', '2016-12-30 10:49:56', null);
INSERT INTO `userloginhis` VALUES ('4', 'zhangzemu', '2016-12-30 10:51:17', null);
INSERT INTO `userloginhis` VALUES ('5', 'zhangzemu', '2016-12-30 10:58:32', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('6', 'zhangzemu', '2016-12-30 11:00:24', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('7', 'zhangzemu', '2016-12-30 11:19:22', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('8', 'zhangzemu', '2016-12-30 13:57:18', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('9', 'zhangzemu', '2016-12-30 17:43:49', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('10', 'zhangzemu', '2016-12-30 17:48:54', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('11', 'zhangzemu', '2016-12-30 17:49:06', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('12', 'zhangzemu', '2016-12-30 17:52:15', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('13', 'zhangzemu', '2016-12-30 17:52:19', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('14', 'zhangzemu', '2016-12-30 17:52:23', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('15', 'zhangzemu', '2016-12-30 17:52:29', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('16', 'zhangzemu', '2017-01-03 10:43:14', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('17', 'zhangzemu', '2017-01-03 10:44:19', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('18', 'zhangzemu', '2017-01-03 10:46:07', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('19', 'zhangzemu', '2017-01-04 09:47:02', '127.0.0.1');
INSERT INTO `userloginhis` VALUES ('20', 'zhangzemu', '2017-01-04 09:47:33', '10.16.10.158');
INSERT INTO `userloginhis` VALUES ('21', 'zhangzemu', '2017-01-04 09:48:39', '10.16.10.158');
INSERT INTO `userloginhis` VALUES ('22', 'zhangzemu', '2017-01-04 09:57:40', '10.16.10.158');
INSERT INTO `userloginhis` VALUES ('23', 'zhangzemu', '2017-01-04 10:36:45', '10.16.10.158');
INSERT INTO `userloginhis` VALUES ('24', 'zhangzemu', '2017-02-10 11:39:41', '10.16.10.158');
INSERT INTO `userloginhis` VALUES ('25', 'zhangzemu', '2017-02-10 13:03:52', '10.16.10.158');
INSERT INTO `userloginhis` VALUES ('26', 'zhangzemu', '2017-02-10 13:05:53', '10.16.10.158');
INSERT INTO `userloginhis` VALUES ('27', 'zhangzemu', '2017-02-10 13:08:25', '10.16.10.158');
INSERT INTO `userloginhis` VALUES ('28', 'zhangzemu', '2017-02-10 13:33:37', '10.16.10.158');
INSERT INTO `userloginhis` VALUES ('29', 'zhangzemu', '2017-02-10 13:57:04', '10.16.10.158');
INSERT INTO `userloginhis` VALUES ('30', 'zhangzemu', '2017-02-10 14:00:34', '10.16.10.158');
INSERT INTO `userloginhis` VALUES ('31', 'zhangzemu', '2017-02-10 14:01:41', '10.16.10.158');
INSERT INTO `userloginhis` VALUES ('32', 'zhangzemu', '2017-02-10 15:55:48', '10.16.10.158');
