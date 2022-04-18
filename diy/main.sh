#!/bin/bash
function git_sparse_clone() {
branch="$1" rurl="$2" localdir="$3" && shift 3
git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
cd $localdir
git sparse-checkout init --cone
git sparse-checkout set $@
mv -n $@ ../
cd $GITHUB_WORKSPACE/$REPO_BRANCH
rm -rf $localdir
}

function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}

git clone --depth 1 https://github.com/destan19/OpenAppFilter && mvdir OpenAppFilter
git clone --depth 1 https://github.com/brvphoenix/luci-app-wrtbwmon wrtbwmon1 && mvdir wrtbwmon1
git clone --depth 1 https://github.com/brvphoenix/wrtbwmon wrtbwmon2 && mvdir wrtbwmon2
git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced
git clone --depth 1 https://github.com/tty228/luci-app-serverchan
git clone --depth 1 https://github.com/ntlf9t/luci-app-easymesh
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config
git clone --depth 1 -b packages https://github.com/xiaorouji/openwrt-passwall passwall-pkgs && rm -rf passwall-pkgs/.github && mv -n passwall-pkgs/* ./ && rm -rf passwall-pkgs
git clone --depth 1 -b luci https://github.com/xiaorouji/openwrt-passwall passwall-luci && mv -n passwall-luci/luci-app-passwall ./ && rm -rf passwall-luci

git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "eqos_luci" applications/luci-app-eqos
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/packages" "uugamebooster_pkg" net/uugamebooster
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "uugamebooster_luci" applications/luci-app-uugamebooster
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "arpbind_luci" applications/luci-app-arpbind
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "usb_printer_luci" applications/luci-app-usb-printer
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "accesscontrol_luci" applications/luci-app-accesscontrol
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "cifs_mount_luci" applications/luci-app-cifs-mount
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "lib_fs_luci" libs/luci-lib-fs
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "filetransfer_luci" applications/luci-app-filetransfer
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "guest_wifi_luci" applications/luci-app-guest-wifi
git_sparse_clone openwrt-21.02 "https://github.com/immortalwrt/luci" "ramfree_luci" applications/luci-app-ramfree
git_sparse_clone master "https://github.com/kiddin9/openwrt-packages" "adguardhome_luci" luci-app-adguardhome

rm -rf ./*/.git & rm -f ./*/.gitattributes
rm -rf ./*/.svn & rm -rf ./*/.github & rm -rf ./*/.gitignore

exit 0

