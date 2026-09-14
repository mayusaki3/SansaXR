# SansaXR

SansaXR は ProjectSansa ecosystem における XR runtime / OpenXR / realtime networking を担当するリポジトリです。

ProjectSansa 全体構想、repository federation、共通方針は [ProjectSansa](https://github.com/mayusaki3/ProjectSansa) を正本とします。

---

## 主な責務

- OpenXR based XR Runtime
- HMD / Controller / Tracking integration
- World Runtime
- Multiplayer / Session / Realtime State Synchronization
- Runtime-side SansaVRM integration
- Interaction
- Desktop Integration
- Engine Integration

認証・権利・来歴・経済・Portal は SansaSphere、SansaVRM format/schema/validator は SansaVRM の責務です。

---

## 現在の開発状態

現在、旧実装を整理し、新しい SansaXR Runtime の技術検証を行っています。

Demo 1 では O3DE と Godot を同一要件で実装・比較し、以下を検証します。

- OpenXR
- HMD / Controller Tracking
- Multiplayer
- Remote Head / Hand Synchronization
- Disconnect / Reconnect
- Runtime UGC
- Dedicated / Headless Server
- Performance
- SansaXR Core / Engine Integration 境界

Engine 共通抽象化は先行実装せず、各 Engine の native 実装結果から共通境界を抽出します。

---

## ドキュメント

- [日本語ドキュメント目次](./docs/ja-JP/目次.md)
- [Demo 1 O3DE/Godot比較要求仕様](./docs/ja-JP/仕様/10_Demo/01_Demo1_O3DE_Godot比較要求仕様.md)
- [Demo 1基本設計](./docs/ja-JP/仕様/10_Demo/02_Demo1基本設計.md)
- [Demo 1検証環境仕様](./docs/ja-JP/仕様/10_Demo/03_Demo1検証環境仕様.md)
- [Demo 1 O3DE/Godot比較テスト仕様](./docs/ja-JP/テスト仕様/10_Demo/01_Demo1_O3DE_Godot比較テスト仕様.md)

ドキュメントは HLDocS に基づいて管理します。

---

## Worklog

現在の作業状態は `LLM_Workspace/Worklog` を正本とします。

---

## License

See [LICENSE](./LICENSE).
