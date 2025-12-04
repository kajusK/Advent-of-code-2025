import 'dart:io';

bool isMovable(List<List<String>> rolls, int x, int y)
{
    var neighbors = 0;

    for (var i = -1; i <= 1; i++) {
        for (var j = -1; j <= 1; j++) {
            var nx = (x + i);
            var ny = (y + j);
            if (nx < 0 || nx >= rolls.length || ny < 0 || ny >= rolls[0].length) {
                continue;
            }

            if (rolls[nx][ny] == '@') {
                neighbors++;
            }            
        }
    }
    neighbors--; //remove ourselves
    return neighbors < 4;
}

int remove(List<List<String>> rolls, String replace) {
    var removed = 0;
    for (var x = 0; x < rolls.length; x++) {
        for (var y = 0; y < rolls[0].length; y++) {
            if (rolls[x][y] == '@' && isMovable(rolls, x, y)) {
                rolls[x][y] = replace;
                removed++;
            }
        }
    }
    return removed;
}

int part2(List<List<String>> rolls) {
    var res = 0;
    while (true) {
        var removed = remove(rolls, '.');
        res += removed;
        if (removed == 0) {
            return res;
        } 
    }
}

void main() async {
    final file = File('input.txt');
    final input = await file.readAsLines();
    final rolls = input.map((line) =>
        line.split('').toList()
    ).toList();

    print('Part 1: ${remove(rolls, '@')}');
    print('Part 2: ${part2(rolls)}');
}

