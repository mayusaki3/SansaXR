<!--
HLDocS:LLM-MANAGED
doc_id: doc-20260914-SXRD1-REQ1
lang: ja-JP
canonical_title: Demo 1 O3DE/Godot比較要求仕様
document_type: spec
canonical_document: true
-->

[目次](../../目次.md) > 仕様 > Demo > Demo 1 O3DE/Godot比較要求仕様

# Demo 1 O3DE/Godot比較要求仕様

## Purpose（存在理由）

本仕様は、ProjectSansa再構成後のSansaXR Runtimeについて、O3DEおよびGodotを同一要求で実装・検証し、正式なランタイム/ゲームエンジン選定とSansaXR Core / Engine Integration境界設計に必要な実測情報を得るためのDemo 1要求を定義する。

Demo 1は製品版機能の完成を目的とせず、XR、リアルタイム通信、UGC Runtime Pipelineおよびエンジン依存性の技術的成立性を比較するためのPoCとする。

## Non-goals（対象外）

Demo 1では以下を完成要件としない。

- SansaSphereによる本番認証・認可
- 完全なSansaVRMアバター表示
- Full Body Tracking
- IK
- Voice Chat
- Text Chat
- 永続ワールド
- 永続データベース
- 本番UGC配信基盤
- World Editor
- 完全なPhysics同期
- Object Ownershipの本番仕様
- AI機能
- 写真からの3D生成
- 霧世界
- SansaCloth統合
- MuJoCo統合
- AR/MR実装
- Linux/macOSでのDemo 1成功保証

## 定義・制約

### SXR-D1-REQ-001 比較対象

Demo 1は以下の2実装を作成する。

- O3DE native implementation
- Godot native implementation

両実装は原則として同一の機能要求および同一の評価条件を満たすものとする。

### SXR-D1-REQ-002 初期抽象化禁止

Demo 1開始時点では、O3DEとGodotを共通化するRuntime Adapterを先行実装してはならない。

各エンジンのnative APIおよび推奨方式を用いて実装し、その結果から以下を分類する。

- SansaXRで共通化すべき意味論
- エンジン固有とすべき処理
- 高頻度処理
- 低頻度処理
- 共通データ型候補
- Engine Integration境界候補

### SXR-D1-REQ-003 OpenXR

各実装はOpenXRを使用してXR Runtimeへ接続する。

特定HMDベンダーSDKへの直接依存をDemo 1の基本方式としては採用しない。

### SXR-D1-REQ-004 HMD Tracking

各実装はHMDの位置および姿勢を取得し、ローカルユーザーの視点へ反映できなければならない。

姿勢はQuaternionで保持可能であること。

### SXR-D1-REQ-005 Controller Tracking

各実装はLeft ControllerおよびRight Controllerの位置・姿勢を取得できなければならない。

### SXR-D1-REQ-006 Simple World

各実装は比較用の固定3Dワールドを表示する。

最低構成は以下とする。

- Floor
- 空間位置を判断できるGridまたは同等表現
- 複数の固定3D Object
- XR表示に必要なLighting

ワールドの視覚品質そのものを比較目的としない。

### SXR-D1-REQ-007 Multiplayer Session

2台以上のクライアントが同一セッションへ接続できなければならない。

Demo 1では単一Roomのみでもよいが、将来の複数Roomを構造的に阻害しないこと。

### SXR-D1-REQ-008 Player State

最低限、以下をリアルタイム同期対象とする。

- Player ID
- Head Position
- Head Rotation
- Left Hand Position
- Left Hand Rotation
- Right Hand Position
- Right Hand Rotation

PositionはXYZ、RotationはQuaternion XYZWで表現可能であること。

### SXR-D1-REQ-009 Remote Representation

Remote Playerについて最低限以下を可視化する。

- Head
- Left Hand
- Right Hand

Demo 1では単純なPrimitive Meshを使用してよい。

### SXR-D1-REQ-010 Disconnect / Reconnect

クライアント切断を他クライアントが検知できること。

切断したクライアントが再度セッションへ接続できること。

### SXR-D1-REQ-011 Network Transport

Network Transportは本仕様では固定しない。

候補方式を比較し、採用理由を記録する。

Transport選択がO3DE/Godot比較を不当に有利または不利にしないよう考慮する。

### SXR-D1-REQ-012 Network Update Rate

Network Update RateはRendering Frame Rateと独立して扱う。

Demo 1で使用した値を検証結果へ記録する。

30 Hz、60 Hz、90 Hz等を候補とするが、本仕様では固定しない。

### SXR-D1-REQ-013 Interpolation / Extrapolation

