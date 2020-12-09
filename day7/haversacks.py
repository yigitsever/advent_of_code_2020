import networkx as nx
import re

bagtree = nx.DiGraph()
bagremover = re.compile(r" bags?\.?$")
numremover = re.compile(r"^\d+ ")

with open("input", "r") as baglines:
    for line in baglines:
        (miniroot, child_str) = list(map(str.strip, line.split("contain")))

        miniroot = miniroot.replace(" bags", "")

        children = list(
            map(
                lambda b: re.sub(numremover, "", b),
                list(
                    map(
                        lambda a: re.sub(bagremover, "", a),
                        list(map(str.strip, child_str.split(","))),
                    )
                ),
            )
        )

        if "no other" in children:
            continue

        for kid in children:
            bagtree.add_edge(kid, miniroot)

lengths = dict(nx.all_pairs_shortest_path(bagtree))

# we don't count the shiny gold itself
print(len(lengths["shiny gold"]) - 1)
