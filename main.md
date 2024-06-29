# ゴール

- 拡散モデルの数理を流し読みして、量子コンピューティング (量子アニーリング) と関係ありそうだと思った
        - ので、これの数理的な関連をざっくりと理解したい
        - 年内いっぱいくらいで「わかった」という気分になりたい
        - なんでかというと、今から量子コンピューティングの勉強にリソース割いておくかどうかを見定めたい

## 関連しそうな項目

- 拡散モデル
        - 確率過程
- シミュレーティッドアニーリング
- 量子アニーリング
- 代数的確率空間
        - 量子力学においては、行列(=作用素)のtraceが期待値
        - この辺を抽象化して、代数の元に「確率的」な情報が含まれているとみなしてゴニョゴニョするのが確率的代数空間 (イメージ)
        - これを理解できると「拡散モデルのマルコフ過程は代数的確率空間的にはこう」みたいな話から「じゃあこんな種類の代数構造から考えたら拡散モデルに当たるものは何？」みたいな議論ができて面白いのでは、という仮説

# 課題感

- 大規模LLMは大手に独占されている
        - GPT 4はパラメーター数が 170兆
        - 圧倒的データ量

# 教科書

- **確率論**: [https://www.amazon.co.jp/gp/product/4254116004/ref=ox_sc_act_image_1?smid=AN1VRQENFRJN5&psc=1](https://www.amazon.co.jp/gp/product/4254116004/ref=ox_sc_act_image_1?smid=AN1VRQENFRJN5&psc=1)
- **確率微分方程式とその応用:** [https://www.amazon.co.jp/gp/product/4627077815/ref=ox_sc_act_image_2?smid=AN1VRQENFRJN5&psc=1](https://www.amazon.co.jp/gp/product/4627077815/ref=ox_sc_act_image_2?smid=AN1VRQENFRJN5&psc=1)

# 論文まとめ


## Deep Unsupervised Learning using Nonequilibrium Thermodynamics

非平衡熱力学を用いた教師なしディープラーニング


[Deep_Unsupervised_Learning_using_Nonequilibrium_Thermodynamics.pdf](https://prod-files-secure.s3.us-west-2.amazonaws.com/a95e1e6d-ab5d-426a-b5b6-652ced6dcd2a/673adbff-eaa6-4376-a336-ac3a1b60d50e/Deep_Unsupervised_Learning_using_Nonequilibrium_Thermodynamics.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45HZZMZUHI%2F20240118%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240118T043703Z&X-Amz-Expires=3600&X-Amz-Signature=b7f4072570d2ec339eb1e103d5ac017a08fafde6ae0bcb8a10f032deeb173a62&X-Amz-SignedHeaders=host&x-id=GetObject)


[%E6%B7%B1%E5%B1%A4%E7%94%9F%E6%88%90%E3%81%A6%E3%82%99%E4%BD%BF%E3%81%86%E7%A2%BA%E7%8E%87%E8%AB%96_%282%29.pdf](https://prod-files-secure.s3.us-west-2.amazonaws.com/a95e1e6d-ab5d-426a-b5b6-652ced6dcd2a/d2520981-ae64-41c7-b76b-2716e4e6dfcd/%E6%B7%B1%E5%B1%A4%E7%94%9F%E6%88%90%E3%81%A6%E3%82%99%E4%BD%BF%E3%81%86%E7%A2%BA%E7%8E%87%E8%AB%96_%282%29.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45HZZMZUHI%2F20240118%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20240118T043703Z&X-Amz-Expires=3600&X-Amz-Signature=092cdbdb1fdf76d65f7e2db34f2935d331ad4b41a64d9e36da0b16570d558d3c&X-Amz-SignedHeaders=host&x-id=GetObject)


[file]()


# ゴール


拡散モデルとシミュレーティッドアニーリングの関係を理解する


# Abstract


機械学習の中心的な問題は、学習、サンプリング、推論、評価が依然として解析的または計算的に扱いやすい、柔軟性の高い確率分布の族を用いて、複雑なデータセットをモデル化することである。ここでは、柔軟性と扱いやすさを同時に実現するアプローチを開発する。非平衡統計物理学に触発された本質的な考え方は、反復的な順拡散過程を通じて、データ分布の構造を系統的かつゆっくりと破壊することである。そして、データの構造を復元する逆拡散過程を学習し、データの柔軟性と扱いやすさの高い生成モデルを得る。この手法により、数千の層や時間ステップを持つ深い生成モデルで確率を高速に学習、サンプリング、評価し、学習したモデルの下で条件付き確率や事後確率を計算することができる。さらに、このアルゴリズムのオープンソースのリファレンス実装を公開する。


# 1. Introduction

- 以下がトレードオフ
        - 扱いやすさ = 解析性
        - 柔軟性 = 元のデータセットの構造に対して幅広く適用できる
                - モンテカルロしないといけない

## 1.1. Diffusion probabilistic models

- 以下のようなモデルを提示するそう
        - 超柔軟
        - サンプリングが正確 (?)
        - 事後分布を計算するために、他の分布と容易に乗算できること (?)
        - モデルの対数尤度と個々の状態の確率を安価に評価できること (?)
- マルコフ連鎖である分布を別の分布に徐々に変換する
        - 拡散過程を用いて単純な既知の分布(ガウス分布とか)を目標のデータ分布に変換するマルコフ連鎖を構築する
        - 各ステップも連鎖の全体も解析的に評価できる
- estimating small perturbations (?)
- explicitly describing the full distribution with a single, non-analytically-normalizable, potential function. (?)
        - 分配関数が、数式でかけないくらいの意味
- We demonstrate the utility of these diffusion probabilistic models by training high log likelihood models for a twodimensional swiss roll, binary sequence, handwritten digit
(MNIST), and several natural image (CIFAR-10, bark, and
dead leaves) datasets.
        - Swiss roll ⇒ 渦巻き状の線形分離できないようなデータセットのこと
- posterior probability 事後確率
- prior probability 事前確率
- marginal probability distribution 周辺確率密度

## 一般定理
### ガウス積分
$$
\int_{-\infty}^{\infty} \exp{\left(-a(x-b)^2\right)} dx = \sqrt{\frac{\pi}{a}}
\quad \operatorname{Re}\{a\}>0, b \in \mathbb{C}
$$

## 用語


### 可測空間

- 組み $(\Omega, F)$
        - $\Omega$ : set
        - $F$ : 完全加法族
                - 完全加法性を満たす、$\Omega$の冪集合の部分集合

### 可測写像

- $(\Omega, F), (\Psi, G): 可測空間$
        - $f: (\Omega, F) \to (\Psi, G)$ で以下を満たす
        - $\forall A \in G \space f^{-1}(A) \in F$
        - ** $f: (\Omega, F) \to (\Psi, G)$ こう書いたときの実態は $f: F \to G$

### 測度空間

- 組み$(\Omega, F, \mu)$
        - $\mu:F\to \mathbb{R}_{\geq0}$
                - 可算加法性を満たす
                        - $\displaystyle \forall i,j \in \mathbb{N}, A_i, A_j \in F \space A_i \cup A_j = \empty \implies \mu\left(\bigcup_{i} A_{i} \right) = \sum_{i} \mu\left(A_{i} \right)$

### 実数 (測度空間の具体例)

- $(\mathbb{R},B(\mathbb{R}),\mu)$
        - $B(\mathbb{R}):ボレル集合族$
                - $\mathbb{R}上の距離から定まる位相を含む最小の完全加法族$
        - $\mu: ルベーグ測度$
                - 距離から自然に定まる「長さ」
                - $\mu([0,1]) = 1$
                - $\mu([a, b]) = b - a$

### 確率空間

- 測度空間 $(\Omega, F, P)$で以下を満たすもの
        - $P\left(\Omega\right) = 1$
- $\Omega$ を**標本空間**という
        - $\Omega$の元を**標本**という
- $F$ を**事象の全体**という
        - $F$の元を**事象**という
- $P$ を**確率測度**という

### 確率変数 (random variety)

- $X: \Omega \to \mathbb{R}$ で、以下を満たすもの
  - 可測である。つまり、$\forall \omega \in \mathfrak{B}(\mathbb{R}), X^{-1}(\omega) \in F$

### $X$に由来する確率測度
確率空間$(\Omega, F, P)$と確率変数$X$について、

$$P_{X}: \mathfrak{B}(\mathbb{R}) \to [0,1],\ A \mapsto P(X^{-1}(A))$$

が定まり、
$(\mathbb{R},\mathfrak{B}(\mathbb{R}),P_X)$は確率空間になっている

### d変数確率変数 (random variety)
$X_{1}, \dots ,X_{d}:1変数確率変数$

$$
(X_{1}, \dots ,X_{d}): (\Omega, F)\to (\mathbb{R}^d,\mathfrak{B}(\mathbb{R}^d)), \  \omega \mapsto (X_{1}(\omega), \dots,X_{d}(\omega))
$$

### $(X_{1}, \dots ,X_{d})$に由来する確率測度
確率空間$(\Omega, F, P)$とd変数確率変数$(X_{1}, \dots ,X_{d})$について、

$$P_{(X_{1}, \dots ,X_{d})}: \mathfrak{B}(\mathbb{R^{d}}) \to [0,1],\ A \mapsto P((X_{1}, \dots ,X_{d})^{-1}(A))$$

が定まり、
$(\mathbb{R},\mathfrak{B}(\mathbb{R}),P_X)$は確率空間になっている


### Lebesgueの分解定理
確率空間$(\Omega, F, P)$と確率変数$X$について、

$(\mathbb{R},\mathfrak{B}(\mathbb{R}), P_{X})$: 確率空間 が定まる。


$\mu: \mathfrak{B}(\mathbb{R}) \rightarrow \mathbb{R}$ を Lebegue Measure とする.
$$
P_X=P_{X_{abs}}+P_{X_{sing}}+P_{X_{dis}} \ s.t.
$$
- $P_{X_{abs}}$ は $\mu$ について、 absolutely conti.
    - すなわち、 $\mu(A)=0$ ならば $P_{X_{abs}}(A)=0(\forall A \in B(\mathbb{R}))$
- $P_{X_{sing}}$ は $\mu$ について、conti. かつ、 singular.
    - すなわち、 $P_{X_{sing}}(a)=0(\forall a \in \mathbb{R})$ かつ、 $\exists A \in A(\mathbb{R})$ s.t. $\mu(A)=0$ and $P_{X_{sing}}\left(A^c\right)=0$
- $P_{X_{dis}}$ は $\mu$ について、 discrete.
    - すなわち、 $\exists\left\{a_n\right\}_{n=1}^{\infty} \subset \mathbb{R}$ s.t. $P_{X_{dis}}=\sum_{i=1}^{\infty} a_i \chi_{P_i}(A)$ $\left(\right.$ ただし、 $\chi_{P_i}: B(\mathbb{R}) \rightarrow \mathbb{R}, \chi_{P_i}(A):=\left\{\begin{array}{l}0\left(p_i \notin A\right) \\ 1\left(p_i \in A\right)\end{array}\right)$

と一意に分解できる.

- 拡散モデルの数理を読む上ではPabsだけ考えるでOK

#### 多変数の場合
確率空間$(\Omega, F, P)$と確率変数$(X_{1},\dots,X_{d})$について、

$(\mathbb{R^{d}},\mathfrak{B}(\mathbb{R^{d}}), P_{(X_{1},\dots,X_{d})})$: 確率空間 が定まる。

$\mu: \mathfrak{B}(\mathbb{R^{d}}) \rightarrow \mathbb{R}$ を Lebegue Measure とする.

以下は、1変数の場合と同様。

### Radon-Nikodymの定理
$X$: 確率変数

Lebegue の $P_{X_{abs}}$ について、以下を満たす Integrable な関数 $p_{X_{abs}}: \mathbb{R} \to \mathbb{R}_{\geq 0}$ が存在する。
$$
\int_{-\infty}^x p_{X_{abs}}\left(x^{\prime}\right) d x^{\prime}=P_{X_{abs}}(X \leq x)
$$

この $P_{X_{abs}}$ を、確率密度関数 (Probabilty Density Function) と呼ぶ。

- 気温が20度から30度になる確率を求めたい時に、
        - 「気温x度」を実数xにマップする ← 確率変数という
        - 実数直線上で20-30の区間で積分する

#### 多変数の場合
確率空間$(\Omega, F, P)$と$(X_{1},\dots,X_{d})$: d変数確率変数について、

$(\mathbb{R},\mathfrak{B}(\mathbb{R}), P_{(X_{1},\dots,X_{d})})$: 確率空間 が定まる。

Lebegue の $P_{(X_{1}, \dots ,X_{d})_{abs}}$ について、以下を満たす Integrable な関数 $p^{joint}_{(X_{1}, \dots ,X_{d})_{abs}}: \mathbb{R}^{d} \rightarrow \mathbb{R}_{\geq 0}$ が存在する。
$$
\int_{-\infty}^{x_{1}} \cdots \int_{-\infty}^{x_{d}} p^{joint}_{(X_{1}, \dots ,X_{d})_{abs}}\left(x^{\prime}\right) d x^{\prime}=P_{(X_{1}, \dots ,X_{d})_{abs}}(X_{1} \leq x_{1} \land \dots \land X_{d} \leq x_{d})
$$

この $p^{joint}_{(X_{1}, \dots ,X_{d})_{abs}}$ を、結合確率密度関数 (Joint Probabilty Density Function) と呼ぶ。

> [フビニの定理](https://ja.wikipedia.org/wiki/%E3%83%95%E3%83%93%E3%83%8B%E3%81%AE%E5%AE%9A%E7%90%86) により、$\mathbb{R}^{d}$についての積分はd回の$\mathbb{R}$についての積分と等しくなる。

$X_{1}, \dots ,X_{d}$ は互いに入れ替え可能である。
特に、$d=2$の場合、
$$
p^{joint}_{(X_{1}, X_{2})_{abs}}(x_{1}, x_{2})=p^{joint}_{(X_{2}, X_{1})_{abs}}(x_{2}, x_{1})
$$

### Radon-Nikodymの定理の逆
$Claim.$

$d \in \Z_{\geq 1}$に対して、確率密度関数 $p: \mathbb{R}^{d} \to \mathbb{R}_{\geq 0}$ が存在するとき、確率空間$(\mathbb{R}^{d},\mathfrak{B}(\mathbb{R}^{d}), P_{(X_{1}, \dots ,X_{d})_{abs}})$が存在する。

ただし、$1 \leq i \leq d$ に対して、 $X_{i} := \text{pr}_{i}: \mathbb{R}^{d} \to \mathbb{R}$ (射影)

$Proofの概要$

確率空間を構成する。

- $P_{(X_{1}, \dots ,X_{d})_{abs}}(X_{1} \leq x_{1} \land \dots \land X_{d} \leq x_{d})
        := \int_{-\infty}^{x^{}_{1}} \cdots \int_{-\infty}^{x_{d}}
                p(x^{\prime}_{1}, \dots ,x^{\prime}_{d}) dx^{\prime}_{1} \cdots dx^{\prime}_{d}$
- $\prod_{i}(-\infty, x_{i}]$ は $\mathfrak{B}(\mathbb{R}^{d})$ の生成元
- よって、$P_{(X_{1}, \dots ,X_{d})_{abs}}$ は $\mathfrak{B}(\mathbb{R}^{d})$ 上の確率測度

### 累積分布関数

- 確率密度関数を$-\infty$から$x$まで積分したもの


### 確率質量関数 (= Px3の時に確率分布って適当に書かれてたらこれ)


$$
p_{x_{dis}}:\mathbb{R} \to [0,1] \\ x \mapsto P_{x_{3}}(\{x\})
$$


### d変数確率密度関数

Radon-Nikodymの定理の多変数版から定まる
$$p_{(X_{1}, \dots ,X_{d})_{abs}}: \mathbb{R}^{d} \rightarrow \mathbb{R}_{\geq 0}$$

---
↓一つの確率測度(確率分布)$P$について述べている

### 平均情報量(エントロピー)
$(\Omega, F, P): 確率空間$

$X: 確率変数$

$(\mathbb{R}, \mathfrak{B}(\mathbb{R}),P_{X})$: 上記から定まる確率空間

$$
H^{P}_{entropy}(X) := H_{entropy}(p_{X_{abs}}) := -\int_{x \in X} dx \ p_{X_{abs}}(x) \log p_{X_{abs}}(x)
$$

##### エントロピーの値の範囲
$$
0 \leq H_{entropy}(p_{X_{abs}}) （誤り）
$$



### 結合エントロピー (joint entropy)

確率空間$(\mathbb{R}, \mathfrak{B}(\mathbb{R}),P)$
確率変数$X, Y$について、

$$
\begin{align*}
H^{P}_{joint}(X, Y) := H_{joint}(p^{joint}_{(X, Y)_{abs}}) &:= -\int_{x \in X, y \in Y} dxdy \ p^{joint}_{(X, Y)_{abs}}(x, y) \log \left(p^{joint}_{(X, Y)_{abs}}(x, y)\right)
\end{align*}
$$

定義から直ちに、
$$
H_{joint}(Y, X) = H_{joint}(X, Y) \hspace{40pt} 論文(25)
$$
がいえる。

### 条件付き確率

$(\Omega, F, P): 確率空間, A, B \in F$について、


$P_{condi}(\cdot\mid\cdot):F\times F\to[0,1]$


$$
P_{condi}(A|B):=\frac{\mathrm{P}(A \cap B)}{\mathrm{P}(B)}
$$


### 条件つき確率密度関数
確率空間$(\mathbb{R}, \mathfrak{B}(\mathbb{R}),P)$

$(Y_{1}, Y_{2})$: 1変数確率変数$Y_{1}, Y_{2}$によって定まる2変数確率変数

$p^{condi}_{(Y_{1}, Y_{2})_{abs}}(\cdot\mid\cdot):\mathbb{R}\times\mathbb{R} \to \mathbb{R}_{\geq 0}$


$$
p^{condi}_{(Y_{1}, Y_{2})_{abs}}(y_{1} \mid y_{2}):= \frac{p^{joint}_{(Y_{1}, Y_{2})_{abs}}(y_{1}, y_{2})}{p_{Y_{2\ abs}}(y_{2})}
$$

### 条件付きエントロピー (conditional entropy)

確率空間$(\mathbb{R}, \mathfrak{B}(\mathbb{R}),P)$

確率変数$X, Y$について、


$$
\begin{align*}
H^{P}_{condi}(Y|X) &:= -\int_{x \in X, y \in Y} dxdy \ p^{joint}_{(Y, X)_{abs}}(y, x) \log \left(\frac{p^{joint}_{(Y, X)_{abs}}(y, x)}{p_{X_{abs}}(x)}\right) \\
&= -\int_{x \in X, y \in Y} dxdy \ p^{joint}_{(Y, X)_{abs}}(y, x) \log \left(p^{condi}_{(Y,X)_{abs}}(y \mid x)\right) \\
\end{align*}
$$

$Claim$

以下が成り立つ
$$
H^{P}_{condi}\left(Y \mid X\right)=H^{P}_{condi}\left(X \mid Y\right)+H^{P}_{entropy}\left(Y\right)-H^{P}_{entropy}\left(X\right)
$$
$Proof.$
$$
\begin{align*}
(右辺) &= H^{P}_{condi}\left(X \mid Y\right)+H^{P}_{entropy}\left(Y\right)-H^{P}_{entropy}\left(X\right) \\

&= -\int_{x \in X, y \in Y} dxdy \ p^{joint}_{(X, Y)_{abs}}(x, y) \log \left(p^{condi}_{(X, Y)_{abs}}(x \mid y)\right)  - \int_{y \in Y} dy \ p_{Y_{abs}}(y) \log p_{Y_{abs}}(y) +\int_{x \in X} dx \ p_{X_{abs}}(x) \log p_{X_{abs}}(x) \hspace{40pt} (∵def.) \\

&= -\int_{x \in X, y \in Y} dxdy \ p^{joint}_{(X, Y)_{abs}}(x, y) \cdot \log \left(\frac{
        p^{joint}_{(X, Y)_{abs}}(x, y)
}{
        p_{Y_{abs}}(y)
}\right)  - \int_{y \in Y} dy \ p_{Y_{abs}}(y) \log p_{Y_{abs}}(y) +\int_{x \in X} dx \ p_{X_{abs}}(x) \log p_{X_{abs}}(x) \hspace{40pt} (∵p_{joint}のdef.) \\

&= -\int_{x \in X, y \in Y} dxdy \ \left(
        p^{joint}_{(X, Y)_{abs}}(x, y) \cdot \left(
                \log \left(p^{joint}_{(X, Y)_{abs}}(x, y)\right) - \log \left(p_{Y_{abs}}(y)\right)
        \right)
\right)
 - \int_{y \in Y} dy \ p_{Y_{abs}}(y) \log p_{Y_{abs}}(y) +\int_{x \in X} dx \ p_{X_{abs}}(x) \log p_{X_{abs}}(x) \\

&= -\int_{x \in X, y \in Y} dxdy \ \left(
        p^{joint}_{(X, Y)_{abs}}(x, y) \cdot \left(\log \left(p^{joint}_{(X, Y)_{abs}}(x, y)\right)\right)
\right)
\underbrace{
        + \int_{x \in X, y \in Y} dxdy \ \left(
                p^{joint}_{(X, Y)_{abs}}(x, y) \cdot \left(
                        \log \left(p_{Y_{abs}}(y)\right)
                \right)
        \right)
}_{
        \cancel{
                + \int_{y \in Y} dy \ \left(
                        p_{Y_{abs}}(y) \cdot \left(
                                \log \left(p_{Y_{abs}}(y)\right)
                        \right)

                \right)
        }
}
 \cancel{- \int_{y \in Y} dy \ p_{Y_{abs}}(y) \log p_{Y_{abs}}(y)}
 + \int_{x \in X} dx \ p_{X_{abs}}(x) \log p_{X_{abs}}(x)
\\
&= -\int_{x \in X, y \in Y} dxdy \ \left(
        p^{joint}_{(X, Y)_{abs}}(x, y) \cdot \left(\log \left(p^{joint}_{(X, Y)_{abs}}(x, y)\right)\right)
\right)
+ \int_{x \in X} dx \ p_{X_{abs}}(x) \log p_{X_{abs}}(x)
\\
&= -\int_{x \in X, y \in Y} dxdy \ \left(
        p^{joint}_{(X, Y)_{abs}}(x, y) \cdot \left(\log \left(p^{joint}_{(X, Y)_{abs}}(x, y)\right)\right)
\right)
+ \int_{x \in X, y \in Y} dxdy \ \left(
        p^{joint}_{(X, Y)_{abs}}(x, y) \cdot \left(\log \left(p_{X_{abs}}(x)\right)\right)
\right) \\
&= -\int_{x \in X, y \in Y} dxdy \ \left(
        p^{joint}_{(X, Y)_{abs}}(x, y) \cdot \left(\log \left(\frac{
                p^{joint}_{(X, Y)_{abs}}(x, y)
        }{
                p_{X_{abs}}(x)
        }\right)\right)
\right)
&= -\int_{x \in X, y \in Y} dxdy \ \left(
        p^{joint}_{(Y, X)_{abs}}(y, x) \cdot \left(\log \left(\frac{
                p^{joint}_{(Y, X)_{abs}}(y, x)
        }{
                p_{X_{abs}}(x)
        }\right)\right)
\right)

\\
&= H^{P}_{condi}\left(Y \mid X\right) \hspace{40pt} (論文(27))

\end{align*}
$$
$Q.E.D.$

$Claim$

以下が成り立つ、
$$
H^{P}_{condi}\left(X \mid Y\right) = H^{P}_{join}\left(X, Y\right) - H^{P}_{entropy}\left(Y\right)
$$
$Proof.$
$$
\begin{align*}
(右辺) &= H^{P}_{join}\left(X, Y\right) - H^{P}_{entropy}\left(Y\right) \\
&=
-\int_{x \in X, y \in Y} dxdy \
        p^{joint}_{(X, Y)_{abs}}(x, y) \log \left(p^{joint}_{(X, Y)_{abs}}(x, y)\right)
- \left(
        -\int_{y \in Y} dy \
                p_{Y_{abs}}(y) \log p_{Y_{abs}}(y)
\right) \\
&=
-\int_{x \in X, y \in Y} dxdy \
        p^{joint}_{(X, Y)_{abs}}(x, y) \log \left(p^{joint}_{(X, Y)_{abs}}(x, y)\right)
- \left(
        - \int_{x \in X, y \in Y} dxdy \
                p^{joint}_{(X, Y)_{abs}}(x, y) \log p_{Y_{abs}}(y)
\right) \\
&=
-\int_{x \in X, y \in Y} dxdy \
        p^{joint}_{(X, Y)_{abs}}(x, y) \left(
                \log \left(p^{joint}_{(X, Y)_{abs}}(x, y)\right)
                -
                \log p_{Y_{abs}}(y)
        \right) \\
&=
-\int_{x \in X, y \in Y} dxdy \
        p^{joint}_{(X, Y)_{abs}}(x, y) \log \left(\frac{
                p^{joint}_{(X, Y)_{abs}}(x, y)
        }{
                p_{Y_{abs}}(y)
        }\right) \\
&= H^{P}_{condi}\left(X \mid Y\right)
\end{align*}
$$
### 相互情報量 (Mutual information)

確率空間$(\mathbb{R}, \mathfrak{B}(\mathbb{R}),P)$, 確率変数$X, Y$について、


$$
\begin{align*}
I(Y;X) &:= \int_{x \in X, y \in Y} dxdy \ p^{joint}_{(Y, X)_{abs}}(y, x) \log \left(\frac{p^{joint}_{(Y, X)_{abs}}(y, x)}{p_{Y_{abs}}(y)p_{X_{abs}}(x)}\right)     
\end{align*}
$$

(ざっくりとは、X,Yが独立でない場合の「情報量の重なり」みたいなもの)

$Claim$

相互情報量と結合エントロピーについて以下が成り立つ、

確率空間$(\mathbb{R}, \mathfrak{B}(\mathbb{R}),P)$,
確率変数$X, Y$について、
$$
H^{P}_{joint}\left(X, Y\right)=H^{P}_{entropy}\left(X\right)+H^{P}_{entropy}\left(Y\right)-I\left(Y;X\right)
$$
$proof.$
$$
\begin{align*}
(右辺) &= H^{P}_{entropy}\left(X\right)+H^{P}_{entropy}\left(Y\right)-I\left(Y;X\right) \\
&=
-\int_{x \in X} dx \ 
        p_{X_{abs}}(x) \log \left(p_{X_{abs}}(x)\right)
-\int_{y \in Y} dy \ 
        p_{Y_{abs}}(y) \log \left(p_{Y_{abs}}(y)\right)
+\int_{x \in X, y \in Y} dxdy \ 
        p^{joint}_{(X, Y)_{abs}}(x, y) \log \left(\frac{p^{joint}_{(X, Y)_{abs}}(x, y)}{p_{Y_{abs}}(y)p_{X_{abs}}(x)}\right) \\
&=
-\int_{x \in X} dxdy \ 
        p_{X_{abs}}(x) \log \left(p_{X_{abs}}(x)\right)
-\int_{y \in Y} dxdy \ 
        p_{Y_{abs}}(y) \log \left(p_{Y_{abs}}(y)\right)
-\int_{x \in X, y \in Y} dxdy \ 
        p^{joint}_{(X, Y)_{abs}}(x, y) \left(
                \log \left(p^{joint}_{(X, Y)_{abs}}(x, y)\right)
                -
                \log \left(p_{Y_{abs}}(y)\right)
                -
                \log \left(p_{X_{abs}}(x)\right)
        \right) \\
&=
\cancel{
        -\int_{x \in X} dxdy \ 
                p_{X_{abs}}(x) \log \left(p_{X_{abs}}(x)\right)
}
+\underbrace{
        \int_{x \in X, y \in Y} dxdy \ 
                p^{joint}_{(X, Y)_{abs}}(x, y) \log \left(p_{X_{abs}}(x)\right)
}_{
        \cancel{
                \int_{x \in X} dxdy \ 
                        p_{X_{abs}}(x) \log \left(p_{X_{abs}}(x)\right)
        }
}
\cancel{
        -\int_{y \in Y} dxdy \ 
                p_{Y_{abs}}(y) \log \left(p_{Y_{abs}}(y)\right)
}
+\underbrace{
        \int_{x \in X, y \in Y} dxdy \ 
                p^{joint}_{(X, Y)_{abs}}(x, y) \log \left(p_{Y_{abs}}(y)\right)
}_{
        \cancel{
                \int_{y \in Y} dxdy \ 
                        p_{Y_{abs}}(y) \log \left(p_{Y_{abs}}(y)\right)
        }
}
-\int_{x \in X, y \in Y} dxdy \ 
        p^{joint}_{(X, Y)_{abs}}(x, y) \left(
                \log \left(p^{joint}_{(X, Y)_{abs}}(x, y)\right)
        \right) \\
&=
-\int_{x \in X, y \in Y} dxdy \ 
        p^{joint}_{(X, Y)_{abs}}(x, y) \left(
                \log \left(p^{joint}_{(X, Y)_{abs}}(x, y)\right)
        \right) \\
&= H^{P}_{joint}\left(X, Y\right)
\end{align*}
$$
$Q.E.D.$

$Claim$

$p^{joint}_{(X, Y)_{abs}}(x, y) \leq p_{X_{abs}}(x)$ のとき以下が成り立つ、
$$
H^{P}_{joint}\left(X, Y\right) - H^{P}_{entropy}\left(X\right) \geq 0
$$
$Proof.$
$$
\begin{align*}
H^{P}_{joint}\left(X, Y\right) - H^{P}_{entropy}\left(X\right) &= H^{P}_{condi}\left(Y \mid X\right) \ (\because 上記のclaim) \\
&=
-\int_{x \in X, y \in Y} dxdy \ 
        p^{joint}_{(X, Y)_{abs}}(x, y) \log \left(\frac{
                p^{joint}_{(X, Y)_{abs}}(x, y)
        }{
                p_{X_{abs}}(x)
        }\right) \\
&\geq 0 \ (\because \frac{
                p^{joint}_{(X, Y)_{abs}}(x, y)
        }{
                p_{X_{abs}}(x)
        } \leq 1)
\end{align*}
$$
$Q.E.D.$

---
↓２つの確率測度(確率分布)$P, Q$について述べている

### 交差エントロピー (cross entropy)

$X$: 可測空間$(\Omega, F)$上の確率変数

$(\Omega, F, P),(\Omega,F, Q)$: 確率空間

$(\mathbb{R}, \mathfrak{B}(\mathbb{R}),P_{X}), (\mathbb{R}, \mathfrak{B}(\mathbb{R}),Q_{X})$: 上記から定まる確率空間

について、


$$
\begin{align*}
H_{cross}(P_{X}, Q_{X}) &:= -\sum_{i=1}^{\infty} p_{X_{dis}}\left(x_i\right) \log \left(q_{X_{dis}}\left(x_i\right)\right) - \int_{x \in \mathbb{R}} dx \ p_{X_{abs}}(x)log(q_{X_{abs}}(x))
\end{align*}
$$

$p_{X_{dis}}=q_{X_{dis}}=0$のとき、
$$
H_{cross}(p_{X_{abs}}, q_{X_{abs}}) := H_{cross}(P_{X}, Q_{X})
$$
ともかく。

### KL-ダイバージェンス

$X$: 可測空間$(\Omega, F)$上の確率変数

$(\Omega, F, P),(\Omega,F, Q)$: 確率空間

$(\mathbb{R},\mathfrak{B}(\mathbb{R}), P_{X}), (\mathbb{R},\mathfrak{B}(\mathbb{R}), Q_{X})$: 上記から定まる確率空間

について、
$$
D_{K L}(P_{X} \| Q_{X}):=\sum_{i=1}^{\infty} p_{X_{dis}}\left(x_i\right) \log \frac{p_{X_{dis}}\left(x_i\right)}{q_{X_{dis}}\left(x_i\right)}+\int_{\mathbb{R}} p_{X_{abs}}(x) \log \frac{p_{X_{abs}}(x)}{q_{X_{abs}}(x)} d x
$$

$p_{X_{dis}}=q_{X_{dis}}=0$のとき、
$$
D_{K L}(p_{X_{abs}} \| q_{X_{abs}}) := D_{K L}(P_{X} \| Q_{X})
$$
ともかく。

##### 確率変数が複数ある状況の場合
$X, Y$: 可測空間$(\Omega, F)$上の確率変数

$(\Omega, F, P)$: 確率空間

を考えると、

$id_{\mathbb{R}}$: 可測空間$(\mathbb{R},\mathfrak{B}(\mathbb{R}))$上の確率変数 (恒等写像)

$(\mathbb{R},\mathfrak{B}(\mathbb{R}), P_{X}),(\mathbb{R},\mathfrak{B}(\mathbb{R}), P_{Y})$: 確率空間

$(\mathbb{R},\mathfrak{B}(\mathbb{R}), (P_{X})_{id_{\mathbb{R}}}), (\mathbb{R},\mathfrak{B}(\mathbb{R}), (Q_{X})_{id_{\mathbb{R}}})$: 確率空間

として、KL-ダイバージェンス を考えることができる。




---


### parametricな問題


$$
{ }^{\exists} p: \mathbb{R} \times \mathbb{R} \rightarrow \mathbb{R}, \quad(x, \theta) \mapsto p_\theta(x), 具体的に計算可能, \\ { }^{\exists} \theta_0 \in \mathbb{R} \text { s.t. } p_{X_{abs}}=p_{\theta_0}
$$


$p_{X_{abs}}$を求める問題をparametricな問題という


($p_{x_{3}}$についてもだいたい同じ)


### likelihood function


$\left(x_i\right)_{i=1}^n$: n回のtrial が与えられた時、


$$
L: \mathbb{R} \rightarrow \mathbb{R}, \quad \theta \mapsto \prod_{i=1}^n p\left(x_i, \theta\right)
$$


### log-likelihood function


$\left(x_i\right)_{i=1}^n$: n回のtrial が与えられた時、


$$
L_{\log}: \mathbb{R} \rightarrow \mathbb{R}, \quad \theta \mapsto \sum_{i=1}^n  \log(p\left(x_i, \theta\right))
$$


### likelihood estimation


$L, L_{\log}$の最大値、もしくは極値を求める


コイン投げの場合、尤度関数は上に凸なので、極値が求まれば良い


---


## Sanovの定理[https://genkuroki.github.io/documents/20160616KullbackLeibler.pdf](https://genkuroki.github.io/documents/20160616KullbackLeibler.pdf)



参考) [https://genkuroki.github.io/documents/mathtodon/2017-04-27 Kullback-Leibler情報量とは何か？.pdf](https://genkuroki.github.io/documents/mathtodon/2017-04-27%20Kullback-Leibler%E6%83%85%E5%A0%B1%E9%87%8F%E3%81%A8%E3%81%AF%E4%BD%95%E3%81%8B%EF%BC%9F.pdf)


### 経験分布


r面サイコロを振るということを考える


$$
\mathcal{P}=\left\{p=\left(p_1, \ldots, p_r\right) \in \mathbb{R}^r \mid p_1, \ldots, p_r \geqq 0, p_1+\cdots+p_r=1\right\}
$$


と定めると、$\mathcal{P}$は、有限集合 $\{1, ..., r\}$上の確率質量関数の集合と同一視できる。


$q = (q_{1},...,q_{r}) \in \mathcal{P}$ を固定する。これはあるサイコロqを固定するということ。


 $\Omega_{q} := \{サイコロqを投げた時にiが出る \mid i=1, ..., r\}$


確率空間: $((\Omega_{q})^{n}, F_{q}^{n} = 2^{(\Omega_{q})^{n}}, P^{n})$


$X \in F_{q}^{n}$は、


$$
X = \{(\ell_{i}^{1})_{i=1,...,n} ,...,  (\ell_{i}^{j})_{i=1,...,n}\} \\ \left(j=0,...,r^{n}, 1 \leq \ell_{i}^{j} \leq r, ただしj=0の時はX=\empty \right)
$$


    と書ける


$$
r^{n}: 全ての根源事象の数 \\
(\ell_{i}^{j})_{i=1,...,n}: ある事象Xの中で、i回目に\ell_{i}^{j}が出るようなj番目の根源事象
$$


$P^{n}: F_{q}^{n}\to\mathbb{R} $ を、


$$
P^{n}(\{(\ell_{i}^{1})_{i=1,...,n} ,...,  (\ell_{i}^{j})_{i=1,...,n}\}):= (q_{\ell^{1}_{1}} q_{\ell^{1}_{2}} \cdots q_{\ell^{1}_{n}}) + \cdots + (q_{\ell^{j}_{1}} q_{\ell^{j}_{2}} \cdots q_{\ell^{j}_{n}})
$$


と定める。


$(k_{i})_{i=1,...,n}$について、


$$
X_{(k_{w})_{w=1,...,r}} := \{(\ell_{i}^{j})_{i=1,...,n}|^\forall w \left( (\ell_{i}^{j} = wとなる個数) = k_{w} \right) \}
$$


なる事象の起こる確率は、$\#X_{(k_{w})_{w=1,...,r}} = \frac{n !}{k_{1} ! \cdots k_{r} !}$なので、


$$
P^n(X_{(k_{w})_{w=1,...,r}}) = \frac{n !}{k_{1} ! \cdots k_{r} !} q_1^{k_1} \cdots q_r^{k_r}
$$


となる。


ここで、集合$\mathcal{P}_{n}$を、


$$
\mathcal{P}_n=\left\{\left(\frac{k_1}{n}, \ldots, \frac{k_r}{n}\right) \mid k_i=0,1, \ldots, n, k_1+\cdots+k_r=n\right\}
$$


と定めると、


$$
\mathcal{P}_n \subset \mathcal{P}
$$


であり、$\#\mathcal{P}_{n} \leq (n+1)^r$ である。


このような$\mathcal{P}_n$の元を、


$$
X_{(k_{i})_{i=1,...,n}}に対しての経験分布
$$


という。


### Sanovの定理


$q = (q_{1},...,q_{r}) \in \mathcal{P}$と、上記の記号の元、確率空間$(\mathcal{P}_{n}, 2^{\mathcal{P}_{n}}, P_{\mathcal{P}_{n}, q})$を考える


確率測度は以下のように定める


$$
P_{\mathcal{P}_{n}, q}^{\prime}:\mathcal{P}_{n} の一点集合の集合\to\mathbb{R} \\ \{\left(\frac{k_1}{n}, \ldots, \frac{k_r}{n}\right)\} \mapsto \frac{n !}{k_{1} ! \cdots k_{r} !} q_1^{k_1} \cdots q_r^{k_r}
$$


$$
P_{\mathcal{P}_{n}, q}:2^{\mathcal{P}_{n}}\to\mathbb{R} \\ \{x_{1},...,x_{k}\} \mapsto \sum_{i}^{k}P_{\mathcal{P}_{n}, q}^{\prime}(\{x_{i}\})
$$


(1) $A \subset \mathcal{P}$ がopenである時


$$
\liminf _{n \rightarrow \infty} \frac{1}{n} \log P_{\mathcal{P}_n, q}\left( A\cap\mathcal{P}_n\right) \geqq-\inf _{p \in A} D_{KL}(p \| q)
$$


Aを大きくすると、


((左辺)の$\frac{1}{n} \log P_{\mathcal{P}_n, q}\left( A\cap\mathcal{P}_n\right)$)は、大きくなるか変わらない


(右辺)は、大きくなるか変わらない


(2) $A \subset \mathcal{P}$について、


$$
\limsup _{n \rightarrow \infty} \frac{1}{n} \log P_{\mathcal{P}_n, q}\left(A\cap\mathcal{P}_n\right) \leqq-\inf _{p \in A} D_{KL}(p \| q)
$$


(3) $A \subset \mathcal{P}$が、内部が閉包に含まれるならば、


$$
\lim_{n \rightarrow \infty} \frac{1}{n} \log P_{\mathcal{P}_n, q}\left(A\cap\mathcal{P}_n\right) =-\inf _{p \in A} D_{KL}(p \| q)
$$

- 仮説Aをとる
    - Aは絞られてるほうが、実用上「いい仮説」と言える
            - が、Sanovの定理ではそこは興味ない
    - $P_{\mathcal{P}_n, q}\left(A\cap\mathcal{P}_n\right) $ : n回試行時の経験分布がAに入る確率

    → n回振って得られた経験分布を何個も取得して、$P_{\mathcal{P}_n, q}\left(A\cap\mathcal{P}_n\right) $を定める

    - 左辺のnをどんどん大きくして、収束する値によって、Aの「正解っぽさ」がわかる
            - もし0に収束しているのならば、Aに真の分布qが含まれていることがわかる

## 1.2. Relationship to other work


飛ばす


# 2. Algorithm

- 順拡散過程と逆拡散過程の定義
- 逆拡散過程の学習方法
- 逆拡散過程のentropy bounds(エントロピー下界？)を導出する

### マルコフ拡散カーネル ([Markov kernel](https://en.wikipedia.org/wiki/Markov_kernel), [積分変換](https://ja.wikipedia.org/wiki/%E7%A9%8D%E5%88%86%E5%A4%89%E6%8F%9B))


$T_{\pi}: \mathbb{R}^{n}\times\mathbb{R}^{n}\times\mathbb{R}\to\mathbb{R}_{\geq 0},\ \left(\mathbf{y} , \mathbf{y}^{\prime} , \beta\right) \mapsto \left(\mathbf{y} \mid \mathbf{y}^{\prime} ; \beta\right)$　($\beta$は、拡散率)

$T_{\pi}$は、$d \in \mathbf{Z}_{\geq 1}$として、任意の$n \cdot d$変数確率密度関数 $q: \mathbb{R}^{n \cdot d}\to\mathbb{R}$ に対して、
$$
q(x_{1}, \dots, x_{d}) \cdot T_{\pi}\left(x_{d+1} \mid x_{d} ; \beta\right) はn \cdot (d+1)変数確率密度関数 \\


$$

$\pi: \mathbb{R}^{n}\to\mathbb{R}$ は、以下の[第二種フレドホルム積分方程式](https://ja.wikipedia.org/wiki/%E3%83%95%E3%83%AC%E3%83%89%E3%83%9B%E3%83%AB%E3%83%A0%E7%A9%8D%E5%88%86%E6%96%B9%E7%A8%8B%E5%BC%8F)の解
$$
\begin{aligned}
\pi(\mathbf{y}) & =\int d \mathbf{y}^{\prime} T_\pi\left(\mathbf{y} \mid \mathbf{y}^{\prime} ; \beta\right) \pi\left(\mathbf{y}^{\prime}\right)
\end{aligned}
$$

- [https://ja.wikipedia.org/wiki/フレドホルム積分方程式](https://ja.wikipedia.org/wiki/%E3%83%95%E3%83%AC%E3%83%89%E3%83%9B%E3%83%AB%E3%83%A0%E7%A9%8D%E5%88%86%E6%96%B9%E7%A8%8B%E5%BC%8F)

##### 正規分布を使った$\pi$と$T_{\pi}$がフレドホルム積分方程式の解であること
一次元でチェックする

$\pi(y) := \mathcal{N}(y, 0, 1) = \frac{1}{\sqrt{2 \pi}} \exp \left(-\frac{y^2}{2}\right)$

$T_{\pi}(y \mid y^{\prime} ; \beta)
        := \mathcal{N}(y, y^{\prime}\sqrt{1-\beta}, \beta)
        = \frac{1}{\sqrt{2 \pi \beta^{2}}} \exp \left(-\frac{(y-y^{\prime}\sqrt{1-\beta})^2}{2\beta^{2}}\right)
$

とおく

$\pi(y) = \int dy^{\prime} T_{\pi}(y \mid y^{\prime}; \beta) \pi(y^{\prime})$ が、上記に対して成り立つことを確認する
$$
\begin{aligned}
(右辺) &= \int dy^{\prime} \frac{1}{\sqrt{2 \pi \beta^{2}}} \exp \left(-\frac{(y-y^{\prime}\sqrt{1-\beta})^2}{2\beta^{2}}\right) \frac{1}{\sqrt{2 \pi}} \exp \left(-\frac{y^{\prime 2}}{2}\right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime} \exp \left(-\frac{(y-y^{\prime}\sqrt{1-\beta})^2}{2\beta^{2}} - \frac{y^{\prime 2}}{2}\right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime} \exp \left(-\frac{(y-y^{\prime}\sqrt{1-\beta})^2}{2\beta^{2}} - \frac{y^{\prime 2} \beta^{2}}{2 \beta^{2}}\right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime} \exp \left(- \frac{y^{\prime 2} \beta^{2}}{2 \beta^{2}} -\frac{(-y^{\prime}\sqrt{1-\beta} + y)^2}{2\beta^{2}}\right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime} \exp \left(- \frac{y^{\prime 2} \beta^{2} + (-y^{\prime}\sqrt{1-\beta} + y)^{2}}{2 \beta^{2}}\right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime} \exp \left(- \frac{y^{\prime 2} \beta^{2} + (1-\beta)y^{\prime 2} - 2\sqrt{1-\beta}yy^{\prime} + y^{2}}{2 \beta^{2}}\right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime} \exp \left(- \frac{y^{\prime 2} (1-\beta+\beta^{2}) - 2\sqrt{1-\beta}yy^{\prime} + y^{2}}{2 \beta^{2}}\right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime} \exp \left(- \frac{(1-\beta+\beta^{2}) \left( y^{\prime 2} - \frac{2\sqrt{1-\beta}yy^{\prime}}{1-\beta+\beta^{2}} \right) + y^{2}}{2 \beta^{2}}\right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime}
        \exp \left(
                - \frac{
                        (
                                1-\beta+\beta^{2}
                        ) \left(
                                y^{\prime 2}
                                - \frac{
                                        2\sqrt{1-\beta}yy^{\prime}}{1-\beta+\beta^{2}
                                }
                                + \frac{
                                        (1-\beta)y^{2}}{(1-\beta+\beta^{2})^{2}
                                }
                                - \frac{
                                        (1-\beta)y^{2}}{(1-\beta+\beta^{2})^{2}
                                }
                        \right) + y^{2}
                }{
                        2 \beta^{2}
                }
        \right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime}
        \exp \left(
                - \frac{
                        (
                                1-\beta+\beta^{2}
                        ) \left(
                               (y^{\prime} - \frac{\sqrt{1-\beta}y}{1-\beta+\beta^{2}})^{2}
                                - \frac{
                                        (1-\beta)y^{2}}{(1-\beta+\beta^{2})^{2}
                                }
                        \right) + y^{2}
                }{
                        2 \beta^{2}
                }
        \right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime}
        \exp \left(
                - \frac{
                        (1-\beta+\beta^{2})(y^{\prime} - \frac{\sqrt{1-\beta}y}{1-\beta+\beta^{2}})^{2}
                        - (1-\beta+\beta^{2}) \frac{
                                (1-\beta)y^{2}}{(1-\beta+\beta^{2})^{2}
                        }
                        + y^{2}
                }{
                        2 \beta^{2}
                }
        \right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime}
        \exp \left(
                - \frac{
                        (1-\beta+\beta^{2})(y^{\prime} - \frac{\sqrt{1-\beta}y}{1-\beta+\beta^{2}})^{2}
                        - \frac{
                                (1-\beta)y^{2}}{1-\beta+\beta^{2}
                        }
                        + y^{2}
                }{
                        2 \beta^{2}
                }
        \right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime}
        \exp \left(
                - \frac{
                        (1-\beta+\beta^{2})(y^{\prime} - \frac{\sqrt{1-\beta}y}{1-\beta+\beta^{2}})^{2}
                        - \frac{
                                (1-\beta) - (1-\beta+\beta^{2})
                        }{
                                1-\beta+\beta^{2}
                        } y^{2}
                }{
                        2 \beta^{2}
                }
        \right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime}
        \exp \left(
                - \frac{
                        (1-\beta+\beta^{2})(y^{\prime} - \frac{\sqrt{1-\beta}y}{1-\beta+\beta^{2}})^{2}
                        + \frac{
                                \beta^{2}
                        }{
                                1-\beta+\beta^{2}
                        } y^{2}
                }{
                        2 \beta^{2}
                }
        \right) \\
&= \frac{1}{2 \pi \beta}
        \exp \left(
                - \frac{
                        \frac{
                                \beta^{2}
                        }{
                                1-\beta+\beta^{2}
                        } y^{2}
                }{
                        2 \beta^{2}
                }
        \right)
        \int dy^{\prime}
        \exp \left(
                - \frac{
                        (1-\beta+\beta^{2})(y^{\prime} - \frac{\sqrt{1-\beta}y}{1-\beta+\beta^{2}})^{2}
                }{
                        2 \beta^{2}
                }
        \right) \\
&= \frac{1}{2 \pi \beta}
        \exp \left(
                - \frac{
                        \frac{
                                \beta^{2}
                        }{
                                1-\beta+\beta^{2}
                        } y^{2}
                }{
                        2 \beta^{2}
                }
        \right)
        \sqrt{
                \frac{
                        \pi
                }{
                        \frac{
                                1-\beta+\beta^{2}
                        }{
                                2 \beta^{2}
                        }
                }
        }
        \\
&= \frac{1}{2 \pi \beta}
        \sqrt{
                \frac{
                        2 \pi \beta^{2}
                }{
                        1-\beta+\beta^{2}
                }
        }
        \exp \left(
                - \frac{
                        y^{2}
                }{
                        2 (1-\beta+\beta^{2})
                }
        \right)
        \\
&= \frac{1}{\sqrt{2 \pi (1-\beta+\beta^{2})}}
        \exp \left(
                - \frac{
                        y^{2}
                }{
                        2 (1-\beta+\beta^{2})
                }
        \right)
        \\
&= \mathcal{N}(y, 0, \sqrt{1-\beta+\beta^{2}})

\end{aligned}
$$

あわんかったので、$T_{\pi}(y \mid y^{\prime} ; \beta):= \mathcal{N}(y, m y^{\prime}, \beta)$で計算して、噛み合う$m$を見つける。

$\pi(y) := \mathcal{N}(y, 0, 1) = \frac{1}{\sqrt{2 \pi}} \exp \left(-\frac{y^2}{2}\right)$

$T_{\pi}(y \mid y^{\prime} ; \beta)
        := \mathcal{N}(y, m y^{\prime}, \beta)
        = \frac{1}{\sqrt{2 \pi \beta^{2}}} \exp \left(-\frac{(y-m y^{\prime})^2}{2\beta^{2}}\right)
$

とおく

$$
\begin{aligned}
(右辺) &= \int dy^{\prime} \frac{1}{\sqrt{2 \pi \beta^{2}}} \exp \left(-\frac{(y-m y^{\prime})^2}{2\beta^{2}}\right) \frac{1}{\sqrt{2 \pi}} \exp \left(-\frac{y^{\prime 2}}{2}\right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime} \exp \left(- \frac{y^{\prime 2} \beta^{2} + m^{2} y^{\prime 2} - 2myy^{\prime} + y^{2}}{2 \beta^{2}}\right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime} \exp \left(- \frac{(\beta^{2} + m^{2}) y^{\prime 2} - 2myy^{\prime} + y^{2}}{2 \beta^{2}}\right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime}
        \exp \left(
                - \frac{
                        (\beta^{2} + m^{2}) \left(
                                y^{\prime 2}
                                - \frac{
                                        2myy^{\prime}
                                }{
                                        \beta^{2} + m^{2}
                                }
                        \right)
                        + y^{2}
                }{
                        2 \beta^{2}
                }
        \right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime}
        \exp \left(
                - \frac{
                        (\beta^{2} + m^{2}) \left(
                                y^{\prime 2}
                                - \frac{
                                        2myy^{\prime}
                                }{
                                        \beta^{2} + m^{2}
                                }
                                + \frac{
                                        m^{2} y^{2}
                                }{
                                        (\beta^{2} + m^{2})^{2}
                                }
                                - \frac{
                                        m^{2} y^{2}
                                }{
                                        (\beta^{2} + m^{2})^{2}
                                }
                        \right)
                        + y^{2}
                }{
                        2 \beta^{2}
                }
        \right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime}
        \exp \left(
                - \frac{
                        (\beta^{2} + m^{2}) \left(
                                \left( y^{\prime} - \frac{my}{\beta^{2} + m^{2}} \right)^{2}
                                - \frac{
                                        m^{2} y^{2}
                                }{
                                        (\beta^{2} + m^{2})^{2}
                                }
                        \right)
                        + y^{2}
                }{
                        2 \beta^{2}
                }
        \right) \\
&= \frac{1}{2 \pi \beta} \int dy^{\prime}
        \exp \left(
                - \frac{
                        (\beta^{2} + m^{2}) \left( y^{\prime} - \frac{my}{\beta^{2} + m^{2}} \right)^{2}
                        - \frac{
                                m^{2} y^{2}
                        }{
                                \beta^{2} + m^{2}
                        }
                        + y^{2}
                }{
                        2 \beta^{2}
                }
        \right) \\
&= \frac{1}{2 \pi \beta}
\exp \left(
        - \frac{
                \frac{
                        m^{2} y^{2}
                }{
                        \beta^{2} + m^{2}
                }
                - y^{2}
        }{
                2 \beta^{2}
        }
\right)
\int dy^{\prime}
        \exp \left(
                - \frac{
                        (\beta^{2} + m^{2}) \left( y^{\prime} - \frac{my}{\beta^{2} + m^{2}} \right)^{2}
                }{
                        2 \beta^{2}
                }
        \right) \\
&= \frac{1}{2 \pi \beta}
\exp \left(
        - \frac{
                \frac{
                        m^{2} y^{2} - (\beta^{2} + m^{2}) y^{2}
                }{
                        \beta^{2} + m^{2}
                }
        }{
                2 \beta^{2}
        }
\right)
\sqrt{
        \frac{
                \pi 
        }{

                \left(\frac{
                        \beta^{2} + m^{2}
                }{
                        2 \beta^{2}
                }\right)
        }
}
\\
&= \frac{1}{2 \pi \beta}
\sqrt{
        \frac{
                2 \pi \beta^{2}
        }{
                \beta^{2} + m^{2}
        }
}
\exp \left(
        - \frac{
                \frac{
                        \beta^{2} y^{2}
                }{
                        \beta^{2} + m^{2}
                }
        }{
                2 \beta^{2}
        }
\right) \\
&= \frac{1}{\sqrt{2 \pi (\beta^{2} + m^{2})}}
\exp \left(
        - \frac{
                y^{2}
        }{
                2 (\beta^{2} + m^{2})
        }
\right) \\
&= \mathcal{N}(y, 0, \sqrt{\beta^{2} + m^{2}}) (*) 
\end{aligned}
$$

$\sqrt{\beta^2+m^2} = 1$ より、 $m = \sqrt{1-\beta^2}$

よって、

$T_{\pi}(y \mid y^{\prime} ; \beta)
        := \mathcal{N}(y, \sqrt{1 - \beta^{2}} y^{\prime}, \beta)
        = \frac{1}{\sqrt{2 \pi \beta^{2}}} \exp \left(-\frac{(y-\sqrt{1 - \beta^{2}} y^{\prime})^2}{2\beta^{2}}\right)
$


次回(6/1)
- 連続だと思って計算しているのが、本当は離散じゃないと成り立たないみたいな状況を定量化できると面白いのでは？
   - 松尾研で質問してみる @浅香先生 (6/10)
- Appendix Aの各定理をまとめる。(28) - (36)
  - (28)を↑の積分チェックして完了
  - $T_{\pi}$になんか条件があるかも (Tpi自体確率密度関数みたいな) ($p(0) = \pi$ とか)
- (次回:Appendix B. で、上記の計算を進める)
  - $H_{q}(X^{(T)})$ を、定義に合わせる
  - すると、Appendix B. (43) に着地
  - Appendix A.を読む
     - ↑ Lの下限が 2.4 (14) の形にすることで示せる
- [いつか] 離散で書き直してみる
- 関数解析に踏み込むとしたら
    - [形状最適化問題](https://www.morikita.co.jp/books/mid/061461)
- vscodeでTexで書く方法に移植する
- ↑βが小さい時にforwardとreverseが等しくなる、はよくわからないので保留
- モデルの実装(on github)も見てみる [https://github.com/Sohl-Dickstein/Diffusion-Probabilistic-Models/blob/master/model.py](https://github.com/Sohl-Dickstein/Diffusion-Probabilistic-Models/blob/master/model.py)
- 一旦読み終えてみてから、参考文献見てみる？
        - ガウス過程云々

---

$def.$

$0 \leq i \leq Tに対して \ X^{(i)} = \mathbb{R}^{n}$


$1 \leq i \leq Tに対して \ \beta_{i} \in \mathbb{R}$ : t-1とtの間の拡散率


$ $

$\mathbf{x}^{(i\dots j)} := (\mathbf{x}^{(i)},\dots , \mathbf{x}^{(j)})\in\prod_{t=i}^{j} X^{(t)}$ と書く


## 2.1. Forward Trajectory


$Q^{(0)}: \mathfrak{B}(X^{(0)})\to\mathbb{R}$: 確率測度


$q^{(0)}_{X_{abs}}:X^{(0)}\to\mathbb{R},\ Q^{(0)}$から定まる確率密度関数


$q^{(0\dots i)}_{X_{abs}}:\prod_{t=0}^{i} X^{(t)}\to\mathbb{R}$を


$$
q^{(0\dots i)}_{X_{abs}}(\mathbf{x}^{(0\dots i)})
        := q^{(0)}_{X_{abs}}\left(\mathbf{x}^{(0)}\right) \prod_{j=1}^i 
                \left(
                        T_{\pi}\left(\mathbf{x}^{(j)} \mid \mathbf{x}^{(j-1)};\beta_{j}\right)
                \right)
$$


$q^{(T)}_{X_{abs}}:X^{(T)}\to\mathbb{R},\ q^{(T)}_{X_{abs}}(\mathbf{x}^{(T)}) := \int d \mathbf{y}^{(0 \dots T-1)} q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0\dots T-1)},\mathbf{x}^{(T)}\right)$

##### 論文との対応

- $H_{q}(\mathbf{x}^{(t)}) = H_{entropy}(q^{(0\dots t)}_{X_{abs}})$
- $H_{q}(\mathbf{x}^{(t-1)} \mid \mathbf{x}^{(t)})
        = -\int_{\mathbf{x}^{(0\dots t-1)}\in\prod_{j=0}^{t-1} X^{(j)}, \mathbf{x}^{(0\dots t)}\in\prod_{j=0}^{t} X^{(j)}} d\mathbf{x}^{(0\dots i)}dy \ p^{joint}_{(Y, X)_{abs}}(y, \mathbf{x}^{(0\dots i)}) \log \left(p^{condi}_{(Y,X)_{abs}}(y \mid \mathbf{x}^{(0\dots i)})\right)$ 
- $q\left(\mathbf{x}^{(j)} \mid \mathbf{x}^{(j-1)}\right) = T_{\pi}\left(\mathbf{x}^{(j)} \mid \mathbf{x}^{(j-1)};\beta_{j}\right)$

#### 公式1 (ガウス積分)
$
\int_{x}
        \left(
                \alpha
                \cdot \exp \left(
                        -\gamma \cdot (x-\beta)^2
                \right)
        \right)
dx
= \alpha \cdot \sqrt{\frac{\pi}{\gamma}}
$

#### 公式2
$
\int_{x}
        \left(
                \alpha
                \cdot
                \left(
                        -\gamma \cdot (x-\beta)^2
                \right)
                \cdot
                \exp \left(
                        -\gamma \cdot (x-\beta)^2
                \right)
        \right)
dx
= - \frac{\alpha}{2} \sqrt{\frac{\pi}{\gamma}}
$

###### 導出
$y := \sqrt{\gamma}(x - \beta) とおくと、dx = \frac{1}{\sqrt{\gamma}}dy より\\ $
$$
\begin{aligned}
\int_{y}&
        \left(
                \alpha
                \cdot \exp \left(
                        -y^2
                \right)
                \cdot \left(
                        -y^2
                \right)
        \right)
        \frac{1}{\sqrt{\gamma}}dy \\
&= - \frac{1}{\sqrt{\gamma}} \alpha \int_{y} y^2 \cdot \exp(-y^2) dy \\
&= - \frac{1}{\sqrt{\gamma}} \alpha \left( \frac{\sqrt{\pi}}{2} \right) \\
&= - \frac{\alpha}{2} \sqrt{\frac{\pi}{\gamma}}
\end{aligned}
$$

#### 定理
###### $Claim$ $H_{entropy}(q^{(0\dots t)}_{X_{abs}}) \geq H_{entropy}(q^{(0\dots t-1)}_{X_{abs}})$ (論文(28))
$$
T_\pi\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)} ; \beta_{t}\right) 
        := \mathcal{N}(\mathbf{x}^{(t)}, \sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)}, \beta_{t})
        = \frac{1}{
                \sqrt{2 \pi \beta_{t}^{2}}
        }
        \exp \left(
                -\frac{
                        (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                }{
                        2\beta_{t}^{2}
                }
        \right)
$$

とするとき、$\beta_{t} \geq \sqrt{\frac{1}{2 \pi e}}$ ならば、
$$
H_{entropy}(q^{(0\dots t)}_{X_{abs}}) \geq H_{entropy}(q^{(0\dots t-1)}_{X_{abs}})
$$

が成り立つ。

###### $Proof$

$
q^{(0\dots t)}_{X_{abs}}(\mathbf{x}^{(0\dots t)})
        =
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
$
であるから、

$$
\begin{align*}
(右辺) = H_{entropy}(q^{(0\dots t-1)}_{X_{abs}})
= -\int_{\mathbf{x}^{(0\dots t-1)}\in\prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0\dots t-1)} q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)}) \cdot \log \left( q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)}) \right) \\
\end{align*}
$$

