<!--
HLDocS:LLM-MANAGED
doc_id: doc-20260914-SXRD1-TEST1
lang: ja-JP
canonical_title: Demo 1 O3DE/Godot比較テスト仕様
document_type: testspec
canonical_document: true
-->

[目次](../../目次.md) > テスト仕様 > Demo > Demo 1 O3DE/Godot比較テスト仕様

# Demo 1 O3DE/Godot比較テスト仕様

---

## SXR-D1-FUNC-XR-001 OpenXR起動およびHMD Tracking
<!-- hldocs:sec_id=sxr-d1-func-xr-001 -->

### 概要

O3DE版およびGodot版が同一検証環境でOpenXR Runtimeへ接続し、HMDの位置・姿勢を取得して表示へ反映できることを確認する。

### 前提条件

- Windows検証環境が利用可能である。
- 同一HMDおよび同一OpenXR Runtimeを使用する。
- 各EngineのDemo Clientが起動可能である。

### 検証内容

- OpenXR sessionを開始する。
- HMDを前後左右上下へ移動する。
- HMDをyaw/pitch/roll方向へ回転する。
- tracking値と表示の追従を確認する。

### 期待結果

- OpenXR sessionが成立する。
- HMD位置・姿勢が継続取得される。
- 視点がHMD動作へ追従する。
- tracking failureがある場合はEngine、OpenXR Runtime、driverのどの層かを切り分けて記録できる。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-003`
- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-004`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-003`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-015`

---

## SXR-D1-FUNC-XR-002 Left/Right Controller Tracking
<!-- hldocs:sec_id=sxr-d1-func-xr-002 -->

### 概要

Left/Right Controllerの位置・姿勢を両Engineで取得できることを確認する。

### 前提条件

- SXR-D1-FUNC-XR-001がPASSしている。
- Left/Right ControllerがOpenXR Runtimeで認識されている。

### 検証内容

- 左右Controllerを独立して移動・回転する。
- 左右の取り違えがないことを確認する。
- local representationへ反映する。

### 期待結果

- Left/Right Controllerが独立したposeとして取得できる。
- positionおよびrotationが追従する。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-005`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-003`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-009`

---

## SXR-D1-FUNC-WORLD-001 Simple World表示
<!-- hldocs:sec_id=sxr-d1-func-world-001 -->

### 概要

比較用固定Worldを両Engineで表示できることを確認する。

### 前提条件

- XR Clientが起動可能である。

### 検証内容

- Floorを表示する。
- Gridまたは同等の空間基準を表示する。
- 複数固定Objectを配置する。
- Lightingが成立することを確認する。

### 期待結果

- 両Engineで同等の比較用Worldが表示される。
- 空間位置およびRemote Player位置を目視判断できる。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-006`

---

## SXR-D1-NET-A-001 Engine Native Multiplayer接続
<!-- hldocs:sec_id=sxr-d1-net-a-001 -->

### 概要

Phase Aとして各Engine native networkingで2 Client以上の接続を成立させる。

### 前提条件

- O3DE版とGodot版は個別に実施する。
- 同一LANまたは同等の比較可能networkを使用する。

### 検証内容

- Client Aをsessionへ参加させる。
- Client Bを同一sessionへ参加させる。
- Player IDを識別する。
- join eventが各Clientで認識されることを確認する。

### 期待結果

- 2 Client以上が同一sessionへ接続できる。
- 接続状態およびPlayer識別が成立する。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-007`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-001`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-004`

---

## SXR-D1-NET-A-002 Native Player State同期
<!-- hldocs:sec_id=sxr-d1-net-a-002 -->

### 概要

各Engine native networkingでHead/Left Hand/Right Handのpose同期を確認する。

### 前提条件

- SXR-D1-NET-A-001がPASSしている。
- HMD/Controller Trackingが成立している。

### 検証内容

- Client AのHeadおよび左右Controllerを連続移動する。
- Client BでRemote Head/Handsを観察する。
- 逆方向も確認する。
- network update rateを記録する。

### 期待結果

- Remote Head/Handsが継続更新される。
- Player Stateに必要なposeが欠落しない。
- 使用したnetwork update rateが記録される。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-008`
- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-009`
- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-012`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-005`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-007`

---

## SXR-D1-NET-A-003 Disconnect/Reconnect
<!-- hldocs:sec_id=sxr-d1-net-a-003 -->

### 概要

Native networkingで切断検知および再接続が成立することを確認する。

