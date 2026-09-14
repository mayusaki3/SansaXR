<!--
HLDocS:LLM-MANAGED
doc_id: doc-20260914-SXRD1-DES1
lang: ja-JP
canonical_title: Demo 1 基本設計
document_type: spec
canonical_document: true
-->

[目次](../../目次.md) > 仕様 > Demo > Demo 1 基本設計

# Demo 1 基本設計

## Purpose（存在理由）

本仕様は、`01_Demo1_O3DE_Godot比較要求仕様.md` を実装可能な単位へ分解し、O3DE版とGodot版を公平に比較するためのDemo 1基本設計を定義する。

Demo 1では、エンジン固有機能の評価とSansaXR共通化可能範囲の評価を混同しないことを最優先とする。

## Non-goals（対象外）

- 製品版SansaXR Network Protocolの確定
- 製品版SansaXR Core APIの確定
- 製品版UGC Formatの確定
- O3DE/Godotの正式採用確定
- 完全なEngine Adapter設計
- 完全な分散World Architectureの確定

## 定義・制約

### SXR-D1-DES-001 二段階Networking比較

Networking比較は以下の2段階に分離する。

#### Phase A: Engine Native Networking

目的:
- 各Engineで最小XR Multiplayerを最短経路で成立させる
- Engine native networkingの機能性、実装容易性、性能、制約を評価する

方針:
- O3DEはO3DE native networking機構を使用する
- GodotはGodot native networking機構を使用する
- 両Engine間の相互接続は要求しない
- wire protocolの共通化を要求しない

#### Phase B: Common SansaXR Wire Trial

目的:
- Engine依存しないPlayer State / Session Stateの交換が成立するかを検証する
- SansaXR Core候補とEngine Integration候補の境界を抽出する

方針:
- O3DE版とGodot版で同一の最小message schemaを使用する
- 共通serverまたは共通relayを使用する
- Phase BのtransportはPhase Aの結果を踏まえて選定する
- Phase BではO3DE clientとGodot clientの相互接続を検証対象に含める

### SXR-D1-DES-002 Networking比較の公平性

Phase Aの結果とPhase Bの結果を別々に評価する。

Phase Aの優劣をPhase Bの制約で上書きしてはならない。
Phase Bの移植性をPhase Aのnative機能差だけで評価してはならない。

### SXR-D1-DES-003 Client Runtime構成

各Clientは最低限以下の責務を持つ。

- XR Runtime接続
- HMD tracking
- Left/Right controller tracking
- local rendering
- local player state生成
- network送信
- remote player state受信
- remote head/hand表示
- runtime UGC load/instance生成

### SXR-D1-DES-004 Server/Relay構成

Demo 1ではServer側の責務を最小化する。

最低責務:
- client接続管理
- session参加/離脱管理
- Player ID付与または識別
- Player State中継
- Player join/leave通知
- UGC object metadata/stateの中継または共有

Demo 1ではServer authoritative game simulationを必須としない。

### SXR-D1-DES-005 Player State最小schema

最低限以下を表現できること。

- player_id
- sequence_numberまたは同等の順序識別
- timestampまたは同等の時刻情報
- head.position
- head.rotation
- left_hand.position
- left_hand.rotation
- right_hand.position
- right_hand.rotation

Positionは3要素実数、RotationはQuaternion 4要素を基本とする。

### SXR-D1-DES-006 Session Event最小schema

最低限以下を表現できること。

- Join
- PlayerJoined
- PlayerState
- PlayerLeft
- Leave

Phase Bではmessage名そのものより意味論の一致を優先する。

### SXR-D1-DES-007 Network Update Rate

Rendering Frame RateとNetwork Update Rateを分離する。

初期試験値は30 Hzを基準とし、必要に応じて60 Hzを追加比較する。
90 Hzはrender側要件として扱い、network更新を自動的に90 Hzへ固定しない。

実測結果により初期値は変更可能とする。

### SXR-D1-DES-008 Interpolation

Remote representationにはPhase A/Bともに以下を比較可能とする。