$$
\begin{align*}
(左辺) = H_{entropy}(q^{(0\dots t)}_{X_{abs}})
&= -\int_{\mathbf{x}^{(0\dots t)}\in\prod_{j=0}^{t} X^{(j)}} d\mathbf{x}^{(0\dots t)}
\left( 
        q^{(0\dots t)}_{X_{abs}}(\mathbf{x}^{(0\dots t)})
        \cdot
        \log \left(
                q^{(0\dots t)}_{X_{abs}}(\mathbf{x}^{(0\dots t)}) 
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0\dots t)}\in\prod_{j=0}^{t} X^{(j)}} d\mathbf{x}^{(0\dots t)}
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
        \cdot
        \log \left(
                q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
                \cdot
                T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0\dots t)}\in\prod_{j=0}^{t} X^{(j)}} d\mathbf{x}^{(0\dots t)}
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
        \cdot
        \left(
                \log \left(
                        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
                \right)
                +
                \log \left(
                        T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
                \right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0\dots t)}\in\prod_{j=0}^{t} X^{(j)}} d\mathbf{x}^{(0\dots t)}
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
        \cdot
        \left(
                \log \left(
                        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
                \right)
        \right)
\right)
-\int_{\mathbf{x}^{(0\dots t)}\in\prod_{j=0}^{t} X^{(j)}} d\mathbf{x}^{(0\dots t)}
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
        \cdot
        \left(
                \log \left(
                        T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
                \right)
        \right)
