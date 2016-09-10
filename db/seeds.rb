# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Diymenu.delete_all
Diymenu.create(id: 1, name: '预报服务', is_show: true, sort: 0)
Diymenu.create(id: 2, name: '我的社区', is_show: true, sort: 1)
Diymenu.create(id: 3, name: '帮助', is_show: true, sort:2)
Diymenu.create(id: 4, parent_id: 1, name: '全市预警', url: 'http://weixin.lightning.sh.cn/forecast_services/city_warn', is_show: true, sort:0)
Diymenu.create(id: 5, parent_id: 1, name: '五日预报', url: 'http://weixin.lightning.sh.cn/forecast_services/locate', is_show: true, sort:1)
Diymenu.create(id: 6, parent_id: 1, name: '气象指数', url: 'http://weixin.lightning.sh.cn/forecast_services/life_index', is_show: true, sort:2)
Diymenu.create(id: 7, parent_id: 1, name: '空气质量', url: 'http://weixin.lightning.sh.cn/forecast_services/air_quality', is_show: true, sort:3)
Diymenu.create(id: 8, parent_id: 1, name: '健康气象', url: 'http://weixin.lightning.sh.cn/forecast_services/healthy_weather', is_show: true, sort:4)

Diymenu.create(id: 9, parent_id: 2, name: '灾情互动', url: 'http://weixin.lightning.sh.cn/communities/interact', is_show: true, sort:0)
Diymenu.create(id: 10, parent_id: 2, name: '社区实况', url: 'http://weixin.lightning.sh.cn/communities/detection', is_show: true, sort:1)
Diymenu.create(id: 12, parent_id: 3, name: '调查问卷', key: '调查问卷', is_show: true, sort:0)
Diymenu.create(id: 13, parent_id: 3, name: '气象科普', key: '气象科普', is_show: true, sort:1)
Diymenu.create(id: 14, parent_id: 3, name: '微社区', url: 'http://wsq.qq.com/reflow/234704148', is_show: true, sort:2)
Diymenu.create(id: 15, parent_id: 3, name: '帮助', key: '帮助', is_show: true, sort:3)
