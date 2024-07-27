#import "@preview/cetz:0.1.2"

#let theorem(body, name: none) = {
  let title = "Theorem"
  if name != none {
    title += " (" + name + ")"
  }
  block(width: 100%, inset: 1em, radius: 0.3em, stroke: 0.5pt + black, [
    *#title.* #body
  ])
}

#let proof(body) = {
  block(width: 100%, inset: 1em, radius: 0.3em, stroke: 0.5pt + black, [
    #body
    #align(right, $square$)
  ])
}

#set page(
  paper: "a2",
  margin: (left: 2cm, right: 2cm, top: 2cm, bottom: 2cm),
)

= ゴール

- 拡散モデルの数理を流し読みして、量子コンピューティング (量子アニーリング) と関係ありそうだと思った
  - ので、これの数理的な関連をざっくりと理解したい
  - 年内いっぱいくらいで「わかった」という気分になりたい
  - なんでかというと、今から量子コンピューティングの勉強にリソース割いておくかどうかを見定めたい

== 関連しそうな項目

- 拡散モデル
  - 確率過程
- シミュレーティッドアニーリング
- 量子アニーリング
- 代数的確率空間
  - 量子力学においては、行列(=作用素)のtraceが期待値
  - この辺を抽象化して、代数の元に「確率的」な情報が含まれているとみなしてゴニョゴニョするのが確率的代数空間 (イメージ)
  - これを理解できると「拡散モデルのマルコフ過程は代数的確率空間的にはこう」みたいな話から「じゃあこんな種類の代数構造から考えたら拡散モデルに当たるものは何？」みたいな議論ができて面白いのでは、という仮説

= 課題感

- 大規模LLMは大手に独占されている
  - GPT 4はパラメーター数が 170兆
  - 圧倒的データ量

= 教科書

- *確率論*: #link("https://www.amazon.co.jp/gp/product/4254116004/ref=ox_sc_act_image_1?smid=AN1VRQENFRJN5&psc=1")
- *確率微分方程式とその応用:* #link("https://www.amazon.co.jp/gp/product/4627077815/ref=ox_sc_act_image_2?smid=AN1VRQENFRJN5&psc=1")

= 論文まとめ

== Deep Unsupervised Learning using Nonequilibrium Thermodynamics

非平衡熱力学を用いた教師なしディープラーニング

= 一般定理

== ガウス積分

$ integral_(- infinity)^(infinity) exp(-a(x-b)^2) dif x = sqrt(pi / a) quad Re{a} > 0, b in CC $

= 用語

== 可測空間

- 組み $(Omega, F)$
  - $Omega$ : set
  - $F$ : 完全加法族
    - 完全加法性を満たす、$Omega$の冪集合の部分集合

== 可測写像

- $(Omega, F), (Psi, G):$ 可測空間
  - $f: (Omega, F) -> (Psi, G)$ で以下を満たす
  - $forall A in G space f^(-1)(A) in F$
  - \*\* $f: (Omega, F) -> (Psi, G)$ こう書いたときの実態は $f: F -> G$

== 測度空間

- 組み$(Omega, F, mu)$
  - $mu:F->RR_(>=0)$
    - 可算加法性を満たす
      - $forall i,j in NN, A_i, A_j in F space A_i union A_j = "empty" arrow.r.double mu(union_(i) A_(i) ) = sum_(i) mu(A_(i) )$

== 実数 (測度空間の具体例)

- $(RR,B(RR),mu)$
  - $B(RR):$ ボレル集合族
    - RR上の距離から定まる位相を含む最小の完全加法族
  - $mu:$ ルベーグ測度
    - 距離から自然に定まる「長さ」
    - $mu([0,1]) = 1$
    - $mu([a, b]) = b - a$

== 確率空間

- 測度空間 $(Omega, F, P)$で以下を満たすもの
  - $P(Omega) = 1$
- $Omega$ を*標本空間*という
  - $Omega$の元を*標本*という
- $F$ を*事象の全体*という
  - $F$の元を*事象*という
- $P$ を*確率測度*という

== 確率変数 (random variety)

- $X: Omega -> RR$ で、以下を満たすもの
  - 可測である。つまり、$forall omega in frak(B)(RR), X^(-1)(omega) in F$

== $X$に由来する確率測度
確率空間$(Omega, F, P)$と確率変数$X$について、

$P_(X): frak(B)(RR) -> [0,1],\ A arrow P(X^(-1)(A))$

が定まり、
$(RR,frak(B)(RR),P_X)$は確率空間になっている

== d変数確率変数 (random variety)
$X_(1), dots ,X_(d):$1変数確率変数

$
(X_(1), dots ,X_(d)): (Omega, F)->
(RR^d,frak(B)(RR^d)), \  omega arrow (X_(1)(omega), dots,X_(d)(omega))
$

== $(X_(1), dots ,X_(d))$に由来する確率測度
確率空間$(Omega, F, P)$とd変数確率変数$(X_(1), dots ,X_(d))$について、

$P_(
  (X_(1), dots ,X_(d))
): frak(B)(RR^(d)) -> [0,1],\ A arrow P((X_(1), dots ,X_(d))^(-1)(A))$

が定まり、
$(RR,frak(B)(RR),P_X)$は確率空間になっている

== Lebesgueの分解定理
確率空間$(Omega, F, P)$と確率変数$X$について、

$(RR,frak(B)(RR), P_(X))$: 確率空間 が定まる。


$mu: frak(B)(RR) -> RR$ を Lebegue Measure とする.
$
P_X=P_(X_(abs))+P_(X_("sing"))+P_(X_("dis")) \ s.t.
$
- $P_(X_(abs))$ は $mu$ について、 absolutely conti.
    - すなわち、 $mu(A)=0$ ならば $P_(X_(abs))(A)=0(forall A in B(RR))$
- $P_(X_("sing"))$ は $mu$ について、conti. かつ、 singular.
    - すなわち、 $P_(X_("sing"))(a)=0(forall a in RR)$ かつ、 $exists A in A(RR)$ s.t. $mu(A)=0$ and $P_(X_("sing"))(A^c)=0$
- $P_(X_("dis"))$ は $mu$ について、 discrete.
    - すなわち、 $exists{a_n}_(n=1)^(infinity) subset RR$ s.t. $P_(X_("dis"))=sum_(i=1)^(infinity) a_i chi_(P_i)(A)$ ただし、($chi_(P_i): B(RR) -> RR, chi_(P_i)(A):={cases(0(p_i not in A), 1(p_i in A))}$)

と一意に分解できる.

- 拡散モデルの数理を読む上ではPabsだけ考えるでOK

=== 多変数の場合
確率空間$(Omega, F, P)$と確率変数$(X_(1),dots,X_(d))$について、