\right) \ \cdots \ (*) \\
\end{align*}
$$

---
項を分ける

$$
\begin{align*}
((*) \ 第１項)
&= -\int_{\mathbf{x}^{(0 \dots t-1)} \in \prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0 \dots t-1)} 
\left(
        \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
        \left(
                q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
                \cdot
                T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
                \cdot
                \log \left(
                        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
                \right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0 \dots t-1)} \in \prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0 \dots t-1)} 
\left(
        \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
        \left(
                q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
                \cdot
                \log \left(
                        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
                \right)
                \cdot
                T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0 \dots t-1)} \in \prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0 \dots t-1)} 
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        \log \left(
                q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \right)
        \cdot
        \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
        \left(
                
                T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0 \dots t-1)} \in \prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0 \dots t-1)} 
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        \log \left(
                q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \right)
        \cdot
        \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
        \left(
                
                \frac{1}{
                        \sqrt{2 \pi \beta_{t}^{2}}
                }
                \exp \left(
                        -\frac{
                                (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                        }{
                                2\beta_{t}^{2}
                        }
                \right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0 \dots t-1)} \in \prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0 \dots t-1)} 
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        \log \left(
                q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \right)
        \cdot
        \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
        \left(
                \underbrace{
                        \frac{1}{
                                \sqrt{2 \pi \beta_{t}^{2}}
                        }
                }_{\alpha}
                \exp \left(
                        -\underbrace{
                                \frac{
                                        1
                                }{
                                        2\beta_{t}^{2}
                                }
                        }_{\gamma}
                        \cdot
                        \left(
                                \mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)}
                        \right)^2
                \right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0 \dots t-1)} \in \prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0 \dots t-1)} 
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        \log \left(
                q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \right)
        \cdot
        \underbrace{
                \left(
                        \frac{1}{
                                \sqrt{2 \pi \beta_{t}^{2}}
                        }
                        \cdot
                        \sqrt{
                                \frac{
                                        \pi
                                }{
                                        \frac{
                                                1
                                        }{
                                                2\beta_{t}^{2}
                                        }
                                }
                        }
                \right)
        }_{1}