### 前提条件

- 2 Clientが同一sessionへ接続済みである。

### 検証内容

- Client Bを正常終了する。
- Client AでPlayerLeft相当状態を確認する。
- Client Bを再起動し再接続する。
- 必要に応じて異常切断も試験する。

### 期待結果

- 切断したRemote Playerが残留し続けない。
- 再接続後にsessionへ復帰できる。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-010`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-006`

---

## SXR-D1-NET-A-004 Interpolation比較
<!-- hldocs:sec_id=sxr-d1-net-a-004 -->

### 概要

Remote representationについて補間なしとlinear interpolationの差を比較する。

### 前提条件

- Player State同期が成立している。

### 検証内容

- interpolationなしでRemote motionを確認する。
- linear interpolationを有効化して同一操作を行う。
- 30 Hzを基準として必要に応じ60 Hzでも実施する。

### 期待結果

- 各方式の見た目、frame負荷、pose age等を比較記録できる。
- 高度なpredictionを実装せずに比較可能である。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-013`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-007`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-008`

---

## SXR-D1-UGC-001 Runtime External Asset Load
<!-- hldocs:sec_id=sxr-d1-ugc-001 -->

### 概要

外部3D assetをEngine実行中に読み込み、Worldへinstance生成できることを確認する。

### 前提条件

- 比較用assetを用意する。
- 初期候補形式をGLBとする。

### 検証内容

- Engine Editorで事前Scene化されていない外部assetを対象とする。
- runtimeでassetを取得または参照する。
- loadし、Worldへinstance生成する。
- load開始から表示完了までを測定する。
- Editor/Asset Processor/import pipeline依存を記録する。

### 期待結果

- Runtime loadが成立する、または成立しない理由が明確化される。
- 必要な変換pipelineとEngine依存点が記録される。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-014`
- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-016`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-010`

---

## SXR-D1-UGC-002 UGC Object Session同期
<!-- hldocs:sec_id=sxr-d1-ugc-002 -->

### 概要

UGC ObjectのContent IDおよびTransformを別Clientへ共有し、対応Objectが同一World位置へ表示されることを確認する。

### 前提条件

- SXR-D1-UGC-001が対象Engineで成立している。
- 2 Client sessionが成立している。

### 検証内容

- Client AでUGC Objectを生成する。
- object_id、content_id、position、rotation、scaleをsessionへ共有する。
- Client Bで対応assetを解決してinstance生成する。

### 期待結果

- Client Bで同一Content IDに対応するObjectが表示される。
- Transformが許容誤差内で一致する。
- asset binaryと高頻度Player Stateが同一経路へ強制混在しない。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-015`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-011`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-012`

---

## SXR-D1-SRV-001 Dedicated/Headless Server成立性
<!-- hldocs:sec_id=sxr-d1-srv-001 -->

### 概要

各EngineでDedicated ServerまたはHeadless Server構成が成立するかを確認する。

### 前提条件

- Native networking構成が利用可能である。

### 検証内容

- Server-only/headless buildを作成する。
- GUIなしで起動する。
- 2 Clientを接続する。
- artifact size、起動時間、process memory、依存関係を記録する。

### 期待結果

- Server構成が成立する、または阻害要因が明示される。
- Client buildとの差が比較可能である。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-019`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-004`

---

## SXR-D1-PERF-001 Runtime性能計測
<!-- hldocs:sec_id=sxr-d1-perf-001 -->

### 概要

同一条件で各Engineの主要runtime指標を取得する。

### 前提条件

- 同一hardware、HMD、OpenXR Runtime、network topologyを使用する。
- 同一相当Worldおよびuser countを使用する。

### 検証内容

- render FPSを測定する。
- CPU/GPU frame timeを測定する。
- process memoryを測定する。
- network send/receive rateおよび取得可能なlatencyを測定する。
- remote pose ageを取得可能な場合は測定する。

### 期待結果

- O3DE/Godotの比較値が同一条件で記録される。
- 測定不能項目は理由を記録する。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-018`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-014`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-015`

---

## SXR-D1-DEV-001 Build/Iteration比較
<!-- hldocs:sec_id=sxr-d1-dev-001 -->

### 概要

開発・保守性比較のためbuildおよびiteration指標を取得する。

### 前提条件

- 両Engineの開発環境が構築済みである。

### 検証内容

