#include <stdio.h>
#include "hll.h"

#define MAXLINELEN 512

int main() {
    hll_t *hll = malloc(sizeof(hll_t));
    int res = hll_init(18, hll);
    char line[MAXLINELEN];
    double after;
    while (fgets(line, MAXLINELEN, stdin))  {
        hll_add(hll, line);
    }

    after = hll_size(hll);
    printf("%.1f\n", after);
    hll_destroy(hll);
    return 0;
}
