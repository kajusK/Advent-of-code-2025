import 'dart:io';

int findNextMaxPos(List<int> batteries, int start, int remaining) {
    var max = 0;
    var pos = 0;

    for (var i = start; i < batteries.length - remaining + 1; i++) {
        if (batteries[i] > max) {
            max = batteries[i];
            pos = i;
        }
    }
    return pos;
}

int findMax(List<int> batteries, int digits) {
    var num = 0;
    var pos = 0;

    while (digits != 0) {
        pos = findNextMaxPos(batteries, pos, digits);
        num = num * 10 + batteries[pos];      
        pos++;
        digits--;
    }
    return num;
}

int solve(List<List<int>> banks, int digits) {
    var sum = 0;
    for (var bank in banks) {
        sum += findMax(bank, digits);
    }
    return sum;
}

void main() async {
    final file = File('input.txt');
    final input = await file.readAsLines();
    final banks = input.map((line) =>
        line.split('').map((c) => int.parse(c)).toList()
    ).toList();

    print('Part 1: ${solve(banks, 2)}');
    print('Part 2: ${solve(banks, 12)}');
}