\right) \\
&= -\int_{\mathbf{x}^{(0 \dots t-1)} \in \prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0 \dots t-1)} 
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        \log \left(
                q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \right)
\right) \\
&= (右辺)
\end{align*}
$$

$$
\begin{align*}
((*) \ 第２項)
&= -\int_{\mathbf{x}^{(0\dots t)}\in\prod_{j=0}^{t} X^{(j)}} d\mathbf{x}^{(0\dots t)}
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
        \cdot
        \left(
                \log \left(
                        T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
                \right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0\dots t-1)}\in\prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0\dots t-1)}
\left(
        \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
        \left(
                q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
                \cdot
                T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
                \cdot
                \left(
                        \log \left(
                                T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
                        \right)
                \right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0\dots t-1)}\in\prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0\dots t-1)}
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
        \left(
                T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
                \cdot
                \left(
                        \log \left(
                                T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{x}^{(t-1)};\beta_{t}\right)
                        \right)
                \right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0\dots t-1)}\in\prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0\dots t-1)}
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
        \left(
                \frac{1}{
                        \sqrt{2 \pi \beta_{t}^{2}}
                }
                \exp \left(
                        -\frac{
                                (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                        }{
                                2\beta_{t}^{2}
                        }
                \right)
                \cdot
                \left(
                        \log \left(
                                \frac{1}{
                                        \sqrt{2 \pi \beta_{t}^{2}}
                                }
                                \exp \left(
                                        -\frac{
                                                (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                                        }{
                                                2\beta_{t}^{2}
                                        }
                                \right)
                        \right)
                \right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0\dots t-1)}\in\prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0\dots t-1)}
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
        \left(
                \frac{1}{
                        \sqrt{2 \pi \beta_{t}^{2}}
                }
                \exp \left(
                        -\frac{
                                (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                        }{
                                2\beta_{t}^{2}
                        }
                \right)
                \cdot
                \left(
                        \log \left(
                                \frac{1}{
                                        \sqrt{2 \pi \beta_{t}^{2}}
                                }
                        \right)
                        +
                        \log \left(
                                \exp \left(
                                        -\frac{
                                                (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                                        }{
                                                2\beta_{t}^{2}
                                        }
                                \right)
                        \right)
                \right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0\dots t-1)}\in\prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0\dots t-1)}
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
        \left(
                \frac{1}{
                        \sqrt{2 \pi \beta_{t}^{2}}
                }
                \exp \left(
                        -\frac{
                                (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                        }{
                                2\beta_{t}^{2}
                        }
                \right)
                \cdot
                \left(
                        \log \left(
                                \frac{1}{
                                        \sqrt{2 \pi \beta_{t}^{2}}
                                }
                        \right)
                        +
                        \left(
                                -\frac{
                                        (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                                }{
                                        2\beta_{t}^{2}
                                }
                        \right)
                \right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0\dots t-1)}\in\prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0\dots t-1)}
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
        \left(
                \frac{1}{
                        \sqrt{2 \pi \beta_{t}^{2}}
                }
                \exp \left(
                        -\frac{
                                (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                        }{
                                2\beta_{t}^{2}
                        }
                \right)
                \cdot
                \left(
                        \log \left(
                                \frac{1}{
                                        \sqrt{2 \pi \beta_{t}^{2}}
                                }
                        \right)
                        +
                        \left(
                                -\frac{
                                        (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                                }{
                                        2\beta_{t}^{2}
                                }
                        \right)
                \right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0\dots t-1)}\in\prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0\dots t-1)}
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        \left(
                \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
                \left(
                        \frac{1}{
                                \sqrt{2 \pi \beta_{t}^{2}}
                        }
                        \exp \left(
                                -\frac{
                                        (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                                }{
                                        2\beta_{t}^{2}
                                }
                        \right)
                        \cdot
                        \log \left(
                                \frac{1}{
                                        \sqrt{2 \pi \beta_{t}^{2}}
                                }
                        \right)
                \right)
                +
                \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
                \left(
                        \frac{1}{
                                \sqrt{2 \pi \beta_{t}^{2}}
                        }
                        \exp \left(
                                -\frac{
                                        (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                                }{
                                        2\beta_{t}^{2}
                                }
                        \right)
                        \cdot
                
                        \left(
                                -\frac{
                                        (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                                }{
                                        2\beta_{t}^{2}
                                }
                        \right)
                \right)
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0\dots t-1)}\in\prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0\dots t-1)}
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        \left(
                \cancel{

                        \frac{1}{
                                \sqrt{2 \pi \beta_{t}^{2}}
                        }       
                }
                \cdot
                \log \left(
                        \frac{1}{
                                \sqrt{2 \pi \beta_{t}^{2}}
                        }
                \right)
                \cdot
                \underbrace{
                        \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
                        \left(
                                \exp \left(
                                        -\frac{
                                                (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                                        }{
                                                2\beta_{t}^{2}
                                        }
                                \right)
                        \right)
                }_{
                        \cancel{ \sqrt{2 \pi \beta_{t}^{2}} } \ (\because ガウス積分)
                }
                +
                \cancel{

                        \frac{1}{
                                \sqrt{2 \pi \beta_{t}^{2}}
                        }       
                }
                \cdot
                \underbrace{
                        \int_{\mathbf{x}^{(t)} \in X^{(t)}} d\mathbf{x}^{(t)}
                        \left(
                                \exp \left(
                                        -\frac{
                                                (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                                        }{
                                                2\beta_{t}^{2}
                                        }
                                \right)
                                \cdot
                        
                                \left(
                                        -\frac{
                                                (\mathbf{x}^{(t)}-\sqrt{1 - \beta_{t}^{2}} \mathbf{x}^{(t-1)})^2
                                        }{
                                                2\beta_{t}^{2}
                                        }
                                \right)
                        \right)
                }_{
                        - \frac{1}{2} \cdot \cancel{ \sqrt{2 \pi \beta_{t}^{2}} } \ (\because 公式2)
                }
        \right)
\right) \\
&= -\int_{\mathbf{x}^{(0\dots t-1)}\in\prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0\dots t-1)}
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
        \cdot
        \left(
                \log \left(
                        \frac{1}{
                                \sqrt{2 \pi \beta_{t}^{2}}
                        }
                \right)
                -
                \frac{1}{2}
        \right)