InterpolationおよびExtrapolationの採否は設計工程で決定する。

採用しない場合も、Remote Playerの視覚的挙動を比較結果として記録する。

### SXR-D1-REQ-014 Runtime UGC

各実装は実行中に外部UGCをロードしてWorldへInstance生成する試験を実施する。

初期候補形式はGLBとするが、技術調査により変更してよい。

UGCの正本をO3DE PrefabまたはGodot Scene等のエンジン固有形式に固定してはならない。

### SXR-D1-REQ-015 UGC Network Synchronization

UGC試験では、少なくとも1クライアントで生成対象となったUGC Objectに対応するObjectが、同一セッションの別クライアントでも同一World上の対応位置に表示可能であることを確認する。

UGCファイルそのものをRealtime State通信で送信することは要求しない。

配布方式は設計・検証対象とする。

### SXR-D1-REQ-016 Runtime UGC Pipeline評価

UGCについて以下を記録する。

- Source取得方式
- Validation方式
- Runtime変換の有無
- Editor依存の有無
- Build時Asset Pipeline依存の有無
- Runtime load時間
- Instance生成時間
- Cache方式
- Engine固有形式への変換箇所
- 実装上の制約

### SXR-D1-REQ-017 Engine Native High-frequency Processing

以下の高頻度処理は、比較上必要な理由がない限り各Engine内部で処理する。

- Rendering
- Physics
- Animation
- IK
- XR poseのframe-local処理

SansaXR共通化のためだけに毎frame不要なデータ変換またはコピーを追加してはならない。

### SXR-D1-REQ-018 Performance Measurement

少なくとも以下を測定可能な構成とする。

- Rendering Frame Rate
- CPU Frame Time
- GPU Frame Time
- XR trackingから表示までの処理に関する取得可能な指標
- Network送受信頻度
- Network latencyの取得可能な指標
- Memory Usage
- UGC load時間

同一ハードウェアで比較可能な測定項目は同一条件で取得する。

### SXR-D1-REQ-019 Dedicated Server

各EngineについてDedicated ServerまたはHeadless Server構成の成立性を検証する。

ClientとServerを分離した構成について以下を評価する。

- Build方法
- Runtime依存
- 配布サイズ
- 起動時間
- Resource Usage
- Engine依存度

Demo 1の最終Realtime Server構成をEngine Serverへ固定することは本要求では行わない。

### SXR-D1-REQ-020 World Streaming

Demo 1で大規模World Streamingの完成実装は要求しない。

ただし将来の動的World読み込みを想定し、各Engineの以下を調査・小規模検証する。

- Runtime asset loading
- World/Scene分割
- 非同期load
- Instance生成・破棄
- Cache
- Background processing

### SXR-D1-REQ-021 開発効率

各実装について以下を記録する。

- 初期環境構築時間
- Build時間
- 変更から実行確認までのiteration
- 主な実装言語
- Debug手段
- Profiler
- CI自動化難易度
- Engine upgrade時の影響候補

### SXR-D1-REQ-022 OSS / License

各EngineおよびDemo 1で追加する主要dependencyについて以下を確認する。

- License
- 再配布条件
- ProjectSansaのOSS方針との適合性
- 継続保守上のリスク

### SXR-D1-REQ-023 SansaXR Integration評価

比較完了後、各機能を以下に分類する。

- SansaXR Core候補
- Engine Integration候補
- Engine Native維持
- SansaXR外の別repository責務
- 未確定

### SXR-D1-REQ-024 Engine選定を先に確定しない

Demo 1完了前にO3DEまたはGodotの一方を正式SansaXR Runtimeとして確定しない。

比較結果から以下のいずれかを選択可能とする。

- O3DEを主Runtimeとする
- Godotを主Runtimeとする
- 複数Engineを正式対応する
- 追加候補を再評価する
- Engine abstraction方針そのものを再設計する

### SXR-D1-REQ-025 対象OS

Demo 1の実動作検証対象OSはWindowsを基本とする。

LinuxおよびmacOSは将来対象候補として設計上の阻害要因を記録するが、Demo 1成功条件には含めない。

### SXR-D1-REQ-026 作業記録

技術検証の進行状況、決定事項、最新検証結果、保留事項および次工程はLLM_Workspace/Worklogへ随時記録する。

検証結果は最終的に比較結果文書へ反映する。

## 他 document_type との関係

本仕様から、O3DE版およびGodot版で共通して実行可能な比較テスト仕様を別途作成する。

実装開始前に、少なくともDemo 1の設計およびテスト仕様を確定する。

---

[目次](../../目次.md) > 仕様 > Demo > Demo 1 O3DE/Godot比較要求仕様