$(RR^(d),frak(B)(RR^(d)), P_(
  (X_(1),dots,X_(d))
))$: 確率空間 が定まる。

$mu: frak(B)(RR^(d)) -> RR$ を Lebegue Measure とする.

以下は、1変数の場合と同様。

== Radon-Nikodymの定理
$X$: 確率変数

Lebegue の $P_(X_(abs))$ について、以下を満たす Integrable な関数 $p_(X_(abs)): RR -> RR_(>=0)$ が存在する。

$forall x in RR$

$
integral_(- infinity)^x p_(X_(abs))(x^') dif x^'=P_(X_(abs))((-infinity, x])
$

この $P_(X_(abs))$ を、確率密度関数 (Probabilty Density Function) と呼ぶ。

- 気温が20度から30度になる確率を求めたい時に、
  - 「気温x度」を実数xにマップする ← 確率変数という
  - 実数直線上で20-30の区間で積分する

=== 多変数の場合
確率空間$(Omega, F, P)$と$(X_(1),dots,X_(d))$: d変数確率変数について、

$(RR^(d),frak(B)(RR^(d)), P_(
  (X_(1),dots,X_(d))
))$: 確率空間 が定まる。

Lebegue の $P_(
  (X_(1), dots ,X_(d))_(abs)
)$ について、以下を満たす Integrable な関数 $p^("joint")_(
  (X_(1), dots ,X_(d))_(abs)
): RR^(d) -> RR_(>=0)$ が存在する。

$forall x_(1), dots, x_(1) in RR$

$
integral_(- infinity)^(x_(1)) dots integral_(- infinity)^(x_(d)) p^("joint")_(
  (X_(1), dots ,X_(d))_(abs)
)(x^') dif x^'=P_(
  (X_(1), dots ,X_(d))_(abs)
)((-infinity, x_(1)] times dots times (-infinity, x_(d)])
$

この $p^("joint")_(
  (X_(1), dots ,X_(d))_(abs)
)$ を、結合確率密度関数 (Joint Probabilty Density Function) と呼ぶ。

#block(inset: (left: 1em))[
  フビニの定理により、$RR^(d)$についての積分はd回の$RR$についての積分と等しくなる。
]

$X_(1), dots ,X_(d)$ は互いに入れ替え可能である。
特に、$d=2$の場合、
$
p^("joint")_(
  (X_(1), X_(2))_(abs)
)(x_(1), x_(2))=p^("joint")_(
  (X_(2), X_(1))_(abs)
)(x_(2), x_(1))
$

== Radon-Nikodymの定理の逆っぽい定理
#theorem(name: "Claim")[
  $d in ZZ_(>=1)$と、実数値関数 $p: RR^(d) -> RR_(>=0)$ について、

  pが、
  - $p$は可測関数
  - $integral_(- infinity)^(infinity) dots integral_(- infinity)^(infinity) p(x^') dif x^'=1$

  を満たすとき、

  確率空間$(RR^(d),frak(B)(RR^(d)), P)$がただ一つ存在して、

  $bold(x) in RR^(d)$
  $
  integral_(- infinity)^("pr"_(1)(bold(x))) dots integral_(- infinity)^("pr"_(d)(bold(x)))
          p(bold(x^')) dif bold(x^')
  =
  P(
          (-infinity, "pr"_(1)(bold(x))]
          times dots times
          (-infinity, "pr"_(d)(bold(x))]
  )
  $

  を満たす。

  ただし、$1 <= i <= d$ に対して、 $X_(i) := "pr"_(i): RR^(d) -> RR$ (射影)
]

#proof[
  確率空間を構成する。

  - $P_(
    (X_(1), dots ,X_(d))_(abs)
  )(X_(1) <= x_(1) and dots and X_(d) <= x_(d))
          := integral_(- infinity)^(x^()_(1)) dots integral_(- infinity)^(x_(d))
                  p(x^'_(1), dots ,x^'_(d)) dif x^'_(1) dots dif x^'_(d)$
  - $product_(i)(-infinity, x_(i)]$ は $frak(B)(RR^(d))$ の生成元
  - よって、$P_(
    (X_(1), dots ,X_(d))_(abs)
  )$ は $frak(B)(RR^(d))$ 上の確率測度
]

== 累積分布関数

- 確率密度関数を$-infinity$から$x$まで積分したもの


== 確率質量関数 (= Px3の時に確率分布って適当に書かれてたらこれ)


$
p_(x_("dis")):RR -> [0,1] \ x arrow P_(x_(3))({x})
$


== d変数確率密度関数

Radon-Nikodymの定理の多変数版から定まる
$p_(
  (X_(1), dots ,X_(d))_(abs)
): RR^(d) -> RR_(>=0)$

---
↓一つの確率測度(確率分布)$P$について述べている

= 平均情報量(エントロピー)

$(Omega, F, P)$: 確率空間

$X$: 確率変数

$(bb{R}, frak{B}(bb{R}),P_X)$: 上記から定まる確率空間

$
H^P_("entropy")(X) 
  := H_("entropy")(p_(X_("abs"))) 
  := -integral_(x in X) dif x
    p_(X_("abs"))(x)
    log p_(X_("abs"))(x)
$

== エントロピーの値の範囲

$ 0 <= H_("entropy")(p_(X_("abs"))) $ （誤り）

= 条件付き確率

$(Omega, F, P)$: 確率空間, $A, B in F$ について、

$P_("condi")(dot.c | dot.c): F times F -> [0,1]$

$
P_("condi")(A|B) 
  := (
    P(A sect B)
  )/(
    P(B)
  )
$

== 確率空間複数バージョン

確率空間 $(bb{R}^d, frak{B}(bb{R}^d),P_d)$, $(bb{R}^(d-1), frak{B}(bb{R}^(d-1)),P_(d-1))$

確率変数 $X_d: bb{R}^d -> bb{R}$, $X_(d-1): bb{R}^(d-1) -> bb{R}$ について、

$A_d in frak{B}(bb{R}^d), B_(d-1) in frak{B}(bb{R}^(d-1))$ について、

$P_("condi")^(P_d,P_(d-1)): frak{B}(bb{R}^d) times frak{B}(bb{R}^(d-1)) -> [0,1]$

$
P_("condi")^(P_d,P_(d-1))(A_d | B_(d-1)) 
  := (
    P_d(A_d sect (B_(d-1) times bb{R}))
  )/(
    P_(d-1)(B_(d-1))
  )
$

= 条件つき確率密度関数

確率空間 $(bb{R}, frak{B}(bb{R}),P)$

$(Y_1, Y_2)$: 1変数確率変数 $Y_1, Y_2$ によって定まる2変数確率変数

$p^("condi")_((Y_1, Y_2)_("abs"))(dot.c|dot.c):bb{R} times bb{R} -> bb{R}_(>=0)$

$
p^("condi")_((Y_1, Y_2)_("abs"))(y_1 | y_2) 
  := (
    p^("joint")_((Y_1, Y_2)_("abs"))(y_1, y_2)
  )/(
    p_(Y_2\ "abs")(y_2)
  )
$

== 確率空間複数バージョン

確率測度、$P_("condi")^(P_d,P_(d-1))$ からRandon-Nikodymの定理により定まる、

$
p_("condi")^(P_d | P_(d-1)): 
  bb{R}^d times bb{R}^(d-1) -> bb{R}_(>=0)
$

を、条件付き確率密度関数という

= 結合確率

確率空間 $(bb{R}^d, frak{B}(bb{R}^d),P_d)$, $(bb{R}^(d-1), frak{B}(bb{R}^(d-1)),P_(d-1))$

確率変数 $X_d: bb{R}^d -> bb{R}$, $X_(d-1): bb{R}^(d-1) -> bb{R}$ について、

$A_d in frak{B}(bb{R}^d), B_(d-1) in frak{B}(bb{R}^(d-1))$ について、

$
P_("joint")(A_d, B_(d-1)) 
  := P_d(A_d)P_("condi")(A_d | B_(d-1))
$

= 結合エントロピー (joint entropy)

== 確率空間ひとつバージョン

確率空間 $(bb{R}, frak{B}(bb{R}),P)$
確率変数 $X, Y$ について、

$
H^P_("joint")(X, Y) 
  := H_("joint")(p^("joint")_((X, Y)_("abs"))) 
  := -integral_(x in X, y in Y) dif x dif y
    p^("joint")_((X, Y)_("abs"))(x, y)
    log (
      p^("joint")_((X, Y)_("abs"))(x, y)
    )
$

定義から直ちに、
$
H_("joint")(Y, X) = H_("joint")(X, Y) 
#h(40pt) "論文(25)"
$
がいえる。

== 確率空間複数バージョン

= 条件付きエントロピー (conditional entropy)

確率空間 $(bb{R}, frak{B}(bb{R}),P)$

確率変数 $X, Y$ について、

$
H^P_("condi")(Y|X) 
  := -integral_(x in X, y in Y) dif x dif y
    p^("joint")_((Y, X)_("abs"))(y, x)
    log (
      (p^("joint")_((Y, X)_("abs"))(y, x))
      /
      (p_(X_("abs"))(x))
    )
$
$
  = -integral_(x in X, y in Y) dif x dif y
    p^("joint")_((Y, X)_("abs"))(y, x)
    log (
      p^("condi")_((Y,X)_("abs"))(y | x)
    )
$

#theorem(name: "Claim")[
以下が成り立つ
$
H^P_("condi")(Y | X) 
  = H^P_("condi")(X | Y) 
    + H^P_("entropy")(Y) 
    - H^P_("entropy")(X)
$
]

