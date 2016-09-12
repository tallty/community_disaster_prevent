# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(email: '1234567890@qq.com', password: '1234567890')

Diymenu.delete_all
Diymenu.create(id: 1, name: '预报服务', is_show: true, sort: 0)
Diymenu.create(id: 2, name: '我的社区', is_show: true, sort: 1)
Diymenu.create(id: 3, name: '帮助', is_show: true, sort:2)
Diymenu.create(id: 4, parent_id: 1, name: '全市预警', url: 'http://weixin.lightning.sh.cn/forecast_services/city_warn', is_show: true, sort:0)
Diymenu.create(id: 5, parent_id: 1, name: '五日预报', url: 'http://weixin.lightning.sh.cn/forecast_services/locate', is_show: true, sort:1)
Diymenu.create(id: 6, parent_id: 1, name: '气象指数', url: 'http://weixin.lightning.sh.cn/forecast_services/life_index', is_show: true, sort:2)
Diymenu.create(id: 7, parent_id: 1, name: '空气质量', url: 'http://weixin.lightning.sh.cn/forecast_services/air_quality', is_show: true, sort:3)
Diymenu.create(id: 8, parent_id: 1, name: '健康气象', url: 'http://weixin.lightning.sh.cn/forecast_services/healthy_weather', is_show: true, sort:4)

# Diymenu.create(id: 9, parent_id: 2, name: '灾情互动', url: 'http://weixin.lightning.sh.cn/communities/interact', is_show: true, sort:0)
Diymenu.create(id: 9, parent_id: 2, name: '灾情互动', url: 'http://weixin.lightning.sh.cn/oauths?reurl=http://weixin.lightning.sh.cn/communities/interact', is_show: true, sort:0)
Diymenu.create(id: 10, parent_id: 2, name: '社区实况', url: 'http://weixin.lightning.sh.cn/oauths?reurl=http://weixin.lightning.sh.cn/communities/detection', is_show: true, sort:1)
Diymenu.create(id: 12, parent_id: 3, name: '调查问卷', key: '调查问卷', is_show: true, sort:0)
Diymenu.create(id: 13, parent_id: 3, name: '气象科普', key: '气象科普', is_show: true, sort:1)
Diymenu.create(id: 14, parent_id: 3, name: '微社区', url: 'http://wsq.qq.com/reflow/234704148', is_show: true, sort:2)
Diymenu.create(id: 15, parent_id: 3, name: '帮助', key: '帮助', is_show: true, sort:3)

MessageProcessor.delete_all
MessageProcessor.create(event_key: "全市预警", process_class_name: "Warning", process_method: "get_show_article", result_type: "news_message")
MessageProcessor.create(event_key: "五日预报", process_class_name: "FiveDayWeather", process_method: "get_message", result_type: "text_message")
MessageProcessor.create(event_key: "气象指数", process_class_name: "WeatherIndex", process_method: "get_message", result_type: "text_message")
MessageProcessor.create(event_key: "空气质量", process_class_name: "AQI", process_method: "get_show_article", result_type: "news_message")
MessageProcessor.create(event_key: "健康气象", process_class_name: "Healthy", process_method: "get_message", result_type: "text_message")
MessageProcessor.create(event_key: "社区预警", process_class_name: "Warning", process_method: "get_show_article", result_type: "news_message")
MessageProcessor.create(event_key: "灾情互动", message_type: "dynamic", process_class_name: "Article", process_method: "get_show_article", result_type: "news_message")
MessageProcessor.create(event_key: "社区实况", process_class_name: "MonitorStation", process_method: "get_show_article", result_type: "news_message")
# MessageProcessor.create(event_key: "社区风险", message_type: "dynamic", process_class_name: "Article", process_method: "get_show_article", result_type: "news_message")
MessageProcessor.create(event_key: "调查问卷", process_class_name: "Article", process_method: "get_show_article", result_type: "news_message")
MessageProcessor.create(event_key: "气象科普", message_type: "dynamic", process_class_name: "Article", process_method: "get_show_article", result_type: "news_message")
MessageProcessor.create(event_key: "帮助", message_type: "dynamic", process_class_name: "Article", process_method: "get_show_article", result_type: "news_message")

