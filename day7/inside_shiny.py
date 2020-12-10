import networkx as nx
import re


def fits_in(root):
    """recursively count the number of bags that fit in other bags

    :root: the node to count bags from
    :returns: total

    """
    total = 1
    for neighbour in bagtree[root]:
        total += int(bagtree[root][neighbour]["weight"]) * fits_in(neighbour)
    return total


bagtree = nx.DiGraph()
bagremover = re.compile(r" bags?\.?$")
countandbag = re.compile(r"(\d+) (\w+ \w+)")

with open("input", "r") as baglines:
    for line in baglines:
        (miniroot, child_str) = list(map(str.strip, line.split("contain")))

        miniroot = miniroot.replace(" bags", "")

        children = list(
            map(
                lambda a: re.sub(bagremover, "", a),
                list(map(str.strip, child_str.split(","))),
            )
        )

        if "no other" in children:
            continue

        for kid in children:
            matches = re.match(countandbag, kid)
            bagtree.add_edge(miniroot, matches.groups()[1], weight=matches.groups()[0])

lengths = dict(nx.all_pairs_shortest_path(bagtree))

# we don't count the shiny gold itself
print(fits_in("shiny gold") - 1)
