# encoding: utf-8
# Autogenerated by the db:seed:dump task
# Do not hesitate to tweak this to your needs

Course.create([
  { :tournament_id => 1, :name => "Augusta National Golf Club", :created_at => "2013-04-20 17:49:26", :updated_at => "2013-04-20 17:49:26" }
], :without_protection => true )



Golfpick.create([
  { :user_id => 1, :pick1 => 4, :pick2 => 5, :pick3 => 6, :pick4 => 7, :pick5 => 8, :q1 => true, :q2 => true, :q3 => true, :q4 => true, :q5 => true, :tiebreak => -5, :created_at => "2013-04-20 21:36:06", :updated_at => "2013-04-25 04:49:59", :pool_id => 1, :score => -7, :bonus => -3 },
  { :user_id => 2, :pick1 => 4, :pick2 => 8, :pick3 => 7, :pick4 => 5, :pick5 => 6, :q1 => true, :q2 => true, :q3 => true, :q4 => true, :q5 => true, :tiebreak => -3, :created_at => "2013-04-24 01:24:01", :updated_at => "2013-04-25 04:49:59", :pool_id => 1, :score => -7, :bonus => -3 }
], :without_protection => true )



Group.create([
  { :name => "Blackrock", :created_at => "2013-04-17 04:09:13", :updated_at => "2013-04-20 03:00:50", :slug => "blackrock" },
  { :name => "NBR", :created_at => "2013-04-20 02:51:06", :updated_at => "2013-04-20 03:01:23", :slug => "nbr" }
], :without_protection => true )



GroupAdmin.create([
  { :group_id => 1, :user_id => 1, :created_at => "2013-04-26 02:11:33", :updated_at => "2013-04-26 02:11:33" }
], :without_protection => true )



Hole.create([
  { :course_id => 1, :hole_number => 7, :created_at => "2013-04-20 17:55:11", :updated_at => "2013-04-20 18:13:21", :par => 4 },
  { :course_id => 1, :hole_number => 11, :created_at => "2013-04-20 17:55:31", :updated_at => "2013-04-20 18:13:21", :par => 4 },
  { :course_id => 1, :hole_number => 15, :created_at => "2013-04-20 17:55:53", :updated_at => "2013-04-20 18:13:21", :par => 5 },
  { :course_id => 1, :hole_number => 2, :created_at => "2013-04-20 17:53:18", :updated_at => "2013-04-20 18:13:21", :par => 5 },
  { :course_id => 1, :hole_number => 6, :created_at => "2013-04-20 17:55:02", :updated_at => "2013-04-20 18:13:21", :par => 3 },
  { :course_id => 1, :hole_number => 14, :created_at => "2013-04-20 17:55:49", :updated_at => "2013-04-20 18:13:21", :par => 4 },
  { :course_id => 1, :hole_number => 4, :created_at => "2013-04-20 17:53:50", :updated_at => "2013-04-20 18:13:21", :par => 3 },
  { :course_id => 1, :hole_number => 3, :created_at => "2013-04-20 17:53:45", :updated_at => "2013-04-20 18:13:21", :par => 4 },
  { :course_id => 1, :hole_number => 8, :created_at => "2013-04-20 17:55:17", :updated_at => "2013-04-20 18:13:21", :par => 5 },
  { :course_id => 1, :hole_number => 9, :created_at => "2013-04-20 17:55:22", :updated_at => "2013-04-20 18:13:21", :par => 4 },
  { :course_id => 1, :hole_number => 17, :created_at => "2013-04-20 17:56:05", :updated_at => "2013-04-20 18:13:21", :par => 4 },
  { :course_id => 1, :hole_number => 10, :created_at => "2013-04-20 17:55:28", :updated_at => "2013-04-20 18:13:21", :par => 4 },
  { :course_id => 1, :hole_number => 12, :created_at => "2013-04-20 17:55:35", :updated_at => "2013-04-20 18:13:21", :par => 3 },
  { :course_id => 1, :hole_number => 5, :created_at => "2013-04-20 17:53:55", :updated_at => "2013-04-20 18:13:21", :par => 4 },
  { :course_id => 1, :hole_number => 1, :created_at => "2013-04-20 17:52:48", :updated_at => "2013-04-20 18:13:21", :par => 4 },
  { :course_id => 1, :hole_number => 16, :created_at => "2013-04-20 17:56:00", :updated_at => "2013-04-20 18:13:21", :par => 3 },
  { :course_id => 1, :hole_number => 13, :created_at => "2013-04-20 17:55:43", :updated_at => "2013-04-20 18:13:21", :par => 5 },
  { :course_id => 1, :hole_number => 18, :created_at => "2013-04-20 17:56:08", :updated_at => "2013-04-20 18:15:13", :par => 4 }
], :without_protection => true )



