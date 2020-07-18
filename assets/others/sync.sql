-- ---------------------------------------------------------
-- SPECIAL THANKS TO @javihgm#8267 FOR DOING THIS SQL FILE
-- ---------------------------------------------------------

CREATE DATABASE IF NOT EXISTS `es_extended`;

USE `es_extended`;

CREATE TABLE `users` (
	`identifier` VARCHAR(40) NOT NULL,
	`accounts` LONGTEXT NULL DEFAULT NULL,
	`group` VARCHAR(50) NULL DEFAULT 'user',
	`inventory` LONGTEXT NULL DEFAULT NULL,
	`job` VARCHAR(20) NULL DEFAULT 'unemployed',
	`job_grade` INT NULL DEFAULT 0,
	`loadout` LONGTEXT NULL DEFAULT NULL,
	`position` VARCHAR(255) NULL DEFAULT '{"x":-269.4,"y":-955.3,"z":31.2,"heading":205.8}',

	PRIMARY KEY (`identifier`)
);

CREATE TABLE `items` (
	`name` VARCHAR(50) NOT NULL,
	`label` VARCHAR(50) NOT NULL,
	`weight` INT(11) NOT NULL DEFAULT 1,
	`rare` TINYINT(1) NOT NULL DEFAULT 0,
	`can_remove` TINYINT(1) NOT NULL DEFAULT 1,

	PRIMARY KEY (`name`)
);

CREATE TABLE `job_grades` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`job_name` VARCHAR(50) DEFAULT NULL,
	`grade` INT(11) NOT NULL,
	`name` VARCHAR(50) NOT NULL,
	`label` VARCHAR(50) NOT NULL,
	`salary` INT(11) NOT NULL,
	`skin_male` LONGTEXT NOT NULL,
	`skin_female` LONGTEXT NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `job_grades` VALUES (1,'unemployed',0,'unemployed','Unemployed',200,'{}','{}');

CREATE TABLE `jobs` (
	`name` VARCHAR(50) NOT NULL,
	`label` VARCHAR(50) DEFAULT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `jobs` VALUES ('unemployed','Unemployed');

CREATE TABLE `user_accounts` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(40) NOT NULL,
	`name` VARCHAR(50) NOT NULL,
	`money` INT(11) NOT NULL DEFAULT '0',

	PRIMARY KEY (`id`)
);

CREATE TABLE `society_moneywash` (
	`id` int NOT NULL AUTO_INCREMENT,
	`identifier` varchar(60) NOT NULL,
	`society` varchar(60) NOT NULL,
	`amount` int NOT NULL,

	PRIMARY KEY (`id`)
);


