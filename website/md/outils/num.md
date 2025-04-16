# Calculs numériques et symboliques (octave, numpy, pandas, scipy, sympy, matplotlib, seaborn)

## Octave

## Outils python du calcul scientifique

Dans l'écosystème python, plusieurs librairies pour le calcul scientifique sont incontournables :

- [numpy](https://numpy.org) : calcul numérique en général
- [scipy](https://scipy.org/) : traitement du signal
- [sympy](https://www.sympy.org) : calcul symbolique
- [matplotlib](https://matplotlib.org/) : tracé
- [seaborn](https://seaborn.pydata.org/) : tracé.



### Calcul numérique (numpy, scipy)

La librairie numpy est un incontournable pour le calcul numérique en python.
Avec un coeur écrit en C++ et un wrapper python, elle est à la foi efficace et
confortable d'utilisation. Vous trouverez des guides sur la page [https://numpy.org/learn/](https://numpy.org/learn/) pour prendre en main numpy.

Pour l'utiliser :

```bash
$ python3 -m pip install numpy
```

### Traitement des images (scikit-image, opencv)

Pour le traitement des images, des librairies standards comme OpenCV ou
scikit-image vous offrent un certain nombre d'algorithmes :

- [scikit-image](https://scikit-image.org/)
- [opencv](https://opencv.org/)

La librairie OpenCV en particulier est en partculier très développée avec des
algorithmes de calibration de caméra, détection de ligne (transformée de Hough,
opérateurs morphologiques, ...) . Pour 
l'utiliser en python, vous pouvez l'installer avec pip :

```bash
$ python3 -m pip install opencv-python-headless
```



### Calcul symbolique (sympy)

[sympy](https://www.sympy.org) est une librairie python qui va vous permettre de manipuler symboliquement des expressions mathématiques. Pour l'installer :

```bash
$ python3 -m pip install sympy
```

Par exemple, considérons deux référentiels A et B, l'orientation du référentiel
B dans le référentiel A étant donnée par le quaternion ($q_x, q_y, q_z, q_w)$.
On peut calculer symboliquement les coordonnées, dans le référentiel A, du vecteur $(1, 0, 0)$ dans le référentiel B, projeté sur le plan x-y du référentiel A à l'aide de sympy :

```python
import sympy
from sympy.algebras.quaternion import Quaternion
from sympy import symbols
from sympy import conjugate

qx = symbols('qx')
qy = symbols('qy')
qz = symbols('qz')
qw = symbols('qw')

q1 = Quaternion(qw, qx, qy, qz, real_field=True)

# Vecteur x dans le référentiel B
v = Quaternion(0, 1, 0, 0)

res = q1 * v * conjugate(q1)
print(f"Après rotation : {res}"))

horizontal_res = Quaternion(res.a, res.b, res.c, 0.0).normalize().simplify()
print(f"Vecteur projeté normalisé : {horizontal_res}")
```


### Tracé (matplotlib, seaborn)

### Machine learning (scikit-learn, pandas)
