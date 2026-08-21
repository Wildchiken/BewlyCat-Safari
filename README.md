# BewlyCat 🐱 — Safari 版

> **基于 [BewlyCat](https://github.com/keleus/BewlyCat)（基于 [BewlyBewly](https://github.com/BewlyBewly/BewlyBewly)）的 Safari 适配版本。**
> 只需对您的 Bilibili 主页进行一些小更改即可。

<p align="center">
<img width="300" alt="BewlyCat icon" src="./assets/icon-512.png"><br/>
</p>

---

## 📌 本分支说明

本仓库是 **BewlyCat 的 Safari 适配分支**，在原项目基础上进行以下改动：

- ✅ 兼容 Safari（macOS 15+ / Safari 18.5+）
- ✅ 修复 Safari Shadow DOM 下暗色模式评论文字全黑的 bug
- ✅ 提供预编译的 Safari 扩展包下载
- ✅ 完整的构建脚本（`pnpm build-safari`）
- ✅ 保留原 BewlyCat 所有功能

原项目作者明确表示「不会打包 Safari」，而本分支专注解决 Safari 兼容性问题。

---

## ⬇️ 安装（Safari）

### 方式一：从 Release 下载（推荐）

1. 前往 [Releases](https://github.com/你的账号/BewlyCat-Safari/releases) 页面
2. 下载最新版本的 `extension-safari.zip`
3. 解压得到 `extension-safari/` 文件夹（保留目录结构）
4. 在 Safari 中加载：

#### 加载未签名扩展的步骤

Safari 18+ 支持加载未签名的 Web Extension，步骤如下：

1. 打开 Safari → **设置**（⌘,）
2. 进入 **开发者** 选项卡
3. 勾选 **显示"开发"菜单**
4. 点击菜单栏 **开发** → **允许未签名的扩展**（Allow Unsigned Extensions）
5. 再次点击 **开发** → **扩展构建器**（Extension Builder）
6. 点击左下角 **+** → **添加扩展…**
7. 选择解压后的 `extension-safari/` 文件夹
8. 在弹出的提示中点击 **信任**
9. 如果弹出签名提示，点击 **安装** 即可

> ⚠️ 首次加载后可以在 Safair 设置 → **扩展** 中启用/禁用 BewlyCat。

---

## 🚀 从源码构建

如果你也想从源码构建，需要先安装 Node.js 和 pnpm：

```bash
# 1. 安装依赖
pnpm install

# 2. 构建 Safari 版本
pnpm build-safari

# 3. 产物在 extension-safari/ 目录下
# 按上方 Safari 加载步骤导入即可
```

---

## ✨ 功能

### 新增功能（原 BewlyCat 新增）

1. 视频卡片、顶栏链接后台打开
2. 默认播放器样式设置（滚动到弹幕框与底部平齐）
3. 用户面板大会员权益领取入口
4. 首页推荐前进后退
5. 合集播放自动关闭
6. Web 模式推荐按点赞/播放比例过滤
7. 自定义快捷键（参考 Extension for Bilibili Player）
8. 记忆倍速比例
9. 合集视频随机播放
10. 视频详情页稍后再看外置
11. 自定义暗色基准色
12. 合集视频保持默认播放模式

### Safari 特有修复

- 暗色模式下评论文本颜色正确显示
- Shadow DOM CSS 变量兼容性处理
- 适配 Safari 的 Web Extension manifest

---

## ⚠️ 重要须知

> **本插件禁止以任何形式的客户端封装！** 插件的目的是仅优化 Bilibili 官方网站的使用体验。

> 本项目基于 MIT 许可在原项目基础上开发。请尊重原作者的劳动成果。

---

## 📄 许可证

本项目基于 MIT 许可，但有额外条款：

- ✅ 允许自由使用、修改、分享
- ✅ 允许浏览器扩展商店上架
- ❌ **禁止** 打包成独立客户端、桌面 App、移动 App 等非浏览器插件形式的分发

详细条款见 [LICENSE](./LICENSE)。

---

## 🙏 致谢

- [BewlyBewly](https://github.com/BewlyBewly/BewlyBewly) — 原项目
- [BewlyCat](https://github.com/keleus/BewlyCat) — 功能扩充版本