\right) \\
&=
-\left(
        \log \left(
                \frac{1}{
                        \sqrt{2 \pi \beta_{t}^{2}}
                }
        \right)
        -
        \frac{1}{2}
\right)
\cdot
\underbrace{
\int_{\mathbf{x}^{(0\dots t-1)}\in\prod_{j=0}^{t-1} X^{(j)}} d\mathbf{x}^{(0\dots t-1)}
\left(
        q^{(0\dots t-1)}_{X_{abs}}(\mathbf{x}^{(0\dots t-1)})
\right) 
}_{1} \\
&=
-\left(
        \log \left(
                \frac{1}{
                        \sqrt{2 \pi \beta_{t}^{2}}
                }
        \right)
        -
        \frac{1}{2}
\right) \\
&=
\frac{1}{2}
+
\frac{1}{2}
\cdot
\log \left(
        2 \pi \beta_{t}^{2}
\right) \\
&=
\frac{1}{2}
\cdot
\left(
        1
        +
        \log \left(
                2 \pi \beta_{t}^{2}
        \right)
\right) \\
\end{align*}
$$

よって、
$$
\begin{align*}
\end{align*}
$$

$$
\begin{align*}
(左辺) - (右辺)
&= 
\left(
        (右辺)
        -
        \frac{1}{2}
        \left(
                1
                +
                \log \left(
                        2 \pi \beta_{t}^{2}
                \right)
        \right)
\right)
-
(右辺) \\
&=
\frac{1}{2}
\left(
        1
        +
        \log \left(
                2 \pi \beta_{t}^{2}
        \right)
\right)
\end{align*}
$$