- interpolationなし
- linear interpolation
- 必要に応じて簡易extrapolation

Demo 1で高度なpredictionを必須としない。

### SXR-D1-DES-009 XR Poseの境界

HMD/controllerのframe-local pose取得およびrenderingへの直接反映はEngine側に保持する。

Networkへ渡す時点でのみPlayer Stateへ正規化する。

これによりXR poseをSansaXR Core経由で毎frame往復させない。

### SXR-D1-DES-010 UGC Runtime Trial

UGC試験はEngineごとにnativeなruntime load経路を最初に使用する。

最低試験シナリオ:
1. 外部3D assetを用意する
2. 実行中Clientがassetを取得する
3. runtime loadする
4. World内にinstanceを生成する
5. Object ID、Transform、Content IDをsession stateへ反映する
6. 別Clientでも対応Objectを表示する

初期asset候補はGLBとする。

### SXR-D1-DES-011 UGC同期データ

Realtimeで最低限同期するUGC情報は以下とする。

- object_id
- content_id
- position
- rotation
- scale
- visibility/state minimum flags

asset binary本体の転送方式は別レイヤとし、Player Stateと同じ高頻度経路へ混在させない。

### SXR-D1-DES-012 UGC配布試験

Demo 1では以下のいずれかを選択可能とする。

- 両Clientが同一URL/pathからasset取得
- Server/relayがContent IDと取得先を通知
- 事前配置assetをContent IDで参照

どの方式を採用したかを比較結果へ記録する。

### SXR-D1-DES-013 Engine Adapter抽出基準

Demo 1終了時、機能を以下に分類する。

#### Core候補
- Session意味論
- Player State意味論
- Object State意味論
- Content ID
- common wire schema
- reconnect policy候補

#### Engine Integration候補
- Engine entity/node生成
- runtime asset load
- XR runtime bridge
- native input binding
- native networking bridge

#### Engine Native維持候補
- Rendering
- Physics
- Animation
- IK
- frame-local XR pose処理
- GPU resource管理

### SXR-D1-DES-014 Performance測定点

最低限以下の測定点を設ける。

- local render FPS
- CPU frame time
- GPU frame time
- network send rate
- network receive rate
- round-trip timeまたは取得可能なnetwork latency
- remote pose age
- process memory
- server/relay process memory
- UGC load開始から表示までの時間

### SXR-D1-DES-015 実行環境

基本検証OSはWindowsとする。

同一比較では可能な限り以下を固定する。

- PC hardware
- GPU driver
- HMD
- OpenXR runtime
- network topology
- test asset
- user count

### SXR-D1-DES-016 Build/Iteration測定

各Engineで以下を記録する。

- clean build時間
- incremental build時間
- project起動時間
- source変更から実行確認までの時間
- package/build artifact size
- headless/server artifact size

### SXR-D1-DES-017 Demo 1実施順序

実施順序は以下を基本とする。

1. O3DE XR単体成立
2. Godot XR単体成立
3. O3DE Phase A Multiplayer
4. Godot Phase A Multiplayer
5. O3DE Runtime UGC
6. Godot Runtime UGC
7. Phase A比較
8. Common wire schema設計
9. Common server/relay試作
10. O3DE Phase B
11. Godot Phase B
12. O3DE-Godot相互接続
13. 最終比較
14. SansaXR Core / Engine Integration境界案作成

### SXR-D1-DES-018 FAIL条件

以下は技術検証上のFAILとして記録する。

- OpenXRでHMD trackingが成立しない
- controller trackingが成立しない
- 2 Client同期が成立しない
- runtime UGC loadがEditor依存等により要求条件を満たせない
- headless/server構成が成立しない
- Phase B common wire trialへの接続が実質的に不可能

FAILはEngine失格を自動的に意味しない。
原因、回避策、影響範囲を記録する。

## 他 document_type との関係

本設計を基に `testspec` を作成する。
各Testは要求ID `SXR-D1-REQ-*` と設計ID `SXR-D1-DES-*` へ追跡可能とする。

---

[目次](../../目次.md) > 仕様 > Demo > Demo 1 基本設計
