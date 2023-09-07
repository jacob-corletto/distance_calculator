#!/bin/bash


#Author: Floyd Holliday
#Program name: Basic Float Operations

rm *.o
rm *.out

nasm -f elf64 -l fp-io.lis -o fp-io.o compute_trip.asm

g++ -c -m64 -Wall -o fp-io-driver.o main.cpp -fno-pie -no-pie -std=c++20

g++ -m64 -o fpio.out fp-io-driver.o fp-io.o -fno-pie -no-pie -std=c++20

./fpio.out