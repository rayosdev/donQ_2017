extends Node2D

var test_arr = []
for i in range(10):
  test_arr.append([])
  test_arr[i].append('a' + str(i))

print(test_arr)