#proof[
$
("右辺") 
  &= H^P_("condi")(X | Y) 
    + H^P_("entropy")(Y) 
    - H^P_("entropy")(X) \
&= -integral_(x in X, y in Y) dif x dif y
    p^("joint")_((X, Y)_("abs"))(x, y)
    log (
      p^("condi")_((X, Y)_("abs"))(x | y)
    )
  - integral_(y in Y) dif y
    p_(Y_("abs"))(y) 
    log p_(Y_("abs"))(y)
  + integral_(x in X) dif x
    p_(X_("abs"))(x)
    log p_(X_("abs"))(x)
#h(40pt) ("∵def.") \
&= -integral_(x in X, y in Y) dif x dif y
    p^("joint")_((X, Y)_("abs"))(x, y) dot.c
    log (
      (p^("joint")_((X, Y)_("abs"))(x, y))
      /
      (p_(Y_("abs"))(y))
    )
  - integral_(y in Y) dif y
    p_(Y_("abs"))(y) 
    log p_(Y_("abs"))(y)
  + integral_(x in X) dif x
    p_(X_("abs"))(x)
    log p_(X_("abs"))(x)
#h(40pt) ("∵" p_("joint") "のdef.") \
&= -integral_(x in X, y in Y) dif x dif y (
    p^("joint")_((X, Y)_("abs"))(x, y) dot.c (
      log (p^("joint")_((X, Y)_("abs"))(x, y)) 
      - log (p_(Y_("abs"))(y))
    )
  )
  - integral_(y in Y) dif y
    p_(Y_("abs"))(y) 
    log p_(Y_("abs"))(y)
  + integral_(x in X) dif x
    p_(X_("abs"))(x)
    log p_(X_("abs"))(x) \
&= -integral_(x in X, y in Y) dif x dif y (
    p^("joint")_((X, Y)_("abs"))(x, y) dot.c (
      log (p^("joint")_((X, Y)_("abs"))(x, y))
    )
  )
  + cancel(
    integral_(x in X, y in Y) dif x dif y (
      p^("joint")_((X, Y)_("abs"))(x, y) dot.c (
        log (p_(Y_("abs"))(y))
      )
    )
  )
  cancel(
    - integral_(y in Y) dif y
      p_(Y_("abs"))(y) 
      log p_(Y_("abs"))(y)
  )
  + integral_(x in X) dif x
    p_(X_("abs"))(x)
    log p_(X_("abs"))(x) \
&= -integral_(x in X, y in Y) dif x dif y (
    p^("joint")_((X, Y)_("abs"))(x, y) dot.c (
      log (p^("joint")_((X, Y)_("abs"))(x, y))
    )
  )
  + integral_(x in X) dif x
    p_(X_("abs"))(x)
    log p_(X_("abs"))(x) \
&= -integral_(x in X, y in Y) dif x dif y (
    p^("joint")_((X, Y)_("abs"))(x, y) dot.c (
      log (p^("joint")_((X, Y)_("abs"))(x, y))
    )
  )
  + integral_(x in X, y in Y) dif x dif y (
    p^("joint")_((X, Y)_("abs"))(x, y) dot.c (
      log (p_(X_("abs"))(x))
    )
  ) \
&= -integral_(x in X, y in Y) dif x dif y (
    p^("joint")_((X, Y)_("abs"))(x, y) dot.c (
      log (
        (p^("joint")_((X, Y)_("abs"))(x, y))
        /
        (p_(X_("abs"))(x))
      )
    )
  ) \
&= -integral_(x in X, y in Y) dif x dif y (
    p^("joint")_((Y, X)_("abs"))(y, x) dot.c (
      log (
        (p^("joint")_((Y, X)_("abs"))(y, x))
        /
        (p_(X_("abs"))(x))
      )
    )
  ) \
&= H^P_("condi")(Y | X) 
#h(40pt) ("論文(27)")
$
]