Options.create([
  { :key => nil, :value => nil, :created_at => nil, :updated_at => nil }
], :without_protection => true )



Player.create([
  { :name => "Tiger Woods", :created_at => "2013-04-20 13:54:08", :updated_at => "2013-04-24 04:52:28", :ranking => 1, :slug => "tiger-woods" },
  { :name => "Rory McIlory", :created_at => "2013-04-20 13:54:13", :updated_at => "2013-04-24 04:52:43", :ranking => 2, :slug => "rory-mcilroy" },
  { :name => "Adam Scott", :created_at => "2013-04-20 13:54:18", :updated_at => "2013-04-24 04:52:58", :ranking => 3, :slug => "adam-scott" },
  { :name => "Charl Schwartzel", :created_at => "2013-04-20 13:55:27", :updated_at => "2013-04-24 04:53:13", :ranking => 4, :slug => "charl-schwartzel" },
  { :name => "Isaac Wittman", :created_at => "2013-04-20 13:55:41", :updated_at => "2013-04-24 04:53:25", :ranking => 5, :slug => "isaac-wittman" }
], :without_protection => true )



PlayerPremium.create([
  { :pool_id => nil, :player_id => nil, :premium => nil, :created_at => nil, :updated_at => nil }
], :without_protection => true )



PlayerScoreStatus.create([
  { :player_id => 4, :tournament_id => 1, :score => -1, :created_at => "2013-04-24 02:24:29", :updated_at => "2013-04-24 02:24:29" },
  { :player_id => 5, :tournament_id => 1, :score => -1, :created_at => "2013-04-24 02:32:40", :updated_at => "2013-04-24 02:32:40" },
  { :player_id => 7, :tournament_id => 1, :score => 0, :created_at => "2013-04-24 02:32:40", :updated_at => "2013-04-24 02:32:40" },
  { :player_id => 8, :tournament_id => 1, :score => 0, :created_at => "2013-04-24 02:32:40", :updated_at => "2013-04-24 02:32:40" },
  { :player_id => 6, :tournament_id => 1, :score => 0, :created_at => "2013-04-24 02:32:40", :updated_at => "2013-04-24 02:32:40" }
], :without_protection => true )



Pool.create([
  { :created_at => "2013-04-17 04:25:35", :updated_at => "2013-04-20 03:07:23", :group_id => 1, :tournament_id => 1, :min_units => nil }
], :without_protection => true )



QAnswer.create([
  { :pool_id => 1, :answer => true, :created_at => "2013-04-24 23:37:15", :updated_at => "2013-04-25 01:38:56", :question => "Will 14 year old Tianlang Guan (youngest ever to compete in Masters) finish ahead of 64 year-old Tom Watson?", :number => 3 },
  { :pool_id => 1, :answer => true, :created_at => "2013-04-24 23:35:39", :updated_at => "2013-04-25 04:49:18", :question => "Will Tiger have more birdies/eagles than Rory?", :number => 1 },
  { :pool_id => 1, :answer => false, :created_at => "2013-04-24 23:36:33", :updated_at => "2013-04-25 04:49:42", :question => "This year has the biggest Irish contingent (Rory, McDowell, Harrington, Clarke, and Dunbar). Will three or more make the cut?", :number => 2 },
  { :pool_id => 1, :answer => false, :created_at => "2013-04-24 23:37:50", :updated_at => "2013-04-25 04:49:46", :question => "Will 3 or more of the \"Ex-Champs\" (in Group 5) make the cut?", :number => 4 },
  { :pool_id => 1, :answer => false, :created_at => "2013-04-24 23:38:35", :updated_at => "2013-04-25 04:50:34", :question => "Will we have a choker - someone leading by 2 or more strokes on their back 9 of the final round", :number => 5 }
], :without_protection => true )