CREATE TABLE `shops` (
	`id` int NOT NULL AUTO_INCREMENT,
	`store` varchar(100) NOT NULL,
	`item` varchar(100) NOT NULL,
	`price` int NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `shops` (store, item, price) VALUES
	('TwentyFourSeven','bread',7),
	('TwentyFourSeven','water',2),
	('RobsLiquor','bread',10),
	('RobsLiquor','water',3),
	('LTDgasoline','bread',12),
	('LTDgasoline','water',4)
;

ALTER TABLE `users` ADD COLUMN `phone_number` VARCHAR(10) NULL;


CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Owner',
  `num` varchar(10) NOT NULL COMMENT 'Number of the contact',
  `incoming` int(11) NOT NULL COMMENT 'who is calling',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Accept the call or not',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.
-- Export de la structure de la table gtarp. phone_users_contacts
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_tweets_twitter_accounts` (`authorId`),
  CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  KEY `FK_twitter_likes_twitter_tweets` (`tweetId`),
  CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

ALTER TABLE `users` ADD COLUMN `last_property` VARCHAR(255) NULL;

CREATE TABLE `addon_account` (
	`name` VARCHAR(60) NOT NULL,
	`label` VARCHAR(100) NOT NULL,
	`shared` INT NOT NULL,

	PRIMARY KEY (`name`)
);

CREATE TABLE `addon_account_data` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`account_name` VARCHAR(100) DEFAULT NULL,
	`money` INT NOT NULL,
	`owner` VARCHAR(40) DEFAULT NULL,

	PRIMARY KEY (`id`),
	UNIQUE INDEX `index_addon_account_data_account_name_owner` (`account_name`, `owner`),
	INDEX `index_addon_account_data_account_name` (`account_name`)
);

CREATE TABLE `datastore` (
	`name` VARCHAR(60) NOT NULL,
	`label` VARCHAR(100) NOT NULL,
	`shared` INT NOT NULL,

	PRIMARY KEY (`name`)
);

CREATE TABLE `datastore_data` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(60) NOT NULL,
	`owner` VARCHAR(40),
	`data` LONGTEXT,

	PRIMARY KEY (`id`),
	UNIQUE INDEX `index_datastore_data_name_owner` (`name`, `owner`),
	INDEX `index_datastore_data_name` (`name`)
);

CREATE TABLE `addon_inventory` (
	`name` VARCHAR(60) NOT NULL,
	`label` VARCHAR(100) NOT NULL,
	`shared` INT NOT NULL,

	PRIMARY KEY (`name`)
);

CREATE TABLE `addon_inventory_items` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`inventory_name` VARCHAR(100) NOT NULL,
	`name` VARCHAR(100) NOT NULL,
	`count` INT NOT NULL,
	`owner` VARCHAR(40) DEFAULT NULL,

	PRIMARY KEY (`id`),
	INDEX `index_addon_inventory_items_inventory_name_name` (`inventory_name`, `name`),
	INDEX `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`, `name`, `owner`),
	INDEX `index_addon_inventory_inventory_name` (`inventory_name`)
);

INSERT INTO `addon_account` (name, label, shared) VALUES
  ('property_black_money','Dirty money property',0)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('property','Property',0)
;

INSERT INTO `datastore` (name, label, shared) VALUES
  ('property','Property',0)
;

CREATE TABLE `owned_properties` (

  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) NOT NULL,

  PRIMARY KEY (`id`)
);

CREATE TABLE `licenses` (
	`type` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`type`)
);

CREATE TABLE `user_licenses` (
	`id` int NOT NULL AUTO_INCREMENT,
	`type` varchar(60) NOT NULL,
	`owner` varchar(40) NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `addon_account` (name, label, shared) VALUES
	('caution', 'Caution', 0)
;

INSERT INTO `jobs` (name, label) VALUES
	('slaughterer', 'Butcher'),
	('fisherman', 'Fisherman'),
	('miner', 'Miner'),
	('lumberjack', 'Lumberjack'),
	('fueler', 'Refueler'),
	('reporter', 'Journalist'),
	('tailor', 'Tailor')
;

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('bread', 'bread', 1),
	('water', 'water', 1)
;

CREATE TABLE `billing` (
	`id` int NOT NULL AUTO_INCREMENT,
	`identifier` varchar(40) NOT NULL,
	`sender` varchar(40) NOT NULL,
	`target_type` varchar(50) NOT NULL,
	`target` varchar(40) NOT NULL,
	`label` varchar(255) NOT NULL,
	`amount` int NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('lumberjack', 0, 'employee', 'Interim', 60, '{}', '{}'),
	('fisherman', 0, 'employee', 'Interim', 50, '{}', '{}'),
	('fueler', 0, 'employee', 'Interim', 50, '{}', '{}'),
	('reporter', 0, 'employee', 'Interim', 90, '{}', '{}'),
	('tailor',0,'employee','Interim',40,'{\"mask_1\":0,\"arms\":1,\"glasses_1\":0,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":0,\"torso_1\":24,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":0,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":36,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":48,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}','{\"mask_1\":0,\"arms\":5,\"glasses_1\":5,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":1,\"torso_1\":52,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":1,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":23,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":42,\"tshirt_2\":4,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":36,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}'),
	('miner', 0, 'employee', 'Interim', 100, '{"tshirt_2":1,"ears_1":8,"glasses_1":15,"torso_2":0,"ears_2":2,"glasses_2":3,"shoes_2":1,"pants_1":75,"shoes_1":51,"bags_1":0,"helmet_2":0,"pants_2":7,"torso_1":71,"tshirt_1":59,"arms":2,"bags_2":0,"helmet_1":0}', '{}'),
	('slaughterer',0,'employee','Interim',100,'{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":67,\"pants_1\":36,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":0,\"torso_1\":56,\"beard_2\":6,\"shoes_1\":12,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":15,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":0,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}','{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":72,\"pants_1\":45,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":1,\"torso_1\":49,\"beard_2\":6,\"shoes_1\":24,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":9,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":5,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}')
;

ALTER TABLE jobs add whitelisted BOOLEAN NOT NULL DEFAULT FALSE;

ALTER TABLE `users`
	ADD COLUMN `firstname` VARCHAR(16) NULL DEFAULT NULL,
	ADD COLUMN `lastname` VARCHAR(16) NULL DEFAULT NULL,
	ADD COLUMN `dateofbirth` VARCHAR(10) NULL DEFAULT NULL,
	ADD COLUMN `sex` VARCHAR(1) NULL DEFAULT NULL,
	ADD COLUMN `height` INT NULL DEFAULT NULL
;

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('alive_chicken', 'Live chicken', 1),
	('slaughtered_chicken', 'Chicken meat', 1),
	('packaged_chicken', 'Package of chicken', 1),
	('fish', 'Fish', 1),
	('stone', 'Stone', 1),
	('washed_stone', 'Clean stone', 1),
	('copper', 'Copper', 1),
	('iron', 'Iron', 1),
	('gold', 'Gold', 1),
	('diamond', 'Diamond', 1),
	('wood', 'Wood', 1),
	('cutted_wood', 'Cut wood', 1),
	('packaged_plank', 'Bundled Planks', 1),
	('petrol', 'Oil', 1),
	('petrol_raffin', 'Refined Oil', 1),
	('essence', 'Gasoline', 1),
	('wool', 'Wool', 1),
	('fabric', 'Fabric', 1),
	('clothe', 'Cloth', 1)
;

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('cannabis', 'Cannabis', 3, 0, 1),
	('marijuana', 'Marijuana', 2, 0, 1)
;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('weed_processing', 'Weed Processing License')
;


CREATE TABLE `properties` (

  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `entering` varchar(255) DEFAULT NULL,
  `exit` varchar(255) DEFAULT NULL,
  `inside` varchar(255) DEFAULT NULL,
  `outside` varchar(255) DEFAULT NULL,
  `ipls` varchar(255) DEFAULT '[]',
  `gateway` varchar(255) DEFAULT NULL,
  `is_single` int(11) DEFAULT NULL,
  `is_room` int(11) DEFAULT NULL,
  `is_gateway` int(11) DEFAULT NULL,
  `room_menu` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL,

  PRIMARY KEY (`id`)
);

INSERT INTO `properties` VALUES
  (1,'WhispymoundDrive','2677 Whispymound Drive','{\"y\":564.89,\"z\":182.959,\"x\":119.384}','{\"x\":117.347,\"y\":559.506,\"z\":183.304}','{\"y\":557.032,\"z\":183.301,\"x\":118.037}','{\"y\":567.798,\"z\":182.131,\"x\":119.249}','[]',NULL,1,1,0,'{\"x\":118.748,\"y\":566.573,\"z\":175.697}',1500000),
  (2,'NorthConkerAvenue2045','2045 North Conker Avenue','{\"x\":372.796,\"y\":428.327,\"z\":144.685}','{\"x\":373.548,\"y\":422.982,\"z\":144.907},','{\"y\":420.075,\"z\":145.904,\"x\":372.161}','{\"x\":372.454,\"y\":432.886,\"z\":143.443}','[]',NULL,1,1,0,'{\"x\":377.349,\"y\":429.422,\"z\":137.3}',1500000),
  (3,'RichardMajesticApt2','Richard Majestic, Apt 2','{\"y\":-379.165,\"z\":37.961,\"x\":-936.363}','{\"y\":-365.476,\"z\":113.274,\"x\":-913.097}','{\"y\":-367.637,\"z\":113.274,\"x\":-918.022}','{\"y\":-382.023,\"z\":37.961,\"x\":-943.626}','[]',NULL,1,1,0,'{\"x\":-927.554,\"y\":-377.744,\"z\":112.674}',1700000),
  (4,'NorthConkerAvenue2044','2044 North Conker Avenue','{\"y\":440.8,\"z\":146.702,\"x\":346.964}','{\"y\":437.456,\"z\":148.394,\"x\":341.683}','{\"y\":435.626,\"z\":148.394,\"x\":339.595}','{\"x\":350.535,\"y\":443.329,\"z\":145.764}','[]',NULL,1,1,0,'{\"x\":337.726,\"y\":436.985,\"z\":140.77}',1500000),
  (5,'WildOatsDrive','3655 Wild Oats Drive','{\"y\":502.696,\"z\":136.421,\"x\":-176.003}','{\"y\":497.817,\"z\":136.653,\"x\":-174.349}','{\"y\":495.069,\"z\":136.666,\"x\":-173.331}','{\"y\":506.412,\"z\":135.0664,\"x\":-177.927}','[]',NULL,1,1,0,'{\"x\":-174.725,\"y\":493.095,\"z\":129.043}',1500000),
  (6,'HillcrestAvenue2862','2862 Hillcrest Avenue','{\"y\":596.58,\"z\":142.641,\"x\":-686.554}','{\"y\":591.988,\"z\":144.392,\"x\":-681.728}','{\"y\":590.608,\"z\":144.392,\"x\":-680.124}','{\"y\":599.019,\"z\":142.059,\"x\":-689.492}','[]',NULL,1,1,0,'{\"x\":-680.46,\"y\":588.6,\"z\":136.769}',1500000),
  (7,'LowEndApartment','Appartement de base','{\"y\":-1078.735,\"z\":28.4031,\"x\":292.528}','{\"y\":-1007.152,\"z\":-102.002,\"x\":265.845}','{\"y\":-1002.802,\"z\":-100.008,\"x\":265.307}','{\"y\":-1078.669,\"z\":28.401,\"x\":296.738}','[]',NULL,1,1,0,'{\"x\":265.916,\"y\":-999.38,\"z\":-100.008}',562500),
  (8,'MadWayneThunder','2113 Mad Wayne Thunder','{\"y\":454.955,\"z\":96.462,\"x\":-1294.433}','{"x":-1289.917,"y":449.541,"z":96.902}','{\"y\":446.322,\"z\":96.899,\"x\":-1289.642}','{\"y\":455.453,\"z\":96.517,\"x\":-1298.851}','[]',NULL,1,1,0,'{\"x\":-1287.306,\"y\":455.901,\"z\":89.294}',1500000),
  (9,'HillcrestAvenue2874','2874 Hillcrest Avenue','{\"x\":-853.346,\"y\":696.678,\"z\":147.782}','{\"y\":690.875,\"z\":151.86,\"x\":-859.961}','{\"y\":688.361,\"z\":151.857,\"x\":-859.395}','{\"y\":701.628,\"z\":147.773,\"x\":-855.007}','[]',NULL,1,1,0,'{\"x\":-858.543,\"y\":697.514,\"z\":144.253}',1500000),
  (10,'HillcrestAvenue2868','2868 Hillcrest Avenue','{\"y\":620.494,\"z\":141.588,\"x\":-752.82}','{\"y\":618.62,\"z\":143.153,\"x\":-759.317}','{\"y\":617.629,\"z\":143.153,\"x\":-760.789}','{\"y\":621.281,\"z\":141.254,\"x\":-750.919}','[]',NULL,1,1,0,'{\"x\":-762.504,\"y\":618.992,\"z\":135.53}',1500000),
  (11,'TinselTowersApt12','Tinsel Towers, Apt 42','{\"y\":37.025,\"z\":42.58,\"x\":-618.299}','{\"y\":58.898,\"z\":97.2,\"x\":-603.301}','{\"y\":58.941,\"z\":97.2,\"x\":-608.741}','{\"y\":30.603,\"z\":42.524,\"x\":-620.017}','[]',NULL,1,1,0,'{\"x\":-622.173,\"y\":54.585,\"z\":96.599}',1700000),
  (12,'MiltonDrive','Milton Drive','{\"x\":-775.17,\"y\":312.01,\"z\":84.658}',NULL,NULL,'{\"x\":-775.346,\"y\":306.776,\"z\":84.7}','[]',NULL,0,0,1,NULL,0),
  (13,'Modern1Apartment','Appartement Moderne 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_01_a\"]','MiltonDrive',0,1,0,'{\"x\":-766.661,\"y\":327.672,\"z\":210.396}',1300000),
  (14,'Modern2Apartment','Appartement Moderne 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_01_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.735,\"y\":326.757,\"z\":186.313}',1300000),
  (15,'Modern3Apartment','Appartement Moderne 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_01_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.386,\"y\":330.782,\"z\":195.08}',1300000),
  (16,'Mody1Apartment','Appartement Mode 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_02_a\"]','MiltonDrive',0,1,0,'{\"x\":-766.615,\"y\":327.878,\"z\":210.396}',1300000),
  (17,'Mody2Apartment','Appartement Mode 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_02_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.297,\"y\":327.092,\"z\":186.313}',1300000),
  (18,'Mody3Apartment','Appartement Mode 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_02_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.303,\"y\":330.932,\"z\":195.085}',1300000),
  (19,'Vibrant1Apartment','Appartement Vibrant 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_03_a\"]','MiltonDrive',0,1,0,'{\"x\":-765.885,\"y\":327.641,\"z\":210.396}',1300000),
  (20,'Vibrant2Apartment','Appartement Vibrant 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_03_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.607,\"y\":327.344,\"z\":186.313}',1300000),
  (21,'Vibrant3Apartment','Appartement Vibrant 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_03_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.525,\"y\":330.851,\"z\":195.085}',1300000),
  (22,'Sharp1Apartment','Appartement Persan 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_04_a\"]','MiltonDrive',0,1,0,'{\"x\":-766.527,\"y\":327.89,\"z\":210.396}',1300000),
  (23,'Sharp2Apartment','Appartement Persan 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_04_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.642,\"y\":326.497,\"z\":186.313}',1300000),
  (24,'Sharp3Apartment','Appartement Persan 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_04_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.503,\"y\":331.318,\"z\":195.085}',1300000),
  (25,'Monochrome1Apartment','Appartement Monochrome 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_05_a\"]','MiltonDrive',0,1,0,'{\"x\":-766.289,\"y\":328.086,\"z\":210.396}',1300000),
  (26,'Monochrome2Apartment','Appartement Monochrome 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_05_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.692,\"y\":326.762,\"z\":186.313}',1300000),
  (27,'Monochrome3Apartment','Appartement Monochrome 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_05_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.094,\"y\":330.976,\"z\":195.085}',1300000),
  (28,'Seductive1Apartment','Appartement Séduisant 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_06_a\"]','MiltonDrive',0,1,0,'{\"x\":-766.263,\"y\":328.104,\"z\":210.396}',1300000),
  (29,'Seductive2Apartment','Appartement Séduisant 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_06_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.655,\"y\":326.611,\"z\":186.313}',1300000),
  (30,'Seductive3Apartment','Appartement Séduisant 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_06_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.3,\"y\":331.414,\"z\":195.085}',1300000),
  (31,'Regal1Apartment','Appartement Régal 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_07_a\"]','MiltonDrive',0,1,0,'{\"x\":-765.956,\"y\":328.257,\"z\":210.396}',1300000),
  (32,'Regal2Apartment','Appartement Régal 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_07_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.545,\"y\":326.659,\"z\":186.313}',1300000),
  (33,'Regal3Apartment','Appartement Régal 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_07_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.087,\"y\":331.429,\"z\":195.123}',1300000),
  (34,'Aqua1Apartment','Appartement Aqua 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_08_a\"]','MiltonDrive',0,1,0,'{\"x\":-766.187,\"y\":328.47,\"z\":210.396}',1300000),
  (35,'Aqua2Apartment','Appartement Aqua 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_08_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.658,\"y\":326.563,\"z\":186.313}',1300000),
  (36,'Aqua3Apartment','Appartement Aqua 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_08_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.287,\"y\":331.084,\"z\":195.086}',1300000),
  (37,'IntegrityWay','4 Integrity Way','{\"x\":-47.804,\"y\":-585.867,\"z\":36.956}',NULL,NULL,'{\"x\":-54.178,\"y\":-583.762,\"z\":35.798}','[]',NULL,0,0,1,NULL,0),
  (38,'IntegrityWay28','4 Integrity Way - Apt 28',NULL,'{\"x\":-31.409,\"y\":-594.927,\"z\":79.03}','{\"x\":-26.098,\"y\":-596.909,\"z\":79.03}',NULL,'[]','IntegrityWay',0,1,0,'{\"x\":-11.923,\"y\":-597.083,\"z\":78.43}',1700000),
  (39,'IntegrityWay30','4 Integrity Way - Apt 30',NULL,'{\"x\":-17.702,\"y\":-588.524,\"z\":89.114}','{\"x\":-16.21,\"y\":-582.569,\"z\":89.114}',NULL,'[]','IntegrityWay',0,1,0,'{\"x\":-26.327,\"y\":-588.384,\"z\":89.123}',1700000),
  (40,'DellPerroHeights','Dell Perro Heights','{\"x\":-1447.06,\"y\":-538.28,\"z\":33.74}',NULL,NULL,'{\"x\":-1440.022,\"y\":-548.696,\"z\":33.74}','[]',NULL,0,0,1,NULL,0),
  (41,'DellPerroHeightst4','Dell Perro Heights - Apt 28',NULL,'{\"x\":-1452.125,\"y\":-540.591,\"z\":73.044}','{\"x\":-1455.435,\"y\":-535.79,\"z\":73.044}',NULL,'[]','DellPerroHeights',0,1,0,'{\"x\":-1467.058,\"y\":-527.571,\"z\":72.443}',1700000),
  (42,'DellPerroHeightst7','Dell Perro Heights - Apt 30',NULL,'{\"x\":-1451.562,\"y\":-523.535,\"z\":55.928}','{\"x\":-1456.02,\"y\":-519.209,\"z\":55.929}',NULL,'[]','DellPerroHeights',0,1,0,'{\"x\":-1457.026,\"y\":-530.219,\"z\":55.937}',1700000)
;


CREATE TABLE `weashops` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`zone` varchar(255) NOT NULL,
	`item` varchar(255) NOT NULL,
	`price` int(11) NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `datastore` (name, label, shared) VALUES
	('user_ears', 'Ears', 0),
	('user_glasses', 'Glasses', 0),
	('user_helmet', 'Helmet', 0),
	('user_mask', 'Mask', 0)
;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('weapon', "Gun license")
;

INSERT INTO `weashops` (`zone`, `item`, `price`) VALUES
	('GunShop','WEAPON_PISTOL', 400),
	('BlackWeashop','WEAPON_PISTOL', 600),
	('GunShop', 'WEAPON_FLASHLIGHT', 20),
	('BlackWeashop', 'WEAPON_FLASHLIGHT', 50),
	('GunShop', 'WEAPON_MACHETE', 50),
	('BlackWeashop', 'WEAPON_MACHETE', 110),
	('GunShop', 'WEAPON_NIGHTSTICK', 100),
	('BlackWeashop', 'WEAPON_NIGHTSTICK', 150),
	('GunShop', 'WEAPON_BAT', 30),
	('BlackWeashop', 'WEAPON_BAT', 50),
	('GunShop', 'WEAPON_STUNGUN', 150),
	('BlackWeashop', 'WEAPON_STUNGUN', 200),
	('GunShop', 'WEAPON_MICROSMG', 1400),
	('BlackWeashop', 'WEAPON_MICROSMG', 1700),
	('GunShop', 'WEAPON_PUMPSHOTGUN', 400),
	('BlackWeashop', 'WEAPON_PUMPSHOTGUN', 500),
	('GunShop', 'WEAPON_ASSAULTRIFLE', 1300),
	('BlackWeashop', 'WEAPON_ASSAULTRIFLE', 1900),
	('GunShop', 'WEAPON_SPECIALCARBINE', 2000),
	('BlackWeashop', 'WEAPON_SPECIALCARBINE', 2500),
	('GunShop', 'WEAPON_SNIPERRIFLE', 22000),
	('BlackWeashop', 'WEAPON_SNIPERRIFLE', 24000),
	('GunShop', 'WEAPON_FIREWORK', 18000),
	('BlackWeashop', 'WEAPON_FIREWORK', 20000),
	('GunShop', 'WEAPON_GRENADE', 500),
	('BlackWeashop', 'WEAPON_GRENADE', 650),
	('GunShop', 'WEAPON_BZGAS', 200),
	('BlackWeashop', 'WEAPON_BZGAS', 350),
	('GunShop', 'WEAPON_FIREEXTINGUISHER', 100),
	('BlackWeashop', 'WEAPON_FIREEXTINGUISHER', 100),
	('GunShop', 'WEAPON_BALL', 50),
	('BlackWeashop', 'WEAPON_BALL', 50),
	('GunShop', 'WEAPON_SMOKEGRENADE', 100),
	('BlackWeashop', 'WEAPON_SMOKEGRENADE', 100),
	('BlackWeashop', 'WEAPON_APPISTOL', 1100),
	('BlackWeashop', 'WEAPON_CARBINERIFLE', 2000),
	('BlackWeashop', 'WEAPON_HEAVYSNIPER', 3000),
	('BlackWeashop', 'WEAPON_MINIGUN', 10000),
	('BlackWeashop', 'WEAPON_RAILGUN', 50000),
	('BlackWeashop', 'WEAPON_STICKYBOMB', 500)
;

USE `es_extended`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_cardealer','Car Dealer',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_cardealer','Car Dealer',1)
;

INSERT INTO `jobs` (name, label) VALUES
	('cardealer','Car Dealer')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('cardealer',0,'recruit','Recruit',100,'{}','{}'),
	('cardealer',1,'novice','Novice',250,'{}','{}'),
	('cardealer',2,'experienced','Experienced',400,'{}','{}'),
	('cardealer',3,'boss','Boss',500,'{}','{}')
;

CREATE TABLE `cardealer_vehicles` (
	`id` int NOT NULL AUTO_INCREMENT,
	`vehicle` varchar(255) NOT NULL,
	`price` int NOT NULL,

	PRIMARY KEY (`id`)
);

CREATE TABLE `vehicle_sold` (
	`client` VARCHAR(50) NOT NULL,
	`model` VARCHAR(50) NOT NULL,
	`plate` VARCHAR(50) NOT NULL,
	`soldby` VARCHAR(50) NOT NULL,
	`date` VARCHAR(50) NOT NULL,

	PRIMARY KEY (`plate`)
);

CREATE TABLE `rented_vehicles` (
	`vehicle` varchar(60) NOT NULL,
	`plate` varchar(12) NOT NULL,
	`player_name` varchar(255) NOT NULL,
	`base_price` int NOT NULL,
	`rent_price` int NOT NULL,
	`owner` varchar(22) NOT NULL,

	PRIMARY KEY (`plate`)
);

CREATE TABLE `vehicle_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `vehicle_categories` (name, label) VALUES
	('compacts','Compacts'),
	('coupes','Coupés'),
	('sedans','Sedans'),
	('sports','Sports'),
	('sportsclassics','Sports Classics'),
	('super','Super'),
	('muscle','Muscle'),
	('offroad','Off Road'),
	('suvs','SUVs'),
	('vans','Vans'),
	('motorcycles','Motocycles')
;

CREATE TABLE `vehicles` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`model`)
);

