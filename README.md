# BewlyCat for Safari

![Release](https://img.shields.io/github/v/release/Wildchiken/BewlyCat-Safari?label=Release)
![macOS](https://img.shields.io/badge/macOS-15%2B-slategray?logo=apple)
![Safari](https://img.shields.io/badge/Safari-18.5%2B-blue?logo=safari)

[BewlyCat](https://github.com/keleus/BewlyCat) 的 Safari 版本。基于 BewlyCat v1.8.3。

## 安装

1. 从 [Releases](https://github.com/Wildchiken/BewlyCat-Safari/releases) 下载 `extension-safari.zip`，解压
2. Safari → 设置 → 开发者 → 勾选「显示"开发"菜单」
3. 菜单栏 → 开发 → 允许未签名的扩展
4. 开发 → 扩展构建器 → + → 添加扩展，选择解压后的文件夹

之后在 Safari 设置 → 扩展中启用即可。不需要 Xcode 或 Apple 开发者账号。

## 构建

```bash
pnpm install
pnpm build-safari
```

产物在 `extension-safari/`，按上方步骤加载。需要打包成 Xcode 工程时见 [BUILD-SAFARI.md](docs/BUILD-SAFARI.md)。

## 发布

推送 `v*` 标签后，[Release 工作流](.github/workflows/release.yml) 会自动构建并把 `extension-safari.zip` 附到对应的 GitHub Release。

## 同步上游

Safari 适配只改动少量文件（`src/manifest.ts`、`src/contentScripts/index.ts`、`src/inject/index.ts`、`src/background/index.ts`、`src/background/utils.ts`、`src/background/settingsStorageCoordinator.ts`、`vite.config.ts`），其余代码与上游保持一致：

```bash
git remote add upstream https://github.com/keleus/BewlyCat
git fetch upstream --tags
git diff <上次同步的上游标签> HEAD -- src vite.config.ts > safari.patch
git checkout -b sync-upstream <新上游标签>
git apply -3 safari.patch
```

## 许可证

[MIT](LICENSE)。禁止打包为独立客户端。
