# BewlyCat for Safari

![GitHub Release](https://img.shields.io/github/v/release/Wildchiken/BewlyCat-Safari?label=Release)
![macOS](https://img.shields.io/badge/macOS-15%2B-slategray?logo=apple)
![Safari](https://img.shields.io/badge/Safari-18.5%2B-blue?logo=safari)

<p align="center">
  <img width="300" alt="icon" src="./assets/icon-512.png">
</p>

[BewlyCat](https://github.com/keleus/BewlyCat) 的 Safari 适配版。在原项目基础上修复了 Safari 下的兼容问题，保留了全部功能。

原项目作者已明确表示不会单独打包 Safari 版本，因此开这个分支来解决这个问题。

## 安装

从 [Releases](https://github.com/Wildchiken/BewlyCat-Safari/releases) 下载 `extension-safari.zip`，解压。

Safari 加载步骤：

1. Safari → 设置 → 开发者 → 勾选「显示"开发"菜单」
2. 菜单栏 → 开发 → 允许未签名的扩展
3. 开发 → 扩展构建器 → 左下角 + → 添加扩展
4. 选择解压后的 `extension-safari/` 文件夹，点击信任并安装

加载后可在 Safari 设置 → 扩展中启用或禁用。

## 从源码构建

```bash
pnpm install
pnpm build-safari
```

产物在 `extension-safari/`，按上面步骤加载即可。

## 与原版的差异

**新增功能：**
- 视频卡片、顶栏链接后台打开
- 播放器样式自定义（弹幕框自动到底部平齐）
- 大会员权益领取入口
- 首页推荐前进后退
- 合集自动关闭、随机播放
- 按点赞/播放比例过滤推荐
- 自定义快捷键
- 记忆倍速比例
- 稍后再看外置
- 自定义暗色基准色

**删除内容：**
- 广东话翻译（原作者维护）
- 内置字体（包体积 14.4M → 600K）
- 旧版顶栏组件（已重构）
- 部分动画

**Safari 适配内容：**
- 修复暗色模式下评论文字全黑的问题
- Web Extension manifest 兼容
- 无需 Xcode 签名即可加载

## 许可证

基于 MIT 许可，额外条款禁止打包为独立客户端。详见 [LICENSE](./LICENSE)。

## 致谢

- [BewlyBewly](https://github.com/BewlyBewly/BewlyBewly)
- [BewlyCat](https://github.com/keleus/BewlyCat)
- [vitesse-webext](https://github.com/antfu/vitesse-webext)
- [Bilibili-Evolved](https://github.com/the1812/Bilibili-Evolved)