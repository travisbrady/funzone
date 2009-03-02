"""
A little moving average script, useful at the shell but could probably use
some error handling
"""
from __future__ import division

def chunkify(column, width):
    """
    Returns a rolling window with the specified width
    >>> from movavg import chunkify
    >>> list(chunkify(range(9), 3))
    [[0, 1, 2], [1, 2, 3], [2, 3, 4], [3, 4, 5], [4, 5, 6], [5, 6, 7], [6, 7, 8], [7, 8], [8]]
    """
    for i in xrange(len(column)):
        yield column[i:i+width]

def mean_onepass(column):
    """
    Compute the mean of a list in one loop
    exploit the fact that loop target leaks past the loop scope
    >>> from movavg import mean_onepass
    >>> mean_onepass([5, 5, 5])
    5.0
    >>> mean_onepass([6, 0, 6])
    4.0
    """
    total = 0.0
    for i,val in enumerate(column):
        total += val
    return total/(i+1)

def movavg(column, width):
    """
    >>> from movavg import movavg
    >>> list(movavg(range(10), 3))
    [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 8.5, 9.0]
    """
    for chunk in chunkify(column, width):
        yield mean_onepass(chunk)

if __name__ == '__main__':
    import doctest
    doctest.testmod()