// ... (前の部分の続き)

#heading(level: 2)[交差エントロピー (cross entropy)]

$X$: 可測空間$(Omega, F)$上の確率変数

$(Omega, F, P),(Omega,F, Q)$: 確率空間

$(RR, frak(B)(RR),P_X), (RR, frak(B)(RR),Q_X)$: 上記から定まる確率空間

について、

$
H_("cross")(P_X, Q_X) :=
  -sum_(i=1)^(infinity) p_(X_("dis"))(x_i) log(q_(X_("dis"))(x_i))
  - integral_(x in RR) dif x
    p_(X_("abs"))(x) log(q_(X_("abs"))(x))
$

$p_(X_("dis")) = q_(X_("dis")) = 0$のとき、
$
H_("cross")(p_(X_("abs")), q_(X_("abs"))) := H_("cross")(P_X, Q_X)
$
ともかく。

#heading(level: 2)[KL-ダイバージェンス]

$X$: 可測空間$(Omega, F)$上の確率変数

$(Omega, F, P),(Omega,F, Q)$: 確率空間

$(RR,frak(B)(RR), P_X), (RR,frak(B)(RR), Q_X)$: 上記から定まる確率空間

について、
$
D_(K L)(P_X || Q_X) :=
  sum_(i=1)^(infinity) p_(X_("dis"))(x_i) log(
    frac(p_(X_("dis"))(x_i), q_(X_("dis"))(x_i))
  )
  + integral_(RR) p_(X_("abs"))(x) log(
    frac(p_(X_("abs"))(x), q_(X_("abs"))(x))
  ) dif x
$

$p_(X_("dis")) = q_(X_("dis")) = 0$のとき、
$
D_(K L)(p_(X_("abs")) || q_(X_("abs"))) := D_(K L)(P_X || Q_X)
$
ともかく。

#heading(level: 3)[確率変数が複数ある状況の場合]
$X, Y$: 可測空間$(Omega, F)$上の確率変数

$(Omega, F, P)$: 確率空間

を考えると、

$id_(RR)$: 可測空間$(RR,frak(B)(RR))$上の確率変数 (恒等写像)

$(RR,frak(B)(RR), P_X),(RR,frak(B)(RR), P_Y)$: 確率空間

$(RR,frak(B)(RR), (P_X)_(id_(RR))), (RR,frak(B)(RR), (Q_X)_(id_(RR)))$: 確率空間

として、KL-ダイバージェンス を考えることができる。

#heading(level: 2)[parametricな問題]

$
exists p: RR times RR -> RR, quad (x, theta) |-> p_theta(x), "具体的に計算可能", \
exists theta_0 in RR "s.t." p_(X_("abs")) = p_(theta_0)
$

$p_(X_("abs"))$を求める問題をparametricな問題という

($p_(x_3)$についてもだいたい同じ)

#heading(level: 2)[likelihood function]

$(x_i)_(i=1)^n$: n回のtrial が与えられた時、

$
L: RR -> RR, quad theta |-> product_(i=1)^n p(x_i, theta)
$

#heading(level: 2)[log-likelihood function]

$(x_i)_(i=1)^n$: n回のtrial が与えられた時、

$
L_("log"): RR -> RR, quad theta |-> sum_(i=1)^n log(p(x_i, theta))
$

#heading(level: 2)[likelihood estimation]

$L, L_("log")$の最大値、もしくは極値を求める

コイン投げの場合、尤度関数は上に凸なので、極値が求まれば良い

#heading(level: 1)[Sanovの定理]

参考) https://genkuroki.github.io/documents/mathtodon/2017-04-27%20Kullback-Leibler情報量とは何か？.pdf

#heading(level: 2)[経験分布]

r面サイコロを振るということを考える

$
cal(P) = {p = (p_1, ..., p_r) in RR^r | p_1, ..., p_r >= 0, p_1 + ... + p_r = 1}
$

と定めると、$cal(P)$は、有限集合 ${1, ..., r}$上の確率質量関数の集合と同一視できる。

$q = (q_1,...,q_r) in cal(P)$ を固定する。これはあるサイコロqを固定するということ。

$Omega_q := {"サイコロqを投げた時にiが出る" | i=1, ..., r}$

確率空間: $((Omega_q)^n, F_q^n = 2^((Omega_q)^n), P^n)$

$X in F_q^n$は、

$
X = {(ell_i^1)_(i=1,...,n) ,...,  (ell_i^j)_(i=1,...,n)} \
(j=0,...,r^n, 1 <= ell_i^j <= r, "ただしj=0の時はX=" "empty")
$

と書ける

$
r^n: "全ての根源事象の数" \
(ell_i^j)_(i=1,...,n): "ある事象Xの中で、i回目に"ell_i^j"が出るようなj番目の根源事象"
$

$P^n: F_q^n -> RR $ を、

$
P^n({(ell_i^1)_(i=1,...,n) ,...,  (ell_i^j)_(i=1,...,n)}) :=
  (q_(ell^1_1) q_(ell^1_2) ... q_(ell^1_n))
  + ... +
  (q_(ell^j_1) q_(ell^j_2) ... q_(ell^j_n))
$

と定める。

$(k_i)_(i=1,...,n)$について、

$
X_((k_w)_(w=1,...,r)) :=
  {(ell_i^j)_(i=1,...,n) |
    ^(forall) w ((ell_i^j = w"となる個数") = k_w)}
$

なる事象の起こる確率は、$\#X_((k_w))_(w=1,...,r) = frac(n !, (k_1 ! ... k_r !))$なので、

$
P^n(X_((k_w)_(w=1,...,r))) = frac(n !, k_1 ! ... k_r !) q_1^(k_1) ... q_r^(k_r)
$

となる。

ここで、集合$cal(P)_n$を、

$
cal(P)_n = {(frac(k_1, n), ..., frac(k_r, n)) |
  k_i = 0,1, ..., n, k_1 + ... + k_r = n}
$

と定めると、

$
cal(P)_n subset cal(P)
$

であり、$\#cal(P)_n <= (n+1)^r$ である。

このような$cal(P)_n$の元を、

$
X_((k_i)_(i=1,...,n))"に対しての経験分布"
$

という。

#heading(level: 2)[Sanovの定理]

$q = (q_1,...,q_r) in cal(P)$と、上記の記号の元、確率空間$(cal(P)_n, 2^(cal(P)_n), P_(cal(P)_n, q))$を考える

確率測度は以下のように定める

$
P_(cal(P)_n, q)^(prime): cal(P)_n "の一点集合の集合" -> RR \
{(frac(k_1, n), ..., frac(k_r, n))} |->
  frac(n !, k_1 ! ... k_r !) q_1^(k_1) ... q_r^(k_r)