INSERT INTO `vehicles` (name, model, price, category) VALUES
	('Blade','blade',15000,'muscle'),
	('Buccaneer','buccaneer',18000,'muscle'),
	('Buccaneer Rider','buccaneer2',24000,'muscle'),
	('Chino','chino',15000,'muscle'),
	('Chino Luxe','chino2',19000,'muscle'),
	('Coquette BlackFin','coquette3',55000,'muscle'),
	('Dominator','dominator',35000,'muscle'),
	('Dukes','dukes',28000,'muscle'),
	('Gauntlet','gauntlet',30000,'muscle'),
	('Hotknife','hotknife',125000,'muscle'),
	('Faction','faction',20000,'muscle'),
	('Faction Rider','faction2',30000,'muscle'),
	('Faction XL','faction3',40000,'muscle'),
	('Nightshade','nightshade',65000,'muscle'),
	('Phoenix','phoenix',12500,'muscle'),
	('Picador','picador',18000,'muscle'),
	('Sabre Turbo','sabregt',20000,'muscle'),
	('Sabre GT','sabregt2',25000,'muscle'),
	('Slam Van','slamvan3',11500,'muscle'),
	('Tampa','tampa',16000,'muscle'),
	('Virgo','virgo',14000,'muscle'),
	('Vigero','vigero',12500,'muscle'),
	('Voodoo','voodoo',7200,'muscle'),
	('Blista','blista',8000,'compacts'),
	('Brioso R/A','brioso',18000,'compacts'),
	('Issi','issi2',10000,'compacts'),
	('Panto','panto',10000,'compacts'),
	('Prairie','prairie',12000,'compacts'),
	('Bison','bison',45000,'vans'),
	('Bobcat XL','bobcatxl',32000,'vans'),
	('Burrito','burrito3',19000,'vans'),
	('Burrito','gburrito2',29000,'vans'),
	('Camper','camper',42000,'vans'),
	('Gang Burrito','gburrito',45000,'vans'),
	('Journey','journey',6500,'vans'),
	('Minivan','minivan',13000,'vans'),
	('Moonbeam','moonbeam',18000,'vans'),
	('Moonbeam Rider','moonbeam2',35000,'vans'),
	('Paradise','paradise',19000,'vans'),
	('Rumpo','rumpo',15000,'vans'),
	('Rumpo Trail','rumpo3',19500,'vans'),
	('Surfer','surfer',12000,'vans'),
	('Youga','youga',10800,'vans'),
	('Youga Luxuary','youga2',14500,'vans'),
	('Asea','asea',5500,'sedans'),
	('Cognoscenti','cognoscenti',55000,'sedans'),
	('Emperor','emperor',8500,'sedans'),
	('Fugitive','fugitive',12000,'sedans'),
	('Glendale','glendale',6500,'sedans'),
	('Intruder','intruder',7500,'sedans'),
	('Premier','premier',8000,'sedans'),
	('Primo Custom','primo2',14000,'sedans'),
	('Regina','regina',5000,'sedans'),
	('Schafter','schafter2',25000,'sedans'),
	('Stretch','stretch',90000,'sedans'),
	('Super Diamond','superd',130000,'sedans'),
	('Tailgater','tailgater',30000,'sedans'),
	('Warrener','warrener',4000,'sedans'),
	('Washington','washington',9000,'sedans'),
	('Baller','baller2',40000,'suvs'),
	('Baller Sport','baller3',60000,'suvs'),
	('Cavalcade','cavalcade2',55000,'suvs'),
	('Contender','contender',70000,'suvs'),
	('Dubsta','dubsta',45000,'suvs'),
	('Dubsta Luxuary','dubsta2',60000,'suvs'),
	('Fhantom','fq2',17000,'suvs'),
	('Grabger','granger',50000,'suvs'),
	('Gresley','gresley',47500,'suvs'),
	('Huntley S','huntley',40000,'suvs'),
	('Landstalker','landstalker',35000,'suvs'),
	('Mesa','mesa',16000,'suvs'),
	('Mesa Trail','mesa3',40000,'suvs'),
	('Patriot','patriot',55000,'suvs'),
	('Radius','radi',29000,'suvs'),
	('Rocoto','rocoto',45000,'suvs'),
	('Seminole','seminole',25000,'suvs'),
	('XLS','xls',32000,'suvs'),
	('Btype','btype',62000,'sportsclassics'),
	('Btype Luxe','btype3',85000,'sportsclassics'),
	('Btype Hotroad','btype2',155000,'sportsclassics'),
	('Casco','casco',30000,'sportsclassics'),
	('Coquette Classic','coquette2',40000,'sportsclassics'),
	('Manana','manana',12800,'sportsclassics'),
	('Monroe','monroe',55000,'sportsclassics'),
	('Pigalle','pigalle',20000,'sportsclassics'),
	('Stinger','stinger',80000,'sportsclassics'),
	('Stinger GT','stingergt',75000,'sportsclassics'),
	('Stirling GT','feltzer3',65000,'sportsclassics'),
	('Z-Type','ztype',220000,'sportsclassics'),
	('Bifta','bifta',12000,'offroad'),
	('Bf Injection','bfinjection',16000,'offroad'),
	('Blazer','blazer',6500,'offroad'),
	('Blazer Sport','blazer4',8500,'offroad'),
	('Brawler','brawler',45000,'offroad'),
	('Bubsta 6x6','dubsta3',120000,'offroad'),
	('Dune Buggy','dune',8000,'offroad'),
	('Guardian','guardian',45000,'offroad'),
	('Rebel','rebel2',35000,'offroad'),
	('Sandking','sandking',55000,'offroad'),
	('The Liberator','monster',210000,'offroad'),
	('Trophy Truck','trophytruck',60000,'offroad'),
	('Trophy Truck Limited','trophytruck2',80000,'offroad'),
	('Cognoscenti Cabrio','cogcabrio',55000,'coupes'),
	('Exemplar','exemplar',32000,'coupes'),
	('F620','f620',40000,'coupes'),
	('Felon','felon',42000,'coupes'),
	('Felon GT','felon2',55000,'coupes'),
	('Jackal','jackal',38000,'coupes'),
	('Oracle XS','oracle2',35000,'coupes'),
	('Sentinel','sentinel',32000,'coupes'),
	('Sentinel XS','sentinel2',40000,'coupes'),
	('Windsor','windsor',95000,'coupes'),
	('Windsor Drop','windsor2',125000,'coupes'),
	('Zion','zion',36000,'coupes'),
	('Zion Cabrio','zion2',45000,'coupes'),
	('9F','ninef',65000,'sports'),
	('9F Cabrio','ninef2',80000,'sports'),
	('Alpha','alpha',60000,'sports'),
	('Banshee','banshee',70000,'sports'),
	('Bestia GTS','bestiagts',55000,'sports'),
	('Buffalo','buffalo',12000,'sports'),
	('Buffalo S','buffalo2',20000,'sports'),
	('Carbonizzare','carbonizzare',75000,'sports'),
	('Comet','comet2',65000,'sports'),
	('Coquette','coquette',65000,'sports'),
	('Drift Tampa','tampa2',80000,'sports'),
	('Elegy','elegy2',38500,'sports'),
	('Feltzer','feltzer2',55000,'sports'),
	('Furore GT','furoregt',45000,'sports'),
	('Fusilade','fusilade',40000,'sports'),
	('Jester','jester',65000,'sports'),
	('Jester(Racecar)','jester2',135000,'sports'),
	('Khamelion','khamelion',38000,'sports'),
	('Kuruma','kuruma',30000,'sports'),
	('Lynx','lynx',40000,'sports'),
	('Mamba','mamba',70000,'sports'),
	('Massacro','massacro',65000,'sports'),
	('Massacro(Racecar)','massacro2',130000,'sports'),
	('Omnis','omnis',35000,'sports'),
	('Penumbra','penumbra',28000,'sports'),
	('Rapid GT','rapidgt',35000,'sports'),
	('Rapid GT Convertible','rapidgt2',45000,'sports'),
	('Schafter V12','schafter3',50000,'sports'),
	('Seven 70','seven70',39500,'sports'),
	('Sultan','sultan',15000,'sports'),
	('Surano','surano',50000,'sports'),
	('Tropos','tropos',40000,'sports'),
	('Verlierer','verlierer2',70000,'sports'),
	('Adder','adder',900000,'super'),
	('Banshee 900R','banshee2',255000,'super'),
	('Bullet','bullet',90000,'super'),
	('Cheetah','cheetah',375000,'super'),
	('Entity XF','entityxf',425000,'super'),
	('ETR1','sheava',220000,'super'),
	('FMJ','fmj',185000,'super'),
	('Infernus','infernus',180000,'super'),
	('Osiris','osiris',160000,'super'),
	('Pfister','pfister811',85000,'super'),
	('RE-7B','le7b',325000,'super'),
	('Reaper','reaper',150000,'super'),
	('Sultan RS','sultanrs',65000,'super'),
	('T20','t20',300000,'super'),
	('Turismo R','turismor',350000,'super'),
	('Tyrus','tyrus',600000,'super'),
	('Vacca','vacca',120000,'super'),
	('Voltic','voltic',90000,'super'),
	('X80 Proto','prototipo',2500000,'super'),
	('Zentorno','zentorno',1500000,'super'),
	('Akuma','AKUMA',7500,'motorcycles'),
	('Avarus','avarus',18000,'motorcycles'),
	('Bagger','bagger',13500,'motorcycles'),
	('Bati 801','bati',12000,'motorcycles'),
	('Bati 801RR','bati2',19000,'motorcycles'),
	('BF400','bf400',6500,'motorcycles'),
	('BMX (velo)','bmx',160,'motorcycles'),
	('Carbon RS','carbonrs',18000,'motorcycles'),
	('Chimera','chimera',38000,'motorcycles'),
	('Cliffhanger','cliffhanger',9500,'motorcycles'),
	('Cruiser (velo)','cruiser',510,'motorcycles'),
	('Daemon','daemon',11500,'motorcycles'),
	('Daemon High','daemon2',13500,'motorcycles'),
	('Defiler','defiler',9800,'motorcycles'),
	('Double T','double',28000,'motorcycles'),
	('Enduro','enduro',5500,'motorcycles'),
	('Esskey','esskey',4200,'motorcycles'),
	('Faggio','faggio',1900,'motorcycles'),
	('Vespa','faggio2',2800,'motorcycles'),
	('Fixter (velo)','fixter',225,'motorcycles'),
	('Gargoyle','gargoyle',16500,'motorcycles'),
	('Hakuchou','hakuchou',31000,'motorcycles'),
	('Hakuchou Sport','hakuchou2',55000,'motorcycles'),
	('Hexer','hexer',12000,'motorcycles'),
	('Innovation','innovation',23500,'motorcycles'),
	('Manchez','manchez',5300,'motorcycles'),
	('Nemesis','nemesis',5800,'motorcycles'),
	('Nightblade','nightblade',35000,'motorcycles'),
	('PCJ-600','pcj',6200,'motorcycles'),
	('Ruffian','ruffian',6800,'motorcycles'),
	('Sanchez','sanchez',5300,'motorcycles'),
	('Sanchez Sport','sanchez2',5300,'motorcycles'),
	('Sanctus','sanctus',25000,'motorcycles'),
	('Scorcher (velo)','scorcher',280,'motorcycles'),
	('Sovereign','sovereign',22000,'motorcycles'),
	('Shotaro Concept','shotaro',320000,'motorcycles'),
	('Thrust','thrust',24000,'motorcycles'),
	('Tri bike (velo)','tribike3',520,'motorcycles'),
	('Vader','vader',7200,'motorcycles'),
	('Vortex','vortex',9800,'motorcycles'),
	('Woflsbane','wolfsbane',9000,'motorcycles'),
	('Zombie','zombiea',9500,'motorcycles'),
	('Zombie Luxuary','zombieb',12000,'motorcycles'),
	('blazer5', 'blazer5', 1755600, 'offroad'),
	('Ruiner 2', 'ruiner2', 5745600, 'muscle'),
	('Voltic 2', 'voltic2', 3830400, 'super'),
	('Ardent', 'ardent', 1150000, 'sportsclassics'),
	('Oppressor', 'oppressor', 3524500, 'super'),
	('Visione', 'visione', 2250000, 'super'),
	('Retinue', 'retinue', 615000, 'sportsclassics'),
	('Cyclone', 'cyclone', 1890000, 'super'), 
	('Rapid GT3', 'rapidgt3', 885000, 'sportsclassics'),
	('raiden', 'raiden', 1375000, 'sports'),
	('Yosemite', 'yosemite', 485000, 'muscle'),
	('Deluxo', 'deluxo', 4721500, 'sportsclassics'),
	('Pariah', 'pariah', 1420000, 'sports'),
	('Stromberg', 'stromberg', 3185350, 'sports'),
	('SC 1', 'sc1', 1603000, 'super'),
	('riata', 'riata', 380000, 'offroad'),
	('Hermes', 'hermes', 535000, 'muscle'),
	('Savestra', 'savestra', 990000, 'sportsclassics'),
	('Streiter', 'streiter', 500000, 'sports'),
	('Kamacho', 'kamacho', 345000, 'offroad'),
	('GT 500', 'gt500', 785000, 'sportsclassics'),
	('Z190', 'z190', 900000, 'sportsclassics'),
	('Viseris', 'viseris', 875000, 'sportsclassics'),
	('Autarch', 'autarch', 1955000, 'super'),
	('Comet 5', 'comet5', 1145000, 'sports'), 
	('Neon', 'neon', 1500000, 'sports'),
	('Revolter', 'revolter', 1610000, 'sports'),
	('Sentinel3', 'sentinel3', 650000, 'sports'),
	('Hustler', 'hustler', 625000, 'muscle')