ゆえに、$\beta_{t} \geq \sqrt{\frac{1}{2 \pi e}}$ の時、不等式が成り立つ

$Q.E.D.$

-----
$Claim$ 付録A (30)
$H_q\left(\mathbf{X}^{(t-1)} \mid \mathbf{X}^{(t)}\right) \leq H_q\left(\mathbf{X}^{(t)} \mid \mathbf{X}^{(t-1)}\right)$

$
H^{}_{condi}= -\int_{x \in X, y \in Y} dxdy \ p^{joint}_{(Y, X)_{abs}}(y, x) \log \left(p^{condi}_{(Y,X)_{abs}}(y \mid x)\right) \\
$

(次回 6/29)
- ↑を$q^{0...i}$を使って書く
- この時、$q^{0...i}$ は joint としてしまえることがわかったので、p^{joint}のところにq^{0...i}をそのまま入れる
- 型は、$p^{condi}_{(\mathbf{X}^{(t-1)}, \mathbf{X}^{(t)})_{abs}}(\cdot\mid\cdot):\mathbb{R}^{t}\times\mathbb{R}^{t-1} \to \mathbb{R}_{\geq 0}$ みたいになるはず。(ちゃんとやる)


$\beta_{t} \geq \sqrt{\frac{1}{2 \pi e}}$ のとき、

