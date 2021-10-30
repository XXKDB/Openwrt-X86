#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# 修改openwrt登陆地址,把下面的192.168.31.1修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把YOU-R4A修改你喜欢的就行（不能纯数字或者使用中文）
sed -i '/uci commit system/i\uci set system.@system[0].hostname='XXKDB'' package/lean/default-settings/files/zzz-default-settings

# 版本号里显示一个自己的名字（ababwnq build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
sed -i 's/OpenWrt /编译时间 $(TZ=UTC-8 date "+%Y.%m.%d") @ 星新课代表 /g' package/lean/default-settings/files/zzz-default-settings


#删除原默认主题
rm -rf package/lean/luci-theme-argon
rm -rf package/lean/luci-theme-bootstrap
rm -rf package/lean/luci-theme-material
rm -rf package/lean/luci-theme-netgear
rm -rf package/kenzo/luci-app-argon-config
rm -rf package/kenzo/luci-theme-argon_new
rm -rf package/kenzo/luci-app-advanced
rm -rf package/kenzo/luci-app-serverchan

#下载主题luci-theme-argon
git clone https://github.com/XXKDB/luci-theme-argon_armygreen.git package/lean/luci-theme-argon_armygreen
#用于 OpenWRT/LEDE 路由器上进行 Server酱 微信/Telegram 推送的插件
git clone https://github.com/tty228/luci-app-serverchan.git package/lean/luci-app-serverchan
#为OpenWRT上bandwidthd开发的luci配置页面，用于统计局域网各个IP的流量状况并绘图
git clone https://github.com/AlexZhuo/luci-app-bandwidthd.git package/lean/luci-app-bandwidthd

#下载主题luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
#您可以设置 argon 主题登录页面的模糊性和透明度，并管理背景图片和视频。
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/lean/luci-app-argon-config
#autotimeset 定时设置插件
git clone https://github.com/sirpdboy/luci-app-autotimeset.git package/lean/luci-app-autotimeset
#关闭路由器
git clone https://github.com/esirplayground/luci-app-poweroff.git package/lean/luci-app-poweroff
#luci-app-advanced 高级设置，包括smartdns，openclash，防火墙，DHCP等。
git clone https://github.com/sirpdboy/luci-app-advanced.git package/lean/luci-app-advanced
#luci-app-NetSpeedTest — 网络速度测试1.5完整版
git clone https://github.com/sirpdboy/netspeedtest.git package/lean/netspeedtest


# 修改luci-theme-argon_armygreen主题渐变色，16进制RGB
#登录页面背景颜色+半透明
sed -i 's/#f7fafc/rgba(134,176,197, .5)/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css

#渐变色开始
sed -i 's/#f9ffff/#80ABC3/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css
#渐变色结束b8 57
sed -i 's/#7fffffb8/#5C859B/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css
sed -i 's/#9effff57/#9FC4D5/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css
#主机名  ，导航栏-状态-文字的颜色
sed -i 's/#4fc352/#B7E0F3/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css

#加载背景
sed -i 's/#5e72e4/#407994/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css
#已选中
#sed -i 's/#4F2EDC/#E0DAD6/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css

#sed -i 's/#00FF00/#407994/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css
#加载背景
sed -i 's/#5e72e4/#407994/g' package/lean/luci-theme-argon_armygreen/htdocs/luci-static/argon_armygreen/css/style.css



#取消原主题luci-theme-bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-argon_armygreen/g' ./feeds/luci/collections/luci/Makefile



# 修改想要的root密码
sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:$1$f2QecoCH$2z6ZS7SynroxrP4I5bd3H.:18729:0:99999:7:::/g' package/lean/default-settings/files/zzz-default-settings

# 修改想要的root密码
#sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:你的密码/g' package/lean/default-settings/files/zzz-default-settings
# 修改插件名字（修改名字后不知道会不会对插件功能有影响，自己多测试）
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po

# 修改默认wifi名称ssid为Xiaomi_R4A
#sed -i 's/ssid=OpenWrt/ssid=XXKDB/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改默认wifi密码key为Xiaomi_R4A
#sed -i 's/encryption=none/encryption=psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#使用sed 在第四行后添加新字
#sed -e 120a\set wireless.default_radio${devidx}.key=XXKDB-R4A package/kernel/mac80211/files/lib/wifi/mac80211.sh
#sed -i '/set wireless.default_radio${devidx}.encryption=psk2/a\set wireless.default_radio${devidx}.key=password' package/kernel/mac80211/files/lib/wifi/mac80211.sh