;

USE `es_extended`;

ALTER TABLE `users` ADD COLUMN `status` LONGTEXT NULL;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('police', 'Police')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('police',0,'recruit','Recruit',250,'{}','{}'),
	('police',1,'officer','Trooper',300,'{}','{}'),
	('police',2,'sr','Sr Trooper',350,'{}','{}'),
	('police',3,'corp','Corporal',450,'{}','{}'),
	('police',4,'sergeant','Sergeant',500,'{}','{}'),
	('police',5,'detective','Detective',600,'{}','{}'),
	('police',6,'lieutenant','Lieutenant',850,'{}','{}'),
	('police',7,'boss','High Command',1000,'{}','{}')
;

CREATE TABLE `fine_types` (
	`id` int NOT NULL AUTO_INCREMENT,
	`label` varchar(255) DEFAULT NULL,
	`amount` int DEFAULT NULL,
	`category` int DEFAULT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_taxi', 'Taxi', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_taxi', 'Taxi', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_taxi', 'Taxi', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('taxi', 'Taxi')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('taxi',0,'recrue','Recruit',120,'{"hair_2":0,"hair_color_2":0,"torso_1":32,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":0,"ears_2":0,"arms":27,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	('taxi',1,'novice','Driver',240,'{"hair_2":0,"hair_color_2":0,"torso_1":32,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":0,"ears_2":0,"arms":27,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	('taxi',2,'experimente','Experienced Driver',360,'{"hair_2":0,"hair_color_2":0,"torso_1":26,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":57,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":11,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	('taxi',3,'uber','Uber Driver',480,'{"hair_2":0,"hair_color_2":0,"torso_1":26,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":57,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":11,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	('taxi',4,'boss','Executive Driver',500,'{"hair_2":0,"hair_color_2":0,"torso_1":29,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":1,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":4,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}')
;

INSERT INTO `fine_types` (label, amount, category) VALUES
	('Misuse of a horn', 30, 0),
	('Illegally Crossing a continuous Line', 40, 0),
	('Driving on the wrong side of the road', 250, 0),
	('Illegal U-Turn', 250, 0),
	('Illegally Driving Off-road', 170, 0),
	('Refusing a Lawful Command', 180, 0),
	('Illegally Stopping a Vehicle', 150, 0),
	('Illegal Parking', 70, 0),
	('Failing to Yield to the right', 70, 0),
	('Failure to comply with Vehicle Information', 90, 0),
	('Failing to stop at a Stop Sign ', 130, 0),
	('Failing to stop at a Red Light', 130, 0),
	('Illegal Passing', 100, 0),
	('Driving an illegal Vehicle', 150, 0),
	('Driving without a License', 500, 0),
	('Hit and Run', 800, 0),
	('Exceeding Speeds Over < 5 mph', 90, 0),
	('Exceeding Speeds Over 5-15 mph', 120, 0),
	('Exceeding Speeds Over 15-30 mph', 380, 0),
	('Exceeding Speeds Over > 30 mph', 600, 0),
	('Impeding traffic flow', 110, 1),
	('Public Intoxication', 90, 1),
	('Disorderly conduct', 90, 1),
	('Obstruction of Justice', 130, 1),
	('Insults towards Civilans', 75, 1),
	('Disrespecting of an LEO', 110, 1),
	('Verbal Threat towards a Civilan', 90, 1),
	('Verbal Threat towards an LEO', 150, 1),
	('Providing False Information', 250, 1),
	('Attempt of Corruption', 1500, 1),
	('Brandishing a weapon in city Limits', 200, 2),
	('Brandishing a Lethal Weapon in city Limits', 600, 2),
	('No Firearms License', 600, 2),
	('Possession of an Illegal Weapon', 1700, 2),
	('Possession of Burglary Tools', 300, 2),
	('Grand Theft Auto', 2800, 2),
	('Intent to Sell/Distrube of an illegal Substance', 2500, 2),
	('Frabrication of an Illegal Substance', 3500, 2),
	('Possession of an Illegal Substance ', 650, 2),
	('Kidnapping of a Civilan', 5500, 2),
	('Kidnapping of an LEO', 10000, 2),
	('Robbery', 650, 2),
	('Armed Robbery of a Store', 850, 2),
	('Armed Robbery of a Bank', 1500, 2),
	('Assault on a Civilian', 2500, 3),
	('Assault of an LEO', 3500, 3),
	('Attempt of Murder of a Civilian', 5000, 3),
	('Attempt of Murder of an LEO', 10000, 3),
	('Murder of a Civilian', 10000, 3),
	('Murder of an LEO', 30000, 3),
	('Involuntary manslaughter', 2800, 3),
	('Fraud', 2000, 2);

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mechanic', 'Mechanic', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mechanic', 'Mechanic', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('mechanic', 'Mechanic')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mechanic',0,'recrue','Recruit',130,'{}','{}'),
	('mechanic',1,'novice','Novice',245,'{}','{}'),
	('mechanic',2,'experimente','Experienced',369,'{}','{}'),
	('mechanic',3,'chief',"Chief Mechanic",488,'{}','{}'),
	('mechanic',4,'boss','Shop Owner',500,'{}','{}')
;

INSERT INTO `items` (name, label, weight) VALUES
	('gazbottle', 'Can of Gas', 2),
	('fixtool', 'Repair Tools', 2),
	('carotool', 'Body work tools', 2),
	('blowpipe', 'Torches', 2),
	('fixkit', 'Repair Kit', 3),
	('carokit', 'Carbody kit', 3)
;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('dmv', 'Driving Permit'),
	('drive', 'Drivers License'),
	('drive_bike', 'Motorcycle License'),
	('drive_truck', 'Commercial Drivers License')
;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_ambulance', 'Ambulance', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_ambulance', 'Ambulance', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_ambulance', 'Ambulance', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('ambulance',0,'ambulance','EMT',200,'{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
	('ambulance',1,'doctor','Doctor',400,'{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
	('ambulance',2,'chief_doctor','Senior Doctor',600,'{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
	('ambulance',3,'boss','Head Doctor',800,'{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}')
;

INSERT INTO `jobs` (name, label) VALUES
	('ambulance','Ambulance')
;

INSERT INTO `items` (name, label, weight) VALUES
	('bandage','Bandage', 2),
	('medikit','Medikit', 2)
;

ALTER TABLE `users`
	ADD `is_dead` TINYINT(1) NULL DEFAULT '0'
;

CREATE TABLE IF NOT EXISTS `owned_vehicles` (
	`owner` varchar(40) NOT NULL,
	`plate` varchar(12) NOT NULL,
	`vehicle` longtext,
	`type` varchar(20) NOT NULL DEFAULT 'car',
	`job` varchar(20) NOT NULL DEFAULT 'civ',
	`stored` tinyint(1) NOT NULL DEFAULT '0',
	
	PRIMARY KEY (`plate`)
);

DROP TABLE IF EXISTS `owned_vehicles`;
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `vehicle` longtext NOT NULL,
  `owner` varchar(60) NOT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'State of the vehicle',
  `garage_name` varchar(50) NOT NULL DEFAULT 'Garage_Centre',
  `pound` tinyint(1) NOT NULL DEFAULT '0',
  `vehiclename` varchar(50),
  `plate` varchar(50) NOT NULL,
  `type` varchar(10) NOT NULL DEFAULT 'car',
  `job` varchar(50),
  PRIMARY KEY (`plate`),
  KEY `vehsowned` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
COMMIT;

ALTER TABLE `owned_vehicles` ADD `state` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'State of the vehicle' AFTER `owner`;

ALTER TABLE `users` ADD COLUMN `skin` LONGTEXT DEFAULT NULL;