$$

$$

(次回 6/22)
### メモ
##### 大きな方針
- とりあえずこの本の理論は最後まで追ってみる
  - 有限と捉えてちゃんと書いてみた時に、自然と$\sqrt{1-\beta}$が出てきてくれないか
  - 代数的確率空間的に書いてみるとどうなるか
- 各ステップのエントロピー差が有界であることを示している
  - (30)で上界がわかる
  - ゴールは (36)



## 2.2. Reverse Trajectory


$p^{(T)}_{X_{abs}}:X^{(T)}\to\mathbb{R},\ p^{(T)}_{X_{abs}}(\mathbf{x}^{(T)}) := \pi(\mathbf{x}^{(T)})$


$p^{(i\dots T)}_{X_{abs}}:\prod_{t=i}^{T} X^{(t)}\to\mathbb{R}$


$$
p^{(i\dots T)}_{X_{abs}}(\mathbf{x}^{(i\dots T)}) := p^{(T)}_{X_{abs}}\left(\mathbf{x}^{(T)}\right) \prod_{t=1}^T T_{\pi}\left(\mathbf{x}^{(t-1)} \mid \mathbf{x}^{(t)};\beta_{t}\right)
$$

##### 論文との対応

- $p\left(\mathbf{x}^{(j-1)} \mid \mathbf{x}^{(j)}\right) = T_{\pi}\left(\mathbf{x}^{(j-1)} \mid \mathbf{x}^{(j)};\beta_{j}\right)$


## 2.3. Model Probability


> これは、統計物理学における準静的過程の場合に相当する

- [非平衡科学](https://sosuke110.com/noneq-phys.pdf)
- [機械学習のための確率過程](https://www.amazon.co.jp/%E6%A9%9F%E6%A2%B0%E5%AD%A6%E7%BF%92%E3%81%AE%E3%81%9F%E3%82%81%E3%81%AE%E7%A2%BA%E7%8E%87%E9%81%8E%E7%A8%8B%E5%85%A5%E9%96%80-%E2%80%95%E7%A2%BA%E7%8E%87%E5%BE%AE%E5%88%86%E6%96%B9%E7%A8%8B%E5%BC%8F%E3%81%8B%E3%82%89%E3%83%99%E3%82%A4%E3%82%BA%E3%83%A2%E3%83%87%E3%83%AB-%E6%8B%A1%E6%95%A3%E3%83%A2%E3%83%87%E3%83%AB%E3%81%BE%E3%81%A7%E2%80%95-%E5%86%85%E5%B1%B1%E7%A5%90%E4%BB%8B-ebook/dp/B0CK176SH5/ref=tmm_kin_swatch_0?_encoding=UTF8&qid=&sr=)

$p^{(0)}_{X_{abs}}:X^{(0)}\to\mathbb{R},\ p^{(0)}_{X_{abs}}(\mathbf{x}^{(0)}) := \int d \mathbf{y}^{(1 \dots T)} p^{(0\dots T)}_{X_{abs}}\left(\mathbf{x}^{(0)},\mathbf{y}^{(1 \dots T)}\right)$


$= \int d \mathbf{y}^{(1 \dots T)} p^{(0\dots T)}_{X_{abs}}\left(\mathbf{x}^{(0)},\mathbf{y}^{(1 \dots T)}\right)\frac{q^{(0\dots T)}_{X_{abs}}\left(\mathbf{x}^{(0)},\mathbf{y}^{(1 \dots T)}\right)}{q^{(0\dots T)}_{X_{abs}}\left(\mathbf{x}^{(0)},\mathbf{y}^{(1 \dots T)}\right)}$


$= \int d \mathbf{y}^{(1 \dots T)}q^{(0\dots T)}_{X_{abs}}\left(\mathbf{x}^{(0)},\mathbf{y}^{(1 \dots T)}\right) \frac{p^{(0\dots T)}_{X_{abs}}\left(\mathbf{x}^{(0)},\mathbf{y}^{(1 \dots T)}\right)}{q^{(0\dots T)}_{X_{abs}}\left(\mathbf{x}^{(0)},\mathbf{y}^{(1 \dots T)}\right)}$


$= \int d \mathbf{y}^{(1 \dots T)}q^{(0\dots T)}_{X_{abs}}\left(\mathbf{x}^{(0)},\mathbf{y}^{(1 \dots T)}\right) \cdot \frac{p^{(T)}_{X_{abs}}\left(\mathbf{y}^{(T)}\right)}{q^{(0)}_{X_{abs}}\left(\mathbf{x}^{(0)}\right)} \cdot \frac{T_{\pi}\left(\mathbf{x}^{(0)} \mid \mathbf{y}^{(1)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(1)} \mid  \mathbf{x}^{(0)};\beta_{t}\right)} \cdot \left(  \prod_{t=2}^T \frac{ T_{\pi}\left(\mathbf{y}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)} \right)$


この積分は、複数のサンプル $q^{(0\dots T)}_{X_{abs}}\left(\mathbf{x}^{(0)},\mathbf{y}^{(1 \dots T)}\right) $ の平均を取ることで、素早く評価できる。


$\beta_{t}$が無限小のとき、$\frac{T_{\pi}\left(\mathbf{x}^{(0)} \mid \mathbf{y}^{(1)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(1)} \mid  \mathbf{x}^{(0)};\beta_{t}\right)} \cdot \left(  \prod_{t=2}^T \frac{ T_{\pi}\left(\mathbf{y}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)} \right)=1$となる。

- つまり、$1 \leq t \leq T$について、$T_{\pi}\left(\mathbf{x}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right) = T_{\pi}\left(\mathbf{x}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)$ ← ?
- このとき、上記の積分を評価するのに要求されるのは、単一のサンプル$q^{(0\dots T)}_{X_{abs}}\left(\mathbf{x}^{(0)},\mathbf{y}^{(1 \dots T)}\right) $のみである

> 💡 $q^{(0)}_{x_{i}}:$ 与えられた真のデータの分布  
> $ p^{(0)}_{x_{i}}: $ Reverse trajectoryを用いて計算された、$q^{(0)}_{x_{i}}$の近似


以下で、$p^{(0)}_{x_{i}}, q^{(0)}_{x_{i}}$のCross Entropyを最小化する


## 2.4. Training


$H(p^{(0)}_{X_{abs}}, q^{(0)}_{X_{abs}}):$ Cross Entropy


$H(p^{(0)}_{X_{abs}}, q^{(0)}_{X_{abs}})
=-\int_{X^{(0)}} d \mathbf{y}^{(0)} \ q_{X_{abs}}^{(0)}\left(\mathbf{y}^{(0)}\right) \cdot \log p_{X_{abs}}^{(0)}\left(\mathbf{y}^{(0)}\right)$


$=-\int_{X^{(0)}} d \mathbf{y}^{(0)} \ q_{X_{abs}}^{(0)}\left(\mathbf{y}^{(0)}\right)\cdot \log \left[\int d \mathbf{y}^{(1 \dots T)}q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0)},\mathbf{y}^{(1 \dots T)}\right) \cdot \frac{p^{(T)}_{X_{abs}}\left(\mathbf{y}^{(T)}\right)}{q^{(0)}_{X_{abs}}\left(\mathbf{y}^{(0)}\right)} \cdot \frac{T_{\pi}\left(\mathbf{y}^{(0)} \mid \mathbf{y}^{(1)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(1)} \mid  \mathbf{y}^{(0)};\beta_{t}\right)} \cdot \left(  \prod_{t=2}^T \frac{ T_{\pi}\left(\mathbf{y}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)} \right)\right]
$


