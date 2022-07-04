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
git clone --depth 1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config
git clone --depth 1 https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic
git clone --depth 1 -b packages https://github.com/xiaorouji/openwrt-passwall passwall-pkgs && rm -rf passwall-pkgs/.github && mv -n passwall-pkgs/* ./ && rm -rf passwall-pkgs
git clone --depth 1 -b luci https://github.com/xiaorouji/openwrt-passwall passwall-luci && mv -n passwall-luci/luci-app-passwall ./ && rm -rf passwall-luci

rm -rf ./*/.git & rm -f ./*/.gitattributes
rm -rf ./*/.svn & rm -rf ./*/.github & rm -rf ./*/.gitignore

exit 0