- clean build時間を測定する。
- incremental build時間を測定する。
- project起動時間を測定する。
- 小変更から実行確認までの時間を測定する。
- ClientおよびServer artifact sizeを記録する。
- Debug/Profiler/CI手段を記録する。

### 期待結果

- 開発効率および配布負荷を比較可能な記録が得られる。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-021`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-016`

---

## SXR-D1-NET-B-001 Common Wire Server接続
<!-- hldocs:sec_id=sxr-d1-net-b-001 -->

### 概要

Phase BとしてO3DE版とGodot版が同一Common SansaXR Wire Trial server/relayへ接続できることを確認する。

### 前提条件

- Phase A結果からcommon wire schemaおよびtransportが定義済みである。
- common server/relay試作が起動可能である。

### 検証内容

- O3DE Clientを接続する。
- Godot Clientを接続する。
- Join/PlayerJoined相当eventを交換する。

### 期待結果

- 異なるEngine Clientが同一sessionへ参加できる。
- Engine固有wire formatをserverへ強制しない。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-011`
- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-023`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-001`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-005`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-006`

---

## SXR-D1-NET-B-002 Cross-engine Player State同期
<!-- hldocs:sec_id=sxr-d1-net-b-002 -->

### 概要

O3DE ClientとGodot Client間でCommon Wireを介したHead/Hands同期を確認する。

### 前提条件

- SXR-D1-NET-B-001がPASSしている。

### 検証内容

- O3DE側HMD/Controllerを動かしGodot側で表示する。
- Godot側HMD/Controllerを動かしO3DE側で表示する。
- sequence/timestamp処理を確認する。
- network update rateを記録する。

### 期待結果

- 双方向にRemote Head/Handsが表示される。
- Player State意味論がEngine間で一致する。
- 必要なEngine固有変換が特定される。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-008`
- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-023`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-005`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-013`

---

## SXR-D1-NET-B-003 Cross-engine UGC Object同期
<!-- hldocs:sec_id=sxr-d1-net-b-003 -->

### 概要

Common Wireを介してUGC Objectの意味論がO3DE/Godot間で共通化可能か確認する。

### 前提条件

- 両Engineで対象UGC assetのruntime表示が成立している。
- Common Wire接続が成立している。

### 検証内容

- 一方のClientでUGC Objectを生成する。
- content_id/object_id/TransformをCommon Wireで通知する。
- 他方Engineで対応Objectを生成する。
- 逆方向も実施する。

### 期待結果

- Engine固有Scene/Prefabをwire上の正本にせずObjectを共有できる。
- 共通化可能なContent/Object StateとEngine固有処理が分類できる。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-014`
- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-015`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-010`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-011`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-013`

---

## SXR-D1-ARCH-001 SansaXR境界分類
<!-- hldocs:sec_id=sxr-d1-arch-001 -->

### 概要

Demo 1結果からSansaXR Core / Engine Integration / Engine Nativeの境界候補を分類する。

### 前提条件

- O3DE/GodotのPhase Aが完了している。
- 可能であればPhase Bも完了している。

### 検証内容

各実装要素を以下へ分類する。

- SansaXR Core候補
- Engine Integration候補
- Engine Native維持
- SansaXR外repository責務
- 未確定

### 期待結果

- 実測に基づく境界案が得られる。
- speculative abstractionではなく、両Engineで確認した共通性を根拠とできる。

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-023`
- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-024`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-013`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-017`

---

## SXR-D1-ARCH-002 Engine選定評価
<!-- hldocs:sec_id=sxr-d1-arch-002 -->

### 概要

Demo 1の全結果を用いて正式Runtime候補を評価する。

### 前提条件

- 必須テスト結果が記録されている。

### 検証内容

以下を総合評価する。

- XR成立性
- native networking
- Common Wire適合性
- Runtime UGC
- Dedicated/Headless Server
- performance
- build/iteration
- tooling
- CI
- OSS/license
- upgrade/maintenance risk
- SansaXR architecture適合性

### 期待結果

以下のいずれかを根拠付きで選択できる。

- O3DEを主Runtime候補とする
- Godotを主Runtime候補とする
- 複数Engine正式対応を検討する
- 追加候補を再評価する
- architecture自体を再設計する

### 参照仕様

- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-022`
- `doc-20260914-SXRD1-REQ1#SXR-D1-REQ-024`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-017`
- `doc-20260914-SXRD1-DES1#SXR-D1-DES-018`

---

[目次](../../目次.md) > テスト仕様 > Demo > Demo 1 O3DE/Godot比較テスト仕様
