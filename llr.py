"""
Local Linear Regression implemented in pure python
translated from original notes and C++ written by my former boss,
a great economist and all around good guy Charlie Mullin
"""
from __future__ import division

def llr(data, h):
    """
    @type data: [int/float]
    @param data: the list to compute regression over
    @type h: int
    @param h: bandwidth

    You can use this as you might a moving average or other filter.
    The output value at every point is determined
    by a weighted linear regression over the points
    in the window with width h
    >>> d = [0, 10, 5, 0, 20, 30, 50]
    >>> h = 2
    >>> llr(d, h)
    [0.0, 6.25, 5.0, 6.25, 17.5, 32.5, 50.0]
    """

    estimate = []
    r = len(data)
    for i in xrange(r):
        (sk, syk, sdk, sddk, sdyk) = (0.0,)*5
        s = max(0, i-h)
        for j in xrange(s, r):
            d = i - j
            k = 1 - abs(d)/h
            if k > 0.0:
                sk += k
                syk += data[j]*k
                sdk += d*k
                sddk += d*d*k
                sdyk += d*data[j]*k
        if (sddk*sk-sdk*sdk) == 0.0:
            estimate.append(syk/sk)
        else:
            est = (syk*sddk-sdyk*sdk)/(sddk*sk-sdk*sdk)
            estimate.append(est)
    return estimate

if __name__ == '__main__':
    import doctest
    doctest.testmod()
