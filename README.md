# BewlyCat for Safari

![Release](https://img.shields.io/github/v/release/Wildchiken/BewlyCat-Safari?label=Release)
![macOS](https://img.shields.io/badge/macOS-15%2B-slategray?logo=apple)
![Safari](https://img.shields.io/badge/Safari-18.5%2B-blue?logo=safari)

[BewlyCat](https://github.com/keleus/BewlyCat) 的 Safari 版本。基于 BewlyCat v1.7.6。

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

产物在 `extension-safari/`，按上方步骤加载。

## 许可证

[MIT](LICENSE)。禁止打包为独立客户端。