$=-\int_{X^{(0)}} d \mathbf{y}^{(0)} \ q_{X_{abs}}^{(0)}\left(\mathbf{y}^{(0)}\right) \cdot \log \left[\int d \mathbf{y}^{(1 \dots T)} \  \frac{q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0)},\mathbf{y}^{(1 \dots T)}\right)}{q^{(0)}_{X_{abs}}\left(\mathbf{y}^{(0)}\right)} \cdot p^{(T)}_{X_{abs}}\left(\mathbf{y}^{(T)}\right) \cdot \frac{T_{\pi}\left(\mathbf{y}^{(0)} \mid \mathbf{y}^{(1)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(1)} \mid  \mathbf{y}^{(0)};\beta_{t}\right)} \cdot \left(  \prod_{t=2}^T \frac{ T_{\pi}\left(\mathbf{y}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)} \right)\right]
$


$\geq -\int_{X^{(0)}} d \mathbf{y}^{(0)} q_{X_{abs}}^{(0)}\left(\mathbf{y}^{(0)}\right) \cdot \left( \int_{X^{(1 \dots T)}} d \mathbf{y}^{(1 \dots T)} \cdot  \frac{q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0)},\mathbf{y}^{(1 \dots T)}\right)}{q^{(0)}_{X_{abs}}\left(\mathbf{y}^{(0)}\right)} \cdot  \log \left[p^{(T)}_{X_{abs}}\left(\mathbf{y}^{(T)}\right) \cdot \frac{T_{\pi}\left(\mathbf{y}^{(0)} \mid \mathbf{y}^{(1)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(1)} \mid  \mathbf{y}^{(0)};\beta_{t}\right)} \cdot \left(  \prod_{t=2}^T \frac{ T_{\pi}\left(\mathbf{y}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)} \right)\right]\right)$(∵ [Jensenの不等式](https://ja.wikipedia.org/wiki/%E3%82%A4%E3%82%A7%E3%83%B3%E3%82%BB%E3%83%B3%E3%81%AE%E4%B8%8D%E7%AD%89%E5%BC%8F), $\int_{X^{(1...T)}} \frac{q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0)},\mathbf{y}^{(1 \dots T)}\right)}{q^{(0)}_{X_{abs}}\left(\mathbf{y}^{(0)}\right)} = 1$ (∵ 周辺分布の定義) )


$= -\int_{X^{(0)}} d \mathbf{y}^{(0)}  \left( \int_{X^{(1 \dots T)}} d \mathbf{y}^{(1 \dots T)} \ q_{X_{abs}}^{(0)}\left(\mathbf{y}^{(0)}\right) \cdot  \frac{q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0)},\mathbf{y}^{(1 \dots T)}\right)}{q^{(0)}_{X_{abs}}\left(\mathbf{y}^{(0)}\right)} \cdot  \log \left[p^{(T)}_{X_{abs}}\left(\mathbf{y}^{(T)}\right) \cdot \frac{T_{\pi}\left(\mathbf{y}^{(0)} \mid \mathbf{y}^{(1)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(1)} \mid  \mathbf{y}^{(0)};\beta_{t}\right)} \cdot \left(  \prod_{t=2}^T \frac{ T_{\pi}\left(\mathbf{y}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)} \right)\right]\right)$(∵ $q_{X_{abs}}^{(0)}\left(\mathbf{y}^{(0)}\right)$は$\int_{X^{(1...T)}}$において定数)


$= - \int_{X^{(0 \dots T)}} d\mathbf{y}^{(0 \dots T)} \  q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0 \dots T)}\right) \cdot  \log \left[p^{(T)}_{X_{abs}}\left(\mathbf{y}^{(T)}\right) \cdot \left(  \prod_{t=1}^T \frac{ T_{\pi}\left(\mathbf{y}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)} \right)\right]$


 (∵ 約分 & 重積分はまとめられる & 細かい略記)　(Appendix B. (38) と一致)


$=- \int_{X^{(0 \dots T)}} d\mathbf{y}^{(0 \dots T)} \  q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0)},\mathbf{y}^{(1 \dots T)}\right) \cdot \left( \log \left[p^{(T)}_{X_{abs}}\left(\mathbf{y}^{(T)}\right) \right] + \sum_{t=1}^T \left(\log \left[  \frac{ T_{\pi}\left(\mathbf{y}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)} \right]\right) \right)
$ (1) (∵ logを和に分解)

$=- \int_{X^{(0 \dots T)}} d\mathbf{y}^{(0 \dots T)} \  q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0)},\mathbf{y}^{(1 \dots T)}\right) \cdot 
\left(
        \sum_{t=1}^T \left(\log \left[  \frac{ T_{\pi}\left(\mathbf{y}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)} \right]\right)
         + \log \left[p^{(T)}_{X_{abs}}\left(\mathbf{y}^{(T)}\right) \right]
\right)
$ (1.5) (∵ 括弧内の和の順序入れ替え)


$=- \int_{X^{(0 \dots T)}} \left( \ q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0)},\mathbf{y}^{(1 \dots T)}\right) \cdot \sum_{t=1}^T \left(\log \left[ \frac{ T_{\pi}\left(\mathbf{y}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)} \right] \right) \right) d\mathbf{y}^{(0 \dots T)} - \int_{X^{(0 \dots T)}} \left( \ q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0)},\mathbf{y}^{(1 \dots T)} \right) \cdot \log \left[p^{(T)}_{X_{abs}}\left(\mathbf{y}^{(T)}\right) \right] \right) d\mathbf{y}^{(0 \dots T)} $ (2) (∵ 積分を和で分解)

$=- \int_{X^{(0 \dots T)}} \left( \ q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0)},\mathbf{y}^{(1 \dots T)}\right) \cdot \sum_{t=1}^T \left(\log \left[ \frac{ T_{\pi}\left(\mathbf{y}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)} \right] \right) \right) d\mathbf{y}^{(0 \dots T)} - \int_{X^{(T)}} \int_{X^{(0 \dots T-1)}} \left( \ q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0)},\mathbf{y}^{(1 \dots T)} \right) \cdot \log \left[p^{(T)}_{X_{abs}}\left(\mathbf{y}^{(T)}\right) \right] \right) d\mathbf{y}^{(0 \dots T)} $ (2.5) (∵ 第二項の積分を被積分変数で分解)


$=- \int_{X^{(0 \dots T)}} \left( \ q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0)},\mathbf{y}^{(1 \dots T)}\right) \cdot \sum_{t=1}^T \left(\log \left[ \frac{ T_{\pi}\left(\mathbf{y}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)} \right] \right) \right) d\mathbf{y}^{(0 \dots T)} - \int_{X^{(T)}} \left( \ q_{X_{abs}}^{(T)}\left(\mathbf{y}^{(T)}\right) \cdot \log \left[p^{(T)}_{X_{abs}}\left(\mathbf{y}^{(T)}\right) \right] \right) d\mathbf{y}^{(T)} $ (3) (∵ 第二項の内側の積分実行)


$
= - \int_{X^{(0 \dots T)}} d\mathbf{y}^{(0 \dots T)} \ q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0)},\mathbf{y}^{(1 \dots T)}\right) \cdot \sum_{t=1}^T \left(\log \left[  \frac{ T_{\pi}\left(\mathbf{y}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)} \right] \right) - H_{cross}\left(q^{(T)}_{X_{abs}}, p^{(T)}_{X_{abs}}\right)
$ (4) 

$
= - \int_{X^{(0 \dots T)}} d\mathbf{y}^{(0 \dots T)} \ q^{(0\dots T)}_{X_{abs}}\left(\mathbf{y}^{(0)},\mathbf{y}^{(1 \dots T)}\right) \cdot \sum_{t=1}^T \left(\log \left[  \frac{ T_{\pi}\left(\mathbf{y}^{(t-1)} \mid \mathbf{y}^{(t)};\beta_{t}\right)}{T_{\pi}\left(\mathbf{y}^{(t)} \mid \mathbf{y}^{(t-1)};\beta_{t}\right)} \right] \right) - H_{cross}\left(q^{(T)}_{X_{abs}}, p^{(T)}_{X_{abs}}\right)
$ (5) <- (論文14と対応させたい)






## 2.5. Multiplying Distributions, and Computing Posteriors


## 2.6. Entropy of Reverse Process


# 3. Experiments


## 3.1. Toy Problem


## 3.2. Images


# 4. Conclusion


# メモ

- 小林さんMTGめも

## 小林さんMTGメモ

# ざっくりした物理的イメージ

- 生成モデルって？
        - 何か → 似たやつを作る
        - → = 確率分布
- 確率分布 =  分配関数
        - 分配関数がわかれば確率分布がわかる
        - エネルギーが定義できる状況ならなんでも分配関数が使える
- 情報では？
        - 尤度 = エネルギー
        - 学習したデータの尤度を高める = その点のポテンシャルを最小化する
- エネルギー(尤度)を最適させるのに適切な関数は何？
        - 機械学習で言えば損失関数
        - 
- 量子コンピュータの種類
        - 量子アニーリング
        - 量子ゲート