Article.create(title: "社区绑定", author: "系统", content: "abc", thumb_media_url: "assets/community2.png")
Article.create(title: "灾情互动", author: "系统", content: "abc", digest: "您想及时与大家分享您身边的气象灾情吗?可加入社区气象志愿者队伍,上传灾情照片与描述,就可以为社区气象安全尽一份力哦~", thumb_media_url: "assets/community2.png")

Community.delete_all
Community.create(id: 1, code: 20000, district: "上海", street: "上海", c_type: "普通")
Community.create(id: 2, code: 20100, district: "杨浦", street: "五角场", c_type: "普通")
Community.create(id: 3, code: 20101, district: "杨浦", street: "新江湾城", c_type: "普通")
Community.create(id: 4, code: 20102, district: "杨浦", street: "江浦路街道", c_type: "普通")
Community.create(id: 5, code: 20103, district: "杨浦", street: "四平路街道", c_type: "普通")
Community.create(id: 7, code: 20104, district: "杨浦", street: "延吉新村街道", c_type: "普通")
Community.create(id: 8, code: 20105, district: "杨浦", street: "殷行街道", c_type: "普通")
Community.create(id: 9, code: 20106, district: "杨浦", street: "定海路街道", c_type: "普通")
Community.create(id: 10, code: 20107, district: "杨浦", street: "大桥街道", c_type: "普通")
Community.create(id: 11, code: 20108, district: "杨浦", street: "平凉路街道", c_type: "普通")
Community.create(id: 12, code: 20101, district: "杨浦", street: "长白新村街道", c_type: "普通")
Community.create(id: 13, code: 20110, district: "杨浦", street: "控江路街道", c_type: "普通")
Community.create(id: 14, code: 20200, district: "黄浦", street: "南京东路街道", c_type: "普通")
Community.create(id: 15, code: 20201, district: "黄浦", street: "外滩街道", c_type: "普通")
Community.create(id: 16, code: 20203, district: "黄浦", street: "老西门街道", c_type: "普通")
Community.create(id: 17, code: 20204, district: "黄浦", street: "半淞园街道", c_type: "普通")
Community.create(id: 18, code: 20205, district: "黄浦", street: "小东门街道", c_type: "普通")
Community.create(id: 19, code: 20206, district: "黄浦", street: "豫园街道", c_type: "普通")
Community.create(id: 20, code: 20207, district: "黄浦", street: "打浦桥街道", c_type: "普通")
Community.create(id: 21, code: 20208, district: "黄浦", street: "淮海中路街道", c_type: "普通")
Community.create(id: 22, code: 20209, district: "黄浦", street: "瑞金二路街道", c_type: "普通")
Community.create(id: 23, code: 20210, district: "黄浦", street: "五里桥街道", c_type: "普通")
Community.create(id: 24, code: 20300, district: "徐汇", street: "天平路街道", c_type: "普通")
Community.create(id: 25, code: 20301, district: "徐汇", street: "湖南路街道", c_type: "普通")
Community.create(id: 26, code: 20302, district: "徐汇", street: "斜土路街道", c_type: "普通")
Community.create(id: 27, code: 20303, district: "徐汇", street: "枫林路街道", c_type: "普通")
Community.create(id: 28, code: 20304, district: "徐汇", street: "长桥街道", c_type: "普通")
Community.create(id: 29, code: 20305, district: "徐汇", street: "田林街道", c_type: "普通")
Community.create(id: 30, code: 20306, district: "徐汇", street: "虹梅路街道", c_type: "普通")
Community.create(id: 31, code: 20307, district: "徐汇", street: "康健新村街道", c_type: "普通")
Community.create(id: 32, code: 20308, district: "徐汇", street: "徐家汇路街道", c_type: "普通")
Community.create(id: 33, code: 20309, district: "徐汇", street: "龙华街道", c_type: "普通")
Community.create(id: 34, code: 20310, district: "徐汇", street: "漕河泾街道", c_type: "普通")
Community.create(id: 35, code: 20311, district: "徐汇", street: "华泾镇", c_type: "普通")
Community.create(id: 36, code: 20312, district: "徐汇", street: "凌云路街道", c_type: "普通")
Community.create(id: 37, code: 20400, district: "长宁", street: "华阳路街道", c_type: "普通")
Community.create(id: 38, code: 20401, district: "长宁", street: "江苏路街道", c_type: "普通")
Community.create(id: 39, code: 20402, district: "长宁", street: "天山路街道", c_type: "普通")
Community.create(id: 40, code: 20403, district: "长宁", street: "周家桥街道", c_type: "普通")
Community.create(id: 41, code: 20404, district: "长宁", street: "新华路街道", c_type: "普通")
Community.create(id: 42, code: 20405, district: "长宁", street: "仙霞新村街道", c_type: "普通")
Community.create(id: 43, code: 20406, district: "长宁", street: "虹桥街道", c_type: "普通")
Community.create(id: 44, code: 20407, district: "长宁", street: "程家桥街道", c_type: "普通")
Community.create(id: 45, code: 20408, district: "长宁", street: "北新泾街道", c_type: "普通")
Community.create(id: 46, code: 20409, district: "长宁", street: "新泾镇", c_type: "普通")
Community.create(id: 47, code: 20500, district: "静安", street: "曹家渡街道", c_type: "普通")
Community.create(id: 48, code: 20501, district: "静安", street: "江宁路街道", c_type: "普通")
Community.create(id: 49, code: 20502, district: "静安", street: "静安寺街道", c_type: "普通")
Community.create(id: 50, code: 20503, district: "静安", street: "南京西路街道", c_type: "普通")
Community.create(id: 51, code: 20504, district: "静安", street: "石门二路街道", c_type: "普通")
Community.create(id: 52, code: 20600, district: "普陀", street: "长寿路街道", c_type: "普通")
Community.create(id: 53, code: 20601, district: "普陀", street: "石泉路街道", c_type: "普通")
Community.create(id: 54, code: 20602, district: "普陀", street: "曹杨新村街道", c_type: "普通")
Community.create(id: 55, code: 20603, district: "普陀", street: "长风新村街道", c_type: "普通")
Community.create(id: 56, code: 20604, district: "普陀", street: "宜川路街道", c_type: "普通")
Community.create(id: 57, code: 20605, district: "普陀", street: "甘泉路街道", c_type: "普通")
Community.create(id: 58, code: 20606, district: "普陀", street: "桃浦镇", c_type: "普通")
Community.create(id: 59, code: 20607, district: "普陀", street: "长征镇", c_type: "普通")
Community.create(id: 60, code: 20608, district: "普陀", street: "真如镇", c_type: "普通")
Community.create(id: 61, code: 20700, district: "闸北", street: "北站街道", c_type: "普通")
Community.create(id: 62, code: 20701, district: "闸北", street: "临汾路街道", c_type: "普通")
Community.create(id: 63, code: 20702, district: "闸北", street: "彭浦新村街道", c_type: "普通")
Community.create(id: 64, code: 20703, district: "闸北", street: "天目西路街道", c_type: "普通")
Community.create(id: 65, code: 20704, district: "闸北", street: "宝山路街道", c_type: "普通")
Community.create(id: 66, code: 20705, district: "闸北", street: "芷江西路街道", c_type: "普通")
Community.create(id: 67, code: 20706, district: "闸北", street: "共和新路街道", c_type: "普通")
Community.create(id: 68, code: 20707, district: "闸北", street: "大宁路街道", c_type: "普通")
Community.create(id: 69, code: 20708, district: "闸北", street: "彭浦镇", c_type: "普通")
Community.create(id: 70, code: 20800, district: "虹口", street: "曲阳路街道", c_type: "普通")
Community.create(id: 71, code: 20801, district: "虹口", street: "欧阳路街道", c_type: "普通")
Community.create(id: 72, code: 20802, district: "虹口", street: "提篮桥街道", c_type: "普通")
Community.create(id: 73, code: 20803, district: "虹口", street: "嘉兴路街道", c_type: "普通")
Community.create(id: 74, code: 20804, district: "虹口", street: "广中路街道", c_type: "普通")
Community.create(id: 75, code: 20805, district: "虹口", street: "江湾镇街道", c_type: "普通")
Community.create(id: 76, code: 20806, district: "虹口", street: "凉城新村街道", c_type: "普通")
Community.create(id: 77, code: 20807, district: "虹口", street: "四川北路街道", c_type: "普通")
Community.create(id: 78, code: 20900, district: "闵行", street: "江川路街道", c_type: "普通")
Community.create(id: 79, code: 20901, district: "闵行", street: "古美路街道", c_type: "普通")
Community.create(id: 80, code: 20902, district: "闵行", street: "吴泾镇", c_type: "普通")
Community.create(id: 81, code: 20903, district: "闵行", street: "梅陇镇", c_type: "普通")
Community.create(id: 82, code: 20904, district: "闵行", street: "莘庄镇", c_type: "普通")
Community.create(id: 83, code: 20905, district: "闵行", street: "华漕镇", c_type: "普通")
Community.create(id: 84, code: 20906, district: "闵行", street: "虹桥镇", c_type: "普通")
Community.create(id: 85, code: 20907, district: "闵行", street: "七宝镇", c_type: "普通")
Community.create(id: 86, code: 20908, district: "闵行", street: "颛桥镇", c_type: "普通")
Community.create(id: 87, code: 20909, district: "闵行", street: "新虹街道", c_type: "普通")
Community.create(id: 88, code: 20910, district: "闵行", street: "莘庄工业区", c_type: "普通")
Community.create(id: 89, code: 20911, district: "闵行", street: "马桥镇", c_type: "普通")
Community.create(id: 90, code: 20912, district: "闵行", street: "浦江镇", c_type: "普通")
Community.create(id: 91, code: 21000, district: "宝山", street: "吴淞街道", c_type: "普通")
Community.create(id: 92, code: 21001, district: "宝山", street: "张庙街道", c_type: "普通")
Community.create(id: 93, code: 21002, district: "宝山", street: "友谊路街道", c_type: "普通")
Community.create(id: 94, code: 21003, district: "宝山", street: "月浦镇", c_type: "普通")
Community.create(id: 95, code: 21004, district: "宝山", street: "大场镇", c_type: "普通")
Community.create(id: 96, code: 21005, district: "宝山", street: "罗店镇", c_type: "普通")
Community.create(id: 97, code: 21006, district: "宝山", street: "杨行镇", c_type: "普通")
Community.create(id: 98, code: 21007, district: "宝山", street: "罗泾镇", c_type: "普通")
Community.create(id: 99, code: 21008, district: "宝山", street: "顾村镇", c_type: "普通")
Community.create(id: 100, code: 21009, district: "宝山", street: "高境镇", c_type: "普通")
Community.create(id: 101, code: 21010, district: "宝山", street: "庙行镇", c_type: "普通")
Community.create(id: 102, code: 21011, district: "宝山", street: "淞南镇", c_type: "普通")
Community.create(id: 103, code: 21100, district: "嘉定", street: "嘉定工业区", c_type: "普通")
Community.create(id: 104, code: 21101, district: "嘉定", street: "嘉定镇", c_type: "普通")
Community.create(id: 105, code: 21102, district: "嘉定", street: "江桥镇", c_type: "普通")
Community.create(id: 106, code: 21103, district: "嘉定", street: "安亭镇", c_type: "普通")
Community.create(id: 107, code: 21104, district: "嘉定", street: "真新街道", c_type: "普通")
Community.create(id: 108, code: 21105, district: "嘉定", street: "外冈镇", c_type: "普通")
Community.create(id: 109, code: 21106, district: "嘉定", street: "华亭镇", c_type: "普通")
Community.create(id: 110, code: 21107, district: "嘉定", street: "徐行镇", c_type: "普通")
Community.create(id: 111, code: 21108, district: "嘉定", street: "黄渡镇", c_type: "普通")
Community.create(id: 112, code: 21109, district: "嘉定", street: "菊园新区", c_type: "普通")
Community.create(id: 113, code: 21110, district: "嘉定", street: "马陆镇", c_type: "普通")
Community.create(id: 114, code: 21111, district: "嘉定", street: "南翔镇", c_type: "普通")
Community.create(id: 115, code: 21112, district: "嘉定", street: "新城路街道", c_type: "普通")
Community.create(id: 116, code: 21200, district: "浦东新区", street: "沪东新村街道", c_type: "普通")
Community.create(id: 117, code: 21201, district: "浦东新区", street: "金杨新村街道", c_type: "普通")
Community.create(id: 118, code: 21202, district: "浦东新区", street: "陆家嘴街道", c_type: "普通")
Community.create(id: 119, code: 21203, district: "浦东新区", street: "南码头街道", c_type: "普通")
Community.create(id: 120, code: 21204, district: "浦东新区", street: "上钢新村街道", c_type: "普通")
Community.create(id: 121, code: 21205, district: "浦东新区", street: "塘桥街道", c_type: "普通")
Community.create(id: 122, code: 21206, district: "浦东新区", street: "潍坊新村街道", c_type: "普通")
Community.create(id: 123, code: 21207, district: "浦东新区", street: "洋泾街道", c_type: "普通")
Community.create(id: 124, code: 21208, district: "浦东新区", street: "周家渡街道", c_type: "普通")
Community.create(id: 125, code: 21209, district: "浦东新区", street: "浦兴路街道", c_type: "普通")
Community.create(id: 126, code: 21210, district: "浦东新区", street: "东明街道", c_type: "普通")
Community.create(id: 127, code: 21211, district: "浦东新区", street: "花木街道", c_type: "普通")
Community.create(id: 128, code: 21212, district: "浦东新区", street: "三林镇", c_type: "普通")
Community.create(id: 129, code: 21213, district: "浦东新区", street: "川沙新镇", c_type: "普通")
Community.create(id: 130, code: 21214, district: "浦东新区", street: "高桥镇", c_type: "普通")
Community.create(id: 131, code: 21215, district: "浦东新区", street: "北蔡镇", c_type: "普通")
Community.create(id: 132, code: 21216, district: "浦东新区", street: "张江镇", c_type: "普通")
Community.create(id: 133, code: 21217, district: "浦东新区", street: "曹路镇", c_type: "普通")
Community.create(id: 134, code: 21218, district: "浦东新区", street: "唐镇", c_type: "普通")
Community.create(id: 135, code: 21219, district: "浦东新区", street: "合庆镇", c_type: "普通")
Community.create(id: 136, code: 21220, district: "浦东新区", street: "金桥镇", c_type: "普通")
Community.create(id: 137, code: 21221, district: "浦东新区", street: "高东镇", c_type: "普通")
Community.create(id: 138, code: 21222, district: "浦东新区", street: "高行镇", c_type: "普通")
Community.create(id: 139, code: 21223, district: "浦东新区", street: "惠南镇", c_type: "普通")
Community.create(id: 140, code: 21224, district: "浦东新区", street: "周浦镇", c_type: "普通")
Community.create(id: 141, code: 21225, district: "浦东新区", street: "新场镇", c_type: "普通")
Community.create(id: 142, code: 21226, district: "浦东新区", street: "大团镇", c_type: "普通")
Community.create(id: 143, code: 21227, district: "浦东新区", street: "芦潮港镇", c_type: "普通")
Community.create(id: 144, code: 21228, district: "浦东新区", street: "康桥镇", c_type: "普通")
Community.create(id: 145, code: 21229, district: "浦东新区", street: "航头镇", c_type: "普通")
Community.create(id: 146, code: 21230, district: "浦东新区", street: "六灶镇", c_type: "普通")
Community.create(id: 147, code: 21231, district: "浦东新区", street: "祝桥镇", c_type: "普通")
Community.create(id: 148, code: 21232, district: "浦东新区", street: "泥城镇", c_type: "普通")
Community.create(id: 149, code: 21233, district: "浦东新区", street: "宣桥镇", c_type: "普通")
Community.create(id: 150, code: 21234, district: "浦东新区", street: "书院镇", c_type: "普通")
Community.create(id: 151, code: 21235, district: "浦东新区", street: "万祥镇镇", c_type: "普通")
Community.create(id: 152, code: 21236, district: "浦东新区", street: "老港镇", c_type: "普通")
Community.create(id: 153, code: 21237, district: "浦东新区", street: "芦潮港农场", c_type: "普通")
Community.create(id: 154, code: 21238, district: "浦东新区", street: "东海农场", c_type: "普通")
Community.create(id: 155, code: 21239, district: "浦东新区", street: "朝阳农场", c_type: "普通")
Community.create(id: 156, code: 21240, district: "浦东新区", street: "申港街道", c_type: "普通")
Community.create(id: 157, code: 21241, district: "浦东新区", street: "老港镇", c_type: "普通")
Community.create(id: 158, code: 21300, district: "金山", street: "石化街道", c_type: "普通")
Community.create(id: 159, code: 21301, district: "金山", street: "朱泾镇", c_type: "普通")
Community.create(id: 160, code: 21302, district: "金山", street: "吕巷镇", c_type: "普通")
Community.create(id: 161, code: 21303, district: "金山", street: "廊下镇", c_type: "普通")
Community.create(id: 162, code: 21304, district: "金山", street: "金山卫镇", c_type: "普通")
Community.create(id: 163, code: 21305, district: "金山", street: "枫泾镇", c_type: "普通")
Community.create(id: 164, code: 21306, district: "金山", street: "漕泾镇", c_type: "普通")
Community.create(id: 165, code: 21307, district: "金山", street: "山阳镇", c_type: "普通")
Community.create(id: 166, code: 21308, district: "金山", street: "亭林镇", c_type: "普通")
Community.create(id: 167, code: 21309, district: "金山", street: "张堰镇", c_type: "普通")
Community.create(id: 168, code: 21310, district: "金山", street: "金山工业区", c_type: "普通")
Community.create(id: 169, code: 21400, district: "松江", street: "岳阳街道", c_type: "普通")
Community.create(id: 170, code: 21401, district: "松江", street: "永丰街道", c_type: "普通")
Community.create(id: 171, code: 21402, district: "松江", street: "方松街道", c_type: "普通")
Community.create(id: 172, code: 21403, district: "松江", street: "中山街道", c_type: "普通")
Community.create(id: 173, code: 21404, district: "松江", street: "泗泾镇", c_type: "普通")
Community.create(id: 174, code: 21405, district: "松江", street: "佘山镇", c_type: "普通")
Community.create(id: 175, code: 21406, district: "松江", street: "洞泾镇", c_type: "普通")
Community.create(id: 176, code: 21407, district: "松江", street: "车墩镇", c_type: "普通")
Community.create(id: 177, code: 21408, district: "松江", street: "新桥镇", c_type: "普通")
Community.create(id: 178, code: 21409, district: "松江", street: "九亭镇", c_type: "普通")
Community.create(id: 179, code: 21410, district: "松江", street: "泖港镇", c_type: "普通")
Community.create(id: 180, code: 21411, district: "松江", street: "石湖荡镇", c_type: "普通")
Community.create(id: 181, code: 21412, district: "松江", street: "新浜镇", c_type: "普通")
Community.create(id: 182, code: 21413, district: "松江", street: "叶榭镇", c_type: "普通")
Community.create(id: 183, code: 21414, district: "松江", street: "小昆山镇", c_type: "普通")
Community.create(id: 184, code: 21500, district: "青浦", street: "夏阳街道", c_type: "普通")
Community.create(id: 185, code: 21501, district: "青浦", street: "盈浦街道", c_type: "普通")
Community.create(id: 186, code: 21502, district: "青浦", street: "香花桥街道", c_type: "普通")
Community.create(id: 187, code: 21503, district: "青浦", street: "朱家角街道", c_type: "普通")
Community.create(id: 188, code: 21504, district: "青浦", street: "练塘镇", c_type: "普通")
Community.create(id: 189, code: 21505, district: "青浦", street: "金泽镇", c_type: "普通")
Community.create(id: 190, code: 21506, district: "青浦", street: "赵巷镇", c_type: "普通")
Community.create(id: 191, code: 21507, district: "青浦", street: "徐泾镇", c_type: "普通")
Community.create(id: 192, code: 21508, district: "青浦", street: "华新镇", c_type: "普通")
Community.create(id: 193, code: 21509, district: "青浦", street: "重固镇", c_type: "普通")
Community.create(id: 194, code: 21510, district: "青浦", street: "白鹤镇", c_type: "普通")
Community.create(id: 195, code: 21600, district: "奉贤", street: "南桥镇", c_type: "普通")
Community.create(id: 196, code: 21601, district: "奉贤", street: "奉城镇", c_type: "普通")
Community.create(id: 197, code: 21602, district: "奉贤", street: "四团镇", c_type: "普通")
Community.create(id: 198, code: 21603, district: "奉贤", street: "金汇镇", c_type: "普通")
Community.create(id: 199, code: 21604, district: "奉贤", street: "青村镇", c_type: "普通")
Community.create(id: 200, code: 21605, district: "奉贤", street: "庄行镇", c_type: "普通")
Community.create(id: 201, code: 21606, district: "奉贤", street: "柘林镇", c_type: "普通")
Community.create(id: 202, code: 21607, district: "奉贤", street: "海湾镇", c_type: "普通")
Community.create(id: 203, code: 21700, district: "崇明", street: "城桥镇", c_type: "普通")
Community.create(id: 204, code: 21701, district: "崇明", street: "堡镇", c_type: "普通")
Community.create(id: 205, code: 21702, district: "崇明", street: "新河镇", c_type: "普通")
Community.create(id: 206, code: 21703, district: "崇明", street: "庙镇", c_type: "普通")
Community.create(id: 207, code: 21704, district: "崇明", street: "竖新镇", c_type: "普通")
Community.create(id: 208, code: 21705, district: "崇明", street: "向化镇", c_type: "普通")
Community.create(id: 209, code: 21706, district: "崇明", street: "三星镇", c_type: "普通")
Community.create(id: 210, code: 21707, district: "崇明", street: "港沿镇", c_type: "普通")
Community.create(id: 211, code: 21708, district: "崇明", street: "中兴镇", c_type: "普通")
Community.create(id: 212, code: 21709, district: "崇明", street: "陈家镇", c_type: "普通")
Community.create(id: 213, code: 21710, district: "崇明", street: "绿华镇", c_type: "普通")
Community.create(id: 214, code: 21711, district: "崇明", street: "港西镇", c_type: "普通")
Community.create(id: 215, code: 21712, district: "崇明", street: "建设镇", c_type: "普通")
Community.create(id: 216, code: 21713, district: "崇明", street: "新村乡", c_type: "普通")
Community.create(id: 217, code: 21714, district: "崇明", street: "长兴镇", c_type: "普通")
Community.create(id: 218, code: 21715, district: "崇明", street: "横沙乡", c_type: "普通")
Community.create(id: 219, code: 21716, district: "崇明", street: "东平镇", c_type: "普通")
Community.create(id: 220, code: 21717, district: "崇明", street: "新海镇", c_type: "普通")