$

$
P_(cal(P)_n, q): 2^(cal(P)_n) -> RR \
{x_1,...,x_k} |-> sum_i^k P_(cal(P)_n, q)^(prime)({x_i})
$

#theorem(name: "1")[
  $A subset cal(P)$ がopenである時

  $
  liminf_(n -> infinity) frac(1, n) log P_(cal(P)_n, q)(A sect cal(P)_n)
  >= -inf_(p in A) D_(\KL)(p || q)
  $

  Aを大きくすると、

  ((左辺)の$frac(1, n) log P_(cal(P)_n, q)(A sect cal(P)_n)$)は、大きくなるか変わらない

  (右辺)は、大きくなるか変わらない
]

#theorem(name: "2")[
  $A subset cal(P)$について、

  $
  limsup_(n -> infinity) frac(1, n) log P_(cal(P)_n, q)(A sect cal(P)_n)
  <= -inf_(p in A) D_(\KL)(p || q)
  $
]

#theorem(name: "3")[
  $A subset cal(P)$が、内部が閉包に含まれるならば、

  $
  lim_(n -> infinity) frac(1, n) log P_(cal(P)_n, q)(A sect cal(P)_n)
  = -inf_(p in A) D_(\KL)(p || q)
  $
]

- 仮説Aをとる
    - Aは絞られてるほうが、実用上「いい仮説」と言える
            - が、Sanovの定理ではそこは興味ない
    - $P_(cal(P)_n, q)(A sect cal(P)_n)$ : n回試行時の経験分布がAに入る確率

    → n回振って得られた経験分布を何個も取得して、$P_(cal(P)_n, q)(A sect cal(P)_n)$を定める

    - 左辺のnをどんどん大きくして、収束する値によって、Aの「正解っぽさ」がわかる
            - もし0に収束しているのならば、Aに真の分布qが含まれていることがわかる

= 2. Algorithm

- 順拡散過程と逆拡散過程の定義
- 逆拡散過程の学習方法
- 逆拡散過程のentropy bounds(エントロピー下界？)を導出する

=== マルコフ拡散カーネル (Markov kernel, 積分変換)

$
T_pi: RR^n times RR^n times RR -> RR_("≥0"),
(bold(y), bold(y)', beta) |-> (bold(y) | bold(y)'\; beta)
$　($beta$は、拡散率)

$T_pi$は、$d in ZZ_("≥1")$として、任意の$n dot d$変数確率密度関数 $q: RR^(n dot d) -> RR$ に対して、
$
q(x_1, dots, x_d) dot T_pi(x_(d+1) | x_d\; beta)
"はn" dot (d+1)"変数確率密度関数"
$