Score.create([
  { :tournament_id => 1, :player_id => 4, :strokes => 5, :created_at => "2013-04-20 18:34:23", :updated_at => "2013-04-20 19:51:12", :hole_id => 2, :round => 1 },
  { :tournament_id => 1, :player_id => 5, :strokes => 4, :created_at => "2013-04-20 18:57:37", :updated_at => "2013-04-20 19:51:12", :hole_id => 1, :round => 1 },
  { :tournament_id => 1, :player_id => 5, :strokes => 4, :created_at => "2013-04-20 18:58:27", :updated_at => "2013-04-20 19:51:12", :hole_id => 2, :round => 1 },
  { :tournament_id => 1, :player_id => 4, :strokes => 6, :created_at => "2013-04-20 18:19:21", :updated_at => "2013-04-20 20:02:17", :hole_id => 1, :round => 1 },
  { :tournament_id => 1, :player_id => 4, :strokes => 1, :created_at => "2013-04-20 20:17:15", :updated_at => "2013-04-20 20:17:15", :hole_id => 3, :round => 1 }
], :without_protection => true )



Tournament.create([
  { :name => "Masters 2013", :location => "Augusta, Georgia", :created_at => "2013-04-17 03:25:56", :updated_at => "2013-04-25 02:24:25", :starttime => "2013-04-18 03:53:56", :endtime => "2013-04-28 23:21:54", :slug => "masters-2013", :round => 1, :low_score => nil }
], :without_protection => true )



Tplayer.create([
  { :player_id => 4, :tournament_id => 1, :bucket => 1, :created_at => "2013-04-20 17:43:42", :updated_at => "2013-04-20 17:43:42" },
  { :player_id => 5, :tournament_id => 1, :bucket => 2, :created_at => "2013-04-20 17:43:42", :updated_at => "2013-04-20 17:43:42" },
  { :player_id => 6, :tournament_id => 1, :bucket => 3, :created_at => "2013-04-20 17:43:42", :updated_at => "2013-04-20 17:43:42" },
  { :player_id => 7, :tournament_id => 1, :bucket => 4, :created_at => "2013-04-20 17:43:42", :updated_at => "2013-04-20 17:43:42" },
  { :player_id => 8, :tournament_id => 1, :bucket => 5, :created_at => "2013-04-20 17:43:42", :updated_at => "2013-04-20 17:43:42" }
], :without_protection => true )



User.create([
  { :name => "Andy Guenin", :email => "andyguenin@gmail.com", :password_hash => "$2a$10$WH0I4LpwQmovQN6I/xCC3u/fykC1zEitIClkXb3CdCSl/cCJ.N9Am", :password_salt => "$2a$10$WH0I4LpwQmovQN6I/xCC3u", :created_at => "2013-04-17 04:11:09", :updated_at => "2013-04-26 02:20:28", :admin => true, :role => 10 },
  { :name => "aaaaa", :email => "a@b.com", :password_hash => "$2a$10$xLmzPaQMSBT2T1QTjjCiUe3/1/3a79.CEDNWl5TOT9v50z72GeyWy", :password_salt => "$2a$10$xLmzPaQMSBT2T1QTjjCiUe", :created_at => "2013-04-21 00:56:37", :updated_at => "2013-04-21 03:10:15", :admin => nil, :role => nil }
], :without_protection => true )



UserGroupMember.create([
  { :user_id => 1, :group_id => 1, :created_at => "2013-04-20 02:54:23", :updated_at => "2013-04-20 02:54:23" },
  { :user_id => 2, :group_id => 1, :created_at => "2013-04-24 01:22:59", :updated_at => "2013-04-24 01:22:59" }
], :without_protection => true )


