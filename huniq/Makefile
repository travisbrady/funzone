.PHONY: clean

all: huniq

bitmap.o: bitmap.c
	gcc -c bitmap.c

murmur3.o: murmur3.c
	gcc -c murmur3.c

hll_constants.o: hll_constants.c
	gcc -c hll_constants.c

hll.o: murmur3.o bitmap.o hll_constants.o hll.c
	gcc -c hll.c

huniq: hll.o main.c
	gcc -O3 -I. bitmap.o murmur3.o hll_constants.o hll.o -o huniq main.c

clean:
	rm *.o huniq