$pi: RR^n -> RR$ は、以下の第二種フレドホルム積分方程式の解
$
pi(bold(y)) = integral dif bold(y)'
  T_pi(bold(y) | bold(y)'\; beta)
  pi(bold(y)')
$

===== 正規分布を使った$pi$と$T_pi$がフレドホルム積分方程式の解であること
一次元でチェックする

$pi(y) := cal(N)(y, 0, 1) = 1/(sqrt(2pi)) exp(-y^2/2)$

$
T_pi(y | y'\; beta) := cal(N)(y, y'sqrt(1-beta), beta)
  = 1/(sqrt(2pi beta^2))
    exp(-(y-y'sqrt(1-beta))^2/(2beta^2))
$

とおく

$pi(y) = integral dif y' T_pi(y | y'\; beta) pi(y')$ が、上記に対して成り立つことを確認する
$
("右辺")
&= integral dif y'
    1/(sqrt(2pi beta^2))
    exp(-(y-y'sqrt(1-beta))^2/(2beta^2))
    1/(sqrt(2pi)) exp(-y'^2/2) \
&= 1/(2pi beta) integral dif y'
    exp(
      -(y-y'sqrt(1-beta))^2/(2beta^2)
      - y'^2/2
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      -(y-y'sqrt(1-beta))^2/(2beta^2)
      - y'^2 beta^2/(2beta^2)
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      - (y'^2 beta^2/(2beta^2)
        + (-y'sqrt(1-beta) + y)^2/(2beta^2))
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      - (y'^2 beta^2 + (-y'sqrt(1-beta) + y)^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      - (y'^2 beta^2 + (1-beta)y'^2
        - 2sqrt(1-beta)y y' + y^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      - (y'^2 (1-beta+beta^2) - 2sqrt(1-beta)y y' + y^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      - ((1-beta+beta^2)
        (y'^2 - (2sqrt(1-beta)y y')/(1-beta+beta^2))
        + y^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      - ((1-beta+beta^2)
        (y'^2 - (2sqrt(1-beta)y y')/(1-beta+beta^2)
          + ((1-beta)y^2)/((1-beta+beta^2)^2)
          - ((1-beta)y^2)/((1-beta+beta^2)^2))
        + y^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      - ((1-beta+beta^2)
        ((y' - (sqrt(1-beta)y)/(1-beta+beta^2))^2
          - ((1-beta)y^2)/((1-beta+beta^2)^2))
        + y^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      - ((1-beta+beta^2)(y' - (sqrt(1-beta)y)/(1-beta+beta^2))^2
        - (1-beta+beta^2) ((1-beta)y^2)/((1-beta+beta^2)^2)
        + y^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      - ((1-beta+beta^2)(y' - (sqrt(1-beta)y)/(1-beta+beta^2))^2
        - ((1-beta)y^2)/(1-beta+beta^2)
        + y^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      - ((1-beta+beta^2)(y' - (sqrt(1-beta)y)/(1-beta+beta^2))^2
        - ((1-beta) - (1-beta+beta^2))
          /(1-beta+beta^2) y^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      - ((1-beta+beta^2)(y' - (sqrt(1-beta)y)/(1-beta+beta^2))^2
        + (beta^2)/(1-beta+beta^2) y^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta)
    exp(
      - ((beta^2)/(1-beta+beta^2) y^2)
        /(2beta^2)
    )
    integral dif y'
    exp(
      - ((1-beta+beta^2)(y' - (sqrt(1-beta)y)/(1-beta+beta^2))^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta)
    exp(
      - ((beta^2)/(1-beta+beta^2) y^2)
        /(2beta^2)
    )
    sqrt(pi / ((1-beta+beta^2)/(2beta^2))) \
&= 1/(2pi beta)
    sqrt((2pi beta^2)/(1-beta+beta^2))
    exp(
      - (y^2)/(2(1-beta+beta^2))
    ) \
&= 1/(sqrt(2pi(1-beta+beta^2)))
    exp(
      - (y^2)/(2(1-beta+beta^2))
    ) \
&= cal(N)(y, 0, sqrt(1-beta+beta^2))
$

あわんかったので、$T_pi(y | y'\; beta) := cal(N)(y, m y', beta)$で計算して、噛み合う$m$を見つける。

$pi(y) := cal(N)(y, 0, 1) = 1/(sqrt(2pi)) exp(-y^2/2)$

$
T_pi(y | y'\; beta) := cal(N)(y, m y', beta)
  = 1/(sqrt(2pi beta^2))
    exp(-(y-m y')^2/(2beta^2))
$

とおく

$
("右辺")
&= integral dif y'
    1/(sqrt(2pi beta^2))
    exp(-(y-m y')^2/(2beta^2))
    1/(sqrt(2pi)) exp(-y'^2/2) \
&= 1/(2pi beta) integral dif y'
    exp(-(y'^2 beta^2 + m^2 y'^2 - 2m y y' + y^2)/(2beta^2)) \
&= 1/(2pi beta) integral dif y'
    exp(-((beta^2 + m^2) y'^2 - 2m y y' + y^2)/(2beta^2)) \
&= 1/(2pi beta) integral dif y'
    exp(
      - ((beta^2 + m^2)
        (y'^2 - (2m y y')/(beta^2 + m^2))
        + y^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      - ((beta^2 + m^2)
        (y'^2 - (2m y y')/(beta^2 + m^2)
          + (m^2 y^2)/((beta^2 + m^2)^2)
          - (m^2 y^2)/((beta^2 + m^2)^2))
        + y^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      - ((beta^2 + m^2)
        ((y' - (m y)/(beta^2 + m^2))^2
          - (m^2 y^2)/((beta^2 + m^2)^2))
        + y^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta) integral dif y'
    exp(
      - ((beta^2 + m^2)
        (y' - (m y)/(beta^2 + m^2))^2
        - (m^2 y^2)/(beta^2 + m^2)
        + y^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta)
    exp(
      - ((m^2 y^2)/(beta^2 + m^2) - y^2)
        /(2beta^2)
    )
    integral dif y'
    exp(
      - ((beta^2 + m^2)
        (y' - (m y)/(beta^2 + m^2))^2)
        /(2beta^2)
    ) \
&= 1/(2pi beta)
    exp(
      - ((m^2 y^2 - (beta^2 + m^2) y^2)
        /(beta^2 + m^2))
        /(2beta^2)
    )
    sqrt(pi / ((beta^2 + m^2)/(2beta^2))) \
&= 1/(2pi beta)
    sqrt((2pi beta^2)/(beta^2 + m^2))
    exp(
      - ((beta^2 y^2)/(beta^2 + m^2))
        /(2beta^2)
    ) \
&= 1/(sqrt(2pi(beta^2 + m^2)))
    exp(
      - (y^2)/(2(beta^2 + m^2))
    ) \
&= cal(N)(y, 0, sqrt(beta^2 + m^2)) (*)
$

$sqrt(beta^2 + m^2) = 1$ より、 $m = sqrt(1-beta^2)$

よって、

$
T_pi(y | y'\; beta) := cal(N)(y, sqrt(1 - beta^2) y', beta)
  = 1/(sqrt(2pi beta^2))
    exp(-(y-sqrt(1 - beta^2) y')^2/(2beta^2))
$

次回(6/1)
- 連続だと思って計算しているのが、本当は離散じゃないと成り立たないみたいな状況を定量化できると面白いのでは？
   - 松尾研で質問してみる \@浅香先生 (6/10)
- Appendix Aの各定理をまとめる。(28) - (36)
  - (28)を↑の積分チェックして完了
  - $T_pi$になんか条件があるかも (Tpi自体確率密度関数みたいな) ($p(0) = pi$ とか)
- (次回:Appendix B. で、上記の計算を進める)
  - $H_q(X^(T))$ を、定義に合わせる
  - すると、Appendix B. (43) に着地
  - Appendix A.を読む
     - ↑ Lの下限が 2.4 (14) の形にすることで示せる
- [いつか] 離散で書き直してみる
- 関数解析に踏み込むとしたら
    - 形状最適化問題
- vscodeでTexで書く方法に移植する
- ↑βが小さい時にforwardとreverseが等しくなる、はよくわからないので保留
- モデルの実装(on github)も見てみる https://github.com/Sohl-Dickstein/Diffusion-Probabilistic-Models/blob/master/model.py
- 一旦読み終えてみてから、参考文献見てみる？
        - ガウス過程云々

---

$"def."$

$0 <= i <= T"に対して" X^(i) = RR^n$

$1 <= i <= T"に対して" beta_i in RR$ : t-1とtの間の拡散率

$X^(i dots j) := product_(t=i)^j X^(t)$

$bold(x)^(i dots j) := (bold(x)^(i), dots, bold(x)^(j)) in X^(i dots j)$ と書く

== 2.1. Forward Trajectory

次回(7/20)
- $q^(0)$という実数値函数から、$q^(0...T)$まで定める
    - $q^(0)$の条件は可測で全域積分すると1, $q^(0...T)$も満たしている(はず)
    - -> 確率空間$(RR^(T+1), cal(B)(RR^(T+1)), Q^(0...T))$ が定まる 
- $q^(0...T)$を周辺化(Tの軸で微分する)すると、$q^(0...T-1)$になることを確かめる
- 結合確率・条件付き確率・エントロピーなど、一通り、確率密度関数を使って定義し直す

$Q^(0): cal(B)(X^(0)) -> RR$: 確率測度

$q^(0)_(X_("abs")): X^(0) -> RR,\ Q^(0)$から定まる確率密度関数

$q^(0 dots i)_(X_("abs")): X^(0 dots i) -> RR$を

$
q^(0 dots i)_(X_("abs"))(bold(x)^(0 dots i))
  := q^(0)_(X_("abs"))(bold(x)^(0))
    product_(j=1)^i (
      T_pi(bold(x)^(j) | bold(x)^(j-1)\; beta_j)
    )
$

$q^(T)_(X_("abs")): X^(T) -> RR,\
q^(T)_(X_("abs"))(bold(x)^(T))
  := integral dif bold(y)^(0 dots T-1)
    q^(0 dots T)_(X_("abs"))(
      bold(y)^(0 dots T-1), bold(x)^(T)
    )$

また、Radon-Nikodymの逆より、$q^(0 dots i)_(X_("abs")), q^(T)_(X_("abs"))$からそれぞれ、

$Q^(0...i): cal(B)(X^(0 dots i)) -> RR$: 確率測度

$Q^(T): cal(B)(X^(T)) -> RR$: 確率測度

が定まる。

===== 論文との対応

- $H_q(bold(x)^(t)) = H_("entropy")(q^(0 dots t)_(X_("abs")))$
- $
  H_q(bold(x)^(t-1) | bold(x)^(t))
    = -integral_(
        bold(x)^(0 dots t-1) in product_(j=0)^(t-1) X^(j),
        bold(x)^(0 dots t) in product_(j=0)^t X^(j)
      )
      dif bold(x)^(0 dots i) dif y
      p^("joint")_((Y, X)_("abs"))(y, bold(x)^(0 dots i))
      log(
        p^("condi")_((Y, X)_("abs"))(y | bold(x)^(0 dots i))
      )
  $
- $q(bold(x)^(j) | bold(x)^(j-1)) = T_pi(bold(x)^(j) | bold(x)^(j-1)\; beta_j)$

==== 公式1 (ガウス積分)
$
integral_x (
  alpha dot exp(-gamma dot (x-beta)^2)
) dif x
= alpha dot sqrt(pi/gamma)
$

==== 公式2
$
integral_x (
  alpha dot
  (-gamma dot (x-beta)^2) dot
  exp(-gamma dot (x-beta)^2)
) dif x
= -alpha/2 sqrt(pi/gamma)
$

====== 導出
$y := sqrt(gamma)(x - beta) "とおくと、" dif x = 1/(sqrt(gamma)) dif y "より"$
$
integral_y (
    alpha dot exp(-y^2) dot (-y^2)
  ) 1/(sqrt(gamma)) dif y \
&= -1/(sqrt(gamma)) alpha
  integral_y y^2 dot exp(-y^2) dif y \
&= -1/(sqrt(gamma)) alpha (sqrt(pi)/2) \
&= -alpha/2 sqrt(pi/gamma)
$


#theorem(
  name: $"Claim" H_("entropy")(q^((0 dots t))_(X_("abs"))) >= H_("entropy")(q^((0 dots t-1))_(X_("abs"))) ("論文"(28))$,
  [
    $
    T_pi(
      x^((t)) | x^((t-1))\; beta_t
    )
    :=
    cal(N)(
      x^((t)),
      sqrt(1 - beta_t^2) x^((t-1)),
      beta_t
    )
    =
    1 / (
      sqrt(2 pi beta_t^2)
    )
    exp(
      -(
        (x^((t)) - sqrt(1 - beta_t^2) x^((t-1)))^2
      ) / (
        2 beta_t^2
      )
    )
    $

    とするとき、$beta_t >= sqrt(1 / (2 pi e))$ ならば、

    $
    H_("entropy")(
      q^((0 dots t))_(X_("abs"))
    )
    >=
    H_("entropy")(
      q^((0 dots t-1))_(X_("abs"))
    )
    $

    が成り立つ。
  ]
)

#proof[
  $
  q^((0 dots t))_(X_("abs"))(x^((0 dots t)))
  =
  q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
  dot
  T_pi(
    x^((t)) | x^((t-1))\; beta_t
  )
  $
  であるから、

  $
  "右辺"
  =
  H_("entropy")(q^((0 dots t-1))_(X_("abs")))
  =
  -integral_(x^((0 dots t-1)) in product_(j=0)^(t-1) X^((j)))
    dif x^((0 dots t-1))
    q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
    dot
    log(
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
    )
  $

  $
  "左辺"
  =
  H_("entropy")(q^((0 dots t))_(X_("abs")))
  &=
  -integral_(x^((0 dots t)) in product_(j=0)^t X^((j)))
    dif x^((0 dots t)) (
      q^((0 dots t))_(X_("abs"))(x^((0 dots t)))
      dot
      log(
        q^((0 dots t))_(X_("abs"))(x^((0 dots t)))
      )
    ) \
  &=
  -integral_(x^((0 dots t)) in product_(j=0)^t X^((j)))
    dif x^((0 dots t)) (
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      dot
      T_pi(x^((t)) | x^((t-1))\; beta_t)
      dot
      log(
        q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
        dot
        T_pi(x^((t)) | x^((t-1))\; beta_t)
      )
    ) \
  &=
  -integral_(x^((0 dots t)) in product_(j=0)^t X^((j)))
    dif x^((0 dots t)) (
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      dot
      T_pi(x^((t)) | x^((t-1))\; beta_t)
      dot (
        log(
          q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
        )
        +
        log(
          T_pi(x^((t)) | x^((t-1))\; beta_t)
        )
      )
    ) \
  &=
  -integral_(x^((0 dots t)) in product_(j=0)^t X^((j)))
    dif x^((0 dots t)) (
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      dot
      T_pi(x^((t)) | x^((t-1))\; beta_t)
      dot (
        log(
          q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
        )
      )
    ) \
  &quad
  -integral_(x^((0 dots t)) in product_(j=0)^t X^((j)))
    dif x^((0 dots t)) (
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      dot
      T_pi(x^((t)) | x^((t-1))\; beta_t)
      dot (
        log(
          T_pi(x^((t)) | x^((t-1))\; beta_t)
        )
      )
    )
  quad dots quad (*)
  $

  ---
  項を分ける

  $
  (*) "第1項"
  &=
  -integral_(x^((0 dots t-1)) in product_(j=0)^(t-1) X^((j)))
    dif x^((0 dots t-1)) (
      integral_(x^((t)) in X^((t)))
        dif x^((t)) (
          q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
          dot
          T_pi(x^((t)) | x^((t-1))\; beta_t)
          dot
          log(
            q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
          )
        )
    ) \
  &=
  -integral_(x^((0 dots t-1)) in product_(j=0)^(t-1) X^((j)))
    dif x^((0 dots t-1)) (
      integral_(x^((t)) in X^((t)))
        dif x^((t)) (
          q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
          dot
          log(
            q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
          )
          dot
          T_pi(x^((t)) | x^((t-1))\; beta_t)
        )
    ) \
  &=
  -integral_(x^((0 dots t-1)) in product_(j=0)^(t-1) X^((j)))
    dif x^((0 dots t-1)) (
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      dot
      log(
        q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      )
      dot
      integral_(x^((t)) in X^((t)))
        dif x^((t)) (
          T_pi(x^((t)) | x^((t-1))\; beta_t)
        )
    ) \
  &=
  -integral_(x^((0 dots t-1)) in product_(j=0)^(t-1) X^((j)))
    dif x^((0 dots t-1)) (
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      dot
      log(
        q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      )
      dot
      integral_(x^((t)) in X^((t)))
        dif x^((t)) (
          1 / (
            sqrt(2 pi beta_t^2)
          )
          exp(
            -(
              (x^((t)) - sqrt(1 - beta_t^2) x^((t-1)))^2
            ) / (
              2 beta_t^2
            )
          )
        )
    ) \
  &=
  -integral_(x^((0 dots t-1)) in product_(j=0)^(t-1) X^((j)))
    dif x^((0 dots t-1)) (
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      dot
      log(
        q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      )
      dot
      underbrace(
        integral_(x^((t)) in X^((t)))
          dif x^((t)) (
            underbrace(
              1 / (
                sqrt(2 pi beta_t^2)
              )
            , alpha)
            exp(
              -underbrace(
                1 / (
                  2 beta_t^2
                )
              , gamma)
              dot (
                x^((t)) - sqrt(1 - beta_t^2) x^((t-1))
              )^2
            )
          )
      , 1)
    ) \
  &=
  -integral_(x^((0 dots t-1)) in product_(j=0)^(t-1) X^((j)))
    dif x^((0 dots t-1)) (
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      dot
      log(
        q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      )
    ) \
  &= "右辺" \
  \

  (*) "第2項"
  &=
  -integral_(x^((0 dots t)) in product_(j=0)^t X^((j)))
    dif x^((0 dots t)) (
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      dot
      T_pi(x^((t)) | x^((t-1))\; beta_t)
      dot (
        log(
          T_pi(x^((t)) | x^((t-1))\; beta_t)
        )
      )
    ) \
  &=
  -integral_(x^((0 dots t-1)) in product_(j=0)^(t-1) X^((j)))
    dif x^((0 dots t-1)) (
      integral_(x^((t)) in X^((t)))
        dif x^((t)) (
          q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
          dot
          T_pi(x^((t)) | x^((t-1))\; beta_t)
          dot (
            log(
              T_pi(x^((t)) | x^((t-1))\; beta_t)
            )
          )
        )
    ) \
  &=
  -integral_(x^((0 dots t-1)) in product_(j=0)^(t-1) X^((j)))
    dif x^((0 dots t-1)) (
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      dot
      integral_(x^((t)) in X^((t)))
        dif x^((t)) (
          T_pi(x^((t)) | x^((t-1))\; beta_t)
          dot (
            log(
              T_pi(x^((t)) | x^((t-1))\; beta_t)
            )
          )
        )
    ) \
  &=
  -integral_(x^((0 dots t-1)) in product_(j=0)^(t-1) X^((j)))
    dif x^((0 dots t-1)) (
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      dot
      integral_(x^((t)) in X^((t)))
        dif x^((t)) (
          1 / (
            sqrt(2 pi beta_t^2)
          )
          exp(
            -(
              (x^((t)) - sqrt(1 - beta_t^2) x^((t-1)))^2
            ) / (
              2 beta_t^2
            )
          )
          dot (
            log(
              1 / (
                sqrt(2 pi beta_t^2)
              )
              exp(
                -(
                  (x^((t)) - sqrt(1 - beta_t^2) x^((t-1)))^2
                ) / (
                  2 beta_t^2
                )
              )
            )
          )
        )
    ) \
  &=
  -integral_(x^((0 dots t-1)) in product_(j=0)^(t-1) X^((j)))
    dif x^((0 dots t-1)) (
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      dot (
        integral_(x^((t)) in X^((t)))
          dif x^((t)) (
            1 / (
              sqrt(2 pi beta_t^2)
            )
            exp(
              -(
                (x^((t)) - sqrt(1 - beta_t^2) x^((t-1)))^2
              ) / (
                2 beta_t^2
              )
            )
            dot
            log(
              1 / (
                sqrt(2 pi beta_t^2)
              )
            )
          )
        +
        integral_(x^((t)) in X^((t)))
          dif x^((t)) (
            1 / (
              sqrt(2 pi beta_t^2)
            )
            exp(
              -(
                (x^((t)) - sqrt(1 - beta_t^2) x^((t-1)))^2
              ) / (
                2 beta_t^2
              )
            )
            dot (
              -(
                (x^((t)) - sqrt(1 - beta_t^2) x^((t-1)))^2
              ) / (
                2 beta_t^2
              )
            )
          )
      )
    ) \
&=
  -integral_(x^((0 dots t-1)) in product_(j=0)^(t-1) X^((j)))
    dif x^((0 dots t-1)) (
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      dot (
        cancel(
          1 / (
            sqrt(2 pi beta_t^2)
          )
        )
        dot
        log(
          1 / (
            sqrt(2 pi beta_t^2)
          )
        )
        dot
        underbrace(
          integral_(x^((t)) in X^((t)))
            dif x^((t)) (
              exp(
                -(
                  (x^((t)) - sqrt(1 - beta_t^2) x^((t-1)))^2
                ) / (
                  2 beta_t^2
                )
              )
            )
        ,
          cancel(sqrt(2 pi beta_t^2)) quad ("∵ガウス積分")
        )
        +
        cancel(
          1 / (
            sqrt(2 pi beta_t^2)
          )
        )
        dot
        underbrace(
          integral_(x^((t)) in X^((t)))
            dif x^((t)) (
              exp(
                -(
                  (x^((t)) - sqrt(1 - beta_t^2) x^((t-1)))^2
                ) / (
                  2 beta_t^2
                )
              )
              dot (
                -(
                  (x^((t)) - sqrt(1 - beta_t^2) x^((t-1)))^2
                ) / (
                  2 beta_t^2
                )
              )
            )
        , - 1/2 dot cancel(sqrt(2 pi beta_t^2)) quad ("∵公式2")
        )
      )
    ) \
  &=
  -integral_(x^((0 dots t-1)) in product_(j=0)^(t-1) X^((j)))
    dif x^((0 dots t-1)) (
      q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      dot (
        log(
          1 / (
            sqrt(2 pi beta_t^2)
          )
        )
        -
        1/2
      )
    ) \
  &=
  -(
    log(
      1 / (
        sqrt(2 pi beta_t^2)
      )
    )
    -
    1/2
  )
  dot
  underbrace(
    integral_(x^((0 dots t-1)) in product_(j=0)^(t-1) X^((j)))
      dif x^((0 dots t-1)) (
        q^((0 dots t-1))_(X_("abs"))(x^((0 dots t-1)))
      )
  , 1) \
  &=
  -(
    log(
      1 / (
        sqrt(2 pi beta_t^2)
      )
    )
    -
    1/2
  ) \
  &=
  1/2
  +
  1/2
  dot
  log(
    2 pi beta_t^2
  ) \
  &=
  1/2
  dot (
    1
    +
    log(
      2 pi beta_t^2
    )
  )
  $

  よって、

  $
  "左辺" - "右辺"
  &= 
  (
    "右辺"
    -
    1/2 (
      1
      +
      log(
        2 pi beta_t^2
      )
    )
  )
  -
  "右辺" \
  &=
  1/2 (
    1
    +
    log(
      2 pi beta_t^2
    )
  )
  $

  ゆえに、$beta_t >= sqrt(1 / (2 pi e))$ の時、不等式が成り立つ
]

めも(次回):  ここからtypst変換続ける

