## $H_{entropy}(q_{t+1}) > H_{entropy}(q_{t})$ の話
### 離散の場合 (確率質量関数)
以下の具体例は、

$
X, X' = (離散的な何か) \\
$
$
\forall x \in X \ \forall p_{(X,X')_{dis}}:結合確率質量関数 \ \forall p_{X_{dis}}:確率質量関数 \left(
    \sum_{x^{\prime} \in X^{\prime}} p_{(X,X')_{dis}}(x,x^{\prime}) = p_{X_{dis}}(x)
\right)$

が成り立つことを仮定している。

#### 具体例
$X, X' = \mathbb{Z}$

$m, n \in \mathbb{Z}_{\geq 1}$
$$
p_{X_{dis}}(x) :=
\begin{cases}
        \frac{1}{2m+1} & (x = -m, \dots, m) \\
        0 & (otherwise)
\end{cases}
$$
$$
p_{X'_{dis}}(x') :=
\begin{cases}
        \frac{1}{2n+1} & (x' = -n, \dots, n) \\
        0 & (otherwise)
\end{cases}
$$

に対して、

$$
\begin{align*}
H_{entropy}(p_{(X,X')_{dis}})
&= - \sum_{(x,x') \in X \times X'} \left(
        p_{(X,X')_{dis}}(x,x')\log(p_{(X,X')_{dis}}(x,x'))
\right) \\
&= - \sum_{x \in X} \left(
        \sum_{x' \in X'} \left(
                p_{(X,X')_{dis}}(x,x')\log(p_{(X,X')_{dis}}(x,x'))
        \right)
\right) \\
\end{align*}
$$

---

#### 2値の場合
$X = \{0, 1\}, X' = \{0, 1\}$

$s, t_{00}, t_{01}, t_{10}, t_{11} \in [0, 1]$ として、

$$
p_{X_{dis}}(x) =
\begin{cases}
        s & (x = 0) \\
        1 - s & (x = 1)
\end{cases}
$$      
$$
p_{(X_{dis},X'_{dis})}(x, x') =
\begin{cases}
        t_{00} & (x = 0, x' = 0) \\
        t_{01} & (x = 0, x' = 1) \\
        t_{10} & (x = 1, x' = 0) \\
        t_{11} & (x = 1, x' = 1)
\end{cases}
\\
ただし、
\\
\begin{align*}
t_{00} + t_{01} &= s \\
t_{10} + t_{11} &= 1 - s
\end{align*}
$$

これを, $t, u \in [0, 1]$ を用いて、

$$
\begin{align*}
t_{00} &= st \\
t_{01} &= s(1-t) \\
t_{10} &= (1-s)u \\
t_{11} &= (1-s)(1-u) \\
\end{align*}
$$


に対して、

$$
\begin{align*}
H_{entropy}(p_{(X,X')_{dis}})
&= - \sum_{(x,x') \in X \times X'} \left(
        p_{(X,X')_{dis}}(x,x')\log(p_{(X,X')_{dis}}(x,x'))
\right) \\
&= - \sum_{x=0}^{1} \left(
        \sum_{x^{\prime}=0}^{1} \left(
                p_{(X,X')_{dis}}(x,x')\log(p_{(X,X')_{dis}}(x,x'))
        \right)
\right) \\
&= - \sum_{x=0}^{1} \left(
        p_{(X,X')_{dis}}(x,0)\log(p_{(X,X')_{dis}}(x,0)) + p_{(X,X')_{dis}}(x,1)\log(p_{(X,X')_{dis}}(x,1))
\right) \\
&= - \left(
    p_{(X,X')_{dis}}(0,0)\log(p_{(X,X')_{dis}}(0,0))
    + p_{(X,X')_{dis}}(0,1)\log(p_{(X,X')_{dis}}(0,1))
    + p_{(X,X')_{dis}}(1,0)\log(p_{(X,X')_{dis}}(1,0))
    + p_{(X,X')_{dis}}(1,1)\log(p_{(X,X')_{dis}}(1,1))
\right) \\
&= - \left(
    t_{00}\log(t_{00}) + t_{01}\log(t_{01}) + t_{10}\log(t_{10}) + t_{11}\log(t_{11})
\right) \\
&= - \left(
    st\log(st) + s(1-t)\log(s(1-t)) + (1-s)u\log((1-s)u) + (1-s)(1-u)\log((1-s)(1-u))
\right) \\
&= - \left(
    st
    \left(
        \log(s) + \log(t)
    \right)
    +
    s(1-t)
    \left(
        \log(s) + \log(1-t)
    \right)
    +
    (1-s)u
    \left(
        \log(1-s) + \log(u)
    \right)
    +
    (1-s)(1-u)
    \left(
        \log(1-s) + \log(1-u)
    \right)
\right) \\
&= - \left(
    st
    \left(
        \log(s) + \log(t)
    \right)
    +
    s
    \left(
        \log(s) + \log(1-t)
    \right)
    -
    st
    \left(
        \log(s) + \log(1-t)
    \right)
    +
    (1-s)u
    \left(
        \log(1-s) + \log(u)
    \right)
    +
    (1-s)
    \left(
        \log(1-s) + \log(1-u)
    \right)
    -
    (1-s)u
    \left(
        \log(1-s) + \log(1-u)
    \right)
\right) \\
&= - \left(
    st
    \left(
        \log(s) + \log(t) - (\log(s) + \log(1-t))
    \right)
    +
    s
    \left(
        \log(s) + \log(1-t)
    \right)
    +
    (1-s)u
    \left(
        \log(1-s) + \log(u) - (\log(1-s) + \log(1-u))
    \right)
    +
    (1-s)
    \left(
        \log(1-s) + \log(1-u)
    \right)
\right) \\
&= - \left(
    st
    \left(
        \log(t) - \log(1-t)
    \right)
    +
    s
    \left(
        \log(s) + \log(1-t)
    \right)
    +
    (1-s)u
    \left(
        \log(u) - \log(1-u)
    \right)
    +
    (1-s)
    \left(
        \log(1-s) + \log(1-u)
    \right)
\right) \\
&= - \left(
    st
    \left(
        \log(t) - \log(1-t)
    \right)
    +
    s
    \left(
        \log(s) + \log(1-t)
    \right)
    +
    u
    \left(
        \log(u) - \log(1-u)
    \right)
    - su
    \left(
        \log(u) - \log(1-u)
    \right)
    +
    \left(
        \log(1-s) + \log(1-u)
    \right)
    - s
    \left(
        \log(1-s) + \log(1-u)
    \right)
\right) \\
&= - \left(
    st
    \left(
        \log(t) - \log(1-t)
    \right)
    +
    s
    \left(
        \log(s) + \log(1-t) - (\log(1-s) + \log(1-u))
    \right)
    +
    u
    \left(
        \log(u) - \log(1-u)
    \right)
    - su
    \left(
        \log(u) - \log(1-u)
    \right)
    +
    \left(
        \log(1-s) + \log(1-u)
    \right)
\right)
\end{align*}
$$

### 連続の場合 (確率密度関数)
#### このぐらいの一般性で考えたい
$X, X^{\prime} = \mathbb{R}$

$\forall x \in X, x^{\prime} \in X^{\prime} \left(
        p_{(X, X^{\prime})_{abs}}(x, x^{\prime}) = p_{X_{abs}}(x)p_{X^{\prime}_{abs}}(x^{\prime})
\right)$ を仮定すると、
$$
H^{joint}_{entropy}(p^{joint}_{(X,X^{\prime})_{abs}}) - H_{entropy}(p_{X_{abs}}) =
- \int_{(x,x^{\prime}) \in X \times X^{\prime}} \left(
    p_{X_{abs}}(x)p_{X^{\prime}_{abs}}(x^{\prime})\log(p_{X_{abs}}(x)p_{X^{\prime}_{abs}}(x^{\prime}))
\right)
- \left(
    - \int_{x \in X} \left(
            p_{X_{abs}}(x)\log(p_{X_{abs}}(x))
    \right) dx
\right)
$$

#### 具体例
$$
p_{X_{abs}}(x) :=
\begin{cases}
        \frac{1}{2m} & (x \in [-m, m]) \\
        0 & (otherwise)
\end{cases}
$$
$$
p_{X^{\prime}_{abs}}(x^{\prime}) :=
\begin{cases}
        \frac{1}{2n} & (x^{\prime} \in [-n, n]) \\
        0 & (otherwise)
\end{cases}
$$

こういうのを考えると、m,nの値によって増えたり増えなかったりしそう

$$
\begin{align*}
H^{joint}_{entropy}(p^{joint}_{(X,X^{\prime})_{abs}}) &= - \int_{(x,x^{\prime}) \in X \times X^{\prime}} \left(
        \frac{1}{2m}\frac{1}{2n}\log(\frac{1}{2m}\frac{1}{2n})
\right) dx dx^{\prime} \\
&= \int_{[-n,n]} \left(
        \int_{[-m,m]}  \left(
                \frac{1}{2m}\frac{1}{2n}\log(\frac{1}{2m}\frac{1}{2n})
        \right) dx
\right) dx^{\prime} \\
&= \int_{[-n,n]} \left(
        \frac{1}{2m}\frac{1}{2n}\log(\frac{1}{2m}\frac{1}{2n}) \cdot 2m
\right) dx^{\prime} \\
&= \frac{1}{2m}\frac{1}{2n}\log(\frac{1}{2m}\frac{1}{2n}) \cdot 2m \cdot 2n \\
&= \log(2m) + \log(2n) \\
\\
H_{entropy}(p_{X_{abs}}) &= - \int_{x \in X} \left(
        \frac{1}{2m}\log(\frac{1}{2m})
\right) dx \\
&= - \int_{[-m, m]} \left(
        \frac{1}{2m}\log(\frac{1}{2m})
\right) dx \\
&= - \frac{1}{2m}\log(\frac{1}{2m}) \cdot 2m \\
&= - \log(\frac{1}{2m}) \\
&= \log(2m) \\

\end{align*}
$$

よって、

$$
H^{joint}_{entropy}(p^{joint}_{(X,X^{\prime})_{abs}}) - H_{entropy}(p_{X_{abs}})
    = (\log(2m) + \log(2n)) - \log(2m) = \log(2n)
$$

よって、
$$
\begin{cases}
    H^{joint}_{entropy}(p^{joint}_{(X,X^{\prime})_{abs}}) \gt H_{entropy}(p_{X_{abs}}) & (n \gt \frac{1}{2}) \\
    H^{joint}_{entropy}(p^{joint}_{(X,X^{\prime})_{abs}}) = H_{entropy}(p_{X_{abs}}) & (n = \frac{1}{2}) \\
    H^{joint}_{entropy}(p^{joint}_{(X,X^{\prime})_{abs}}) \lt H_{entropy}(p_{X_{abs}}) & (n \lt \frac{1}{2})
\end{cases}
$$
