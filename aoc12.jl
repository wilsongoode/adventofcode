### A Pluto.jl notebook ###
# v0.19.16

using Markdown
using InteractiveUtils

# ╔═╡ 293aab72-33cd-43e4-a8e7-345fdba2cf9f
using Graphs

# ╔═╡ e3dcc6b4-7c17-11ed-16c7-f9e319a3bc71
md"# Advent of Code 2022 Day 12: Hill Climbing Algorithm
Link to [Day 12](https://adventofcode.com/2022/day/12)"

# ╔═╡ d861201a-e25f-4872-a8e3-225bf785315f
example_input = """Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi"""

# ╔═╡ 953adee5-1f73-4d05-b46e-2c9d11d19600
input = """abacccaaaacccccccccccaaaaaacccccaaaaaaccccaaacccccccccccccccccccccccccccccccccccccccccccaaaaa
abaaccaaaacccccccccccaaaaaaccccccaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccccccccaaaaa
abaaccaaaacccccccccccaaaaacccccaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccccccccaaaaa
abccccccccccccccccccccaaaaacccaaaaaaaaaaaaaaaacccccccccccccccccccccccccccaaaccccccccccccaaaaa
abccccccccccccccccccccaacaacccaaaaaaaaccaaaaaccccccccccccccccccccccccccccaaaccccccccccccaccaa
abcccccccccccccaacccaaaccccccaaaaaaaaaccaaaaaccccccccccccccccccccccccccccccacccccccccccccccca
abcccccccccccaaaaaaccaaaccacccccaaaaaaacccccccccccccccccccccccccciiiicccccccddddddccccccccccc
abcccccccccccaaaaaaccaaaaaaaccccaaaaaacccccaacccccccaaaccccccccciiiiiiiicccdddddddddacaaccccc
abccccccccccccaaaaaaaaaaaaacccccaaaaaaacaaaacccccccaaaacccccccchhiiiiiiiiicddddddddddaaaccccc
abcccccccccccaaaaaaaaaaaaaacccccccaaacccaaaaaacccccaaaaccccccchhhipppppiiiijjjjjjjddddaaccccc
abcccccccccccaaaaaaaaaaaaaaccccccccccccccaaaaaccccccaaaccccccchhhpppppppiijjjjjjjjjddeeaccccc
abcccccccccccccccccaaaaaaaacccccccccccccaaaaaccccccccccccccccchhppppppppppjjqqqjjjjjeeeaacccc
abccccccccccccccccccaaaaaaaacccccccccccccccaacccccccccccccccchhhpppuuuupppqqqqqqqjjjeeeaacccc
abcccccccccccccccccccaacccacccccccccccccccccccccccccccccccccchhhopuuuuuuppqqqqqqqjjjeeecccccc
abacccccccccccccaaacaaaccccccccccccccccccccccccccccaaccccccchhhhoouuuuuuuqvvvvvqqqjkeeecccccc
abaccccccccccccaaaaaacccccaaccccccccccccccccccccccaaaccccccchhhooouuuxxxuvvvvvvqqqkkeeecccccc
abaccccccccccccaaaaaacccaaaaaaccccccccccccccccccaaaaaaaaccchhhhooouuxxxxuvyyyvvqqqkkeeecccccc
abcccccccccccccaaaaacccaaaaaaaccccccccccccccccccaaaaaaaaccjjhooooouuxxxxyyyyyvvqqqkkeeecccccc
abccccccccccccccaaaaaacaaaaaaaccccccccaaaccccccccaaaaaaccjjjooootuuuxxxxyyyyyvvqqkkkeeecccccc
abccccccccccccccaaaaaaaaaaaaacccccccccaaaacccccccaaaaaacjjjooootttuxxxxxyyyyvvrrrkkkeeecccccc
SbccccccccccccccccccaaaaaaaaacccccccccaaaacccccccaaaaaacjjjoootttxxxEzzzzyyvvvrrrkkkfffcccccc
abcccccccccccaaacccccaaaaaaacaaaccccccaaaccccccccaaccaacjjjoootttxxxxxyyyyyyvvvrrkkkfffcccccc
abcccccccccaaaaaacccaaaaaacccaaacacccaacccccccccccccccccjjjoootttxxxxyxyyyyyywvvrrkkkfffccccc
abcccccccccaaaaaacccaaaaaaaaaaaaaaaccaaacaaacccccaacccccjjjnnnttttxxxxyyyyyyywwwrrkkkfffccccc
abcaacacccccaaaaacccaaacaaaaaaaaaaaccaaaaaaacccccaacaaacjjjnnnntttttxxyywwwwwwwwrrrlkfffccccc
abcaaaaccccaaaaacccccccccaacaaaaaaccccaaaaaacccccaaaaacccjjjnnnnnttttwwywwwwwwwrrrrllfffccccc
abaaaaaccccaaaaaccccccaaaaaccaaaaacaaaaaaaaccccaaaaaaccccjjjjinnnntttwwwwwsssrrrrrllllffccccc
abaaaaaaccccccccccccccaaaaacaaaaaacaaaaaaaaacccaaaaaaacccciiiiinnnntswwwwssssrrrrrlllfffccccc
abacaaaaccccccccccccccaaaaaacaaccccaaaaaaaaaaccccaaaaaaccccciiiinnnssswwsssssllllllllfffccccc
abccaaccccccccccccccccaaaaaaccccccccccaaacaaaccccaaccaacccccciiiinnsssssssmmllllllllfffaacccc
abccccccccccccccccccccaaaaaaccccccccccaaaccccccccaaccccccccccciiinnmsssssmmmmlllllgggffaacccc
abcccccccccccccccaccccccaaacccccccccccaaccccccccccccccccccccccciiimmmsssmmmmmgggggggggaaacccc
abcccccccccaaaaaaaaccccccccccccccccccccccccccccaaaaaccccccccccciiimmmmmmmmmgggggggggaaacccccc
abccccccccccaaaaaaccccccccccccccccccaacccccccccaaaaacccccccccccciiimmmmmmmhhggggcaaaaaaaccccc
abccccccccccaaaaaacccccccccccccccccaacccccccccaaaaaacccccccccccciihhmmmmhhhhgccccccccaacccccc
abccccaacaaaaaaaaaaccccccccccccccccaaaccccccccaaaaaaccccccccccccchhhhhhhhhhhaaccccccccccccccc
abccccaaaaaaaaaaaaaaccccccccccaaccaaaaccccccccaaaaaacccaaacccccccchhhhhhhhaaaaccccccccccccccc
abcccaaaaaaaaaaaaaaaccccccccaaaaaacaaaacacaccccaaaccccaaaacccccccccchhhhccccaaccccccccccaaaca
abcccaaaaaacacaaacccccccccccaaaaaaaaaaaaaaacccccccccccaaaacccccccccccaaaccccccccccccccccaaaaa
abcccccaaaacccaaaccccccccccaaaaaaaaaaaaaaaaccccccccccccaaacccccccccccaaacccccccccccccccccaaaa
abcccccaacccccaacccccccccccaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccaaaaa"""

# ╔═╡ 141dbfaf-954b-4c37-90c4-dc52857eae3a
md"Puzzle input is a heightmap of the surrounding area. Elevation is given by a single lowercase letter from `a:z`, with `a` being low and `z` being high.

Also included on the heightmap are marks for your current position (S) and the location that should get the best signal (E). Your current position (S) has elevation `a`, and the location that should get the best signal (E) has elevation `z`.

You are trying to get to position (E) in the fewest number of steps possible, and can only move one square at a time, in a cardinal direction (up, down, left, right), where the square you are moving to is *at most one higher* than your current square. The destination square can be 1 or more lower."

# ╔═╡ 81f5609e-5dcb-49b4-b0b9-a364f0311628
function parse_input_to_matrix(input)
	rows = collect.(split(input, "\n"))
	output = Matrix{Char}(undef, length(rows), length(rows[1]))
	for (i, row) in enumerate(rows)
		output[i, :] = row
	end
	output
end

# ╔═╡ 07b9c8e5-87a4-4761-84c0-5f2ab078acdc
example_grid = parse_input_to_matrix(example_input)

# ╔═╡ e3f4b3a8-8c44-4285-8415-5ab2aa0911b2
grid = parse_input_to_matrix(input)

# ╔═╡ 530f9747-c744-40cd-ab3b-62faacca487b
function move_is_possible(from::Char, to::Char)
	from = from == 'S' ? 'a' : from
	to = to == 'E' ? 'z' : to
	return from + 1 ≥ to
end

# ╔═╡ 91f5fd85-9316-447f-b180-19e500f1105b
move_is_possible('a', 'b')

# ╔═╡ fd2b3571-74e0-4d65-b074-9679f1406c88
function add_adjacent_moves(grid, index::CartesianIndex)
	row, col = index.I # destructure CartesianIndex
	adj_moves = []
	for r in max(1, row - 1):min(row + 1, size(grid, 1))
		if r == row
			continue
		end
		if move_is_possible(grid[row, col], grid[r, col])
			# println("Possible: $(grid[row, col]) -> $(grid[r, col])")
			push!(adj_moves, CartesianIndex(r, col))
		end 
	end
	for c in max(1, col - 1):min(col + 1, size(grid, 2))
		if c == col
			continue
		end
		if move_is_possible(grid[row, col], grid[row, c])
			# println("Possible: $(grid[row, col]) -> $(grid[row, c])")
			push!(adj_moves, CartesianIndex(row, c))
		end 
	end
	adj_moves
end

# ╔═╡ 67b3bbc0-610f-4683-ac67-8e152b831dac
function find_route(grid)
	start_pos = first(indexin('S', grid))
	end_pos = first(indexin('E', grid))

	graph = SimpleDiGraph(length(grid))

	for i in CartesianIndices(grid)
		adj_moves = add_adjacent_moves(grid, i)
		for m in adj_moves
			add_edge!(graph, LinearIndices(grid)[i], LinearIndices(grid)[m])
		end
	end

	a_star(graph, LinearIndices(grid)[start_pos], LinearIndices(grid)[end_pos])
end

# ╔═╡ 5b071e4e-660f-4940-99d4-1644e42b1802
function find_hiking_routes(grid)
	# start_pos = first(indexin('S', grid)) 
	end_pos = first(indexin('E', grid))

	graph = SimpleDiGraph(length(grid))

	for i in CartesianIndices(grid)
		adj_moves = add_adjacent_moves(grid, i)
		for m in adj_moves
			add_edge!(graph, LinearIndices(grid)[i], LinearIndices(grid)[m])
		end
	end

	all_As = findall(h -> h in ('a','S'), grid)
	possible_routes = []
	for a in all_As
		route = a_star(graph, LinearIndices(grid)[a], LinearIndices(grid)[end_pos])
		if !isempty(route)
			push!(possible_routes, route)
		end
	end
	possible_routes
end

# ╔═╡ ec3968ed-1619-45ee-b50a-0199985572c2
ex_route = find_route(example_grid)

# ╔═╡ e42fb0ad-1f76-42b8-9e87-aeba5fde54eb
for e in ex_route
	println(e)
	from = example_grid[src(e)]
	to = example_grid[dst(e)]
	println("From $from to $to")
end

# ╔═╡ 1e23ae08-1aea-4b96-a6c3-bd01949de664
md"## Part 1
**What is the fewest steps required to move from your current position to the location that should get the best signal?**"

# ╔═╡ 9e53c388-e015-4527-bd88-ca45137f1799
part1 = find_route(grid)

# ╔═╡ 005b3c0e-bec4-4f59-9313-4936c5ed8fbf
length(part1)

# ╔═╡ d380f34f-b17a-480b-a4da-65ee04da3c2b
md"""
## Part 2
Find a better starting point. **What is the fewest steps required to move starting from any square with elevation a to the location that should get the best signal?**
"""

# ╔═╡ e3d8acf1-be58-421e-933e-df97f46d8039
part2 = find_hiking_routes(grid)

# ╔═╡ 3fd9a8f9-cd2c-4731-a8e4-f7aa1a44dcfc
minimum(length, part2)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Graphs = "86223c79-3864-5bf0-83f7-82e725a168b6"

[compat]
Graphs = "~1.7.4"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.3"
manifest_format = "2.0"
project_hash = "28c280795210967a866250a6efcbe46f42575b40"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "62e51b39331de8911e4a7ff6f5aaf38a5f4cc0ae"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.2.0"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "00a2cccc7f098ff3b66806862d275ca3db9e6e5a"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.5.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "ba2d094a88b6b287bd25cfa86f301e7693ffae2f"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.7.4"

[[deps.Inflate]]
git-tree-sha1 = "5cd07aab533df5170988219191dfad0519391428"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "ffc098086f35909741f71ce21d03dadf0d2bfa76"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.11"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6b7ba252635a5eff6a0b0664a41ee140a1c9e72a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"
"""

# ╔═╡ Cell order:
# ╟─e3dcc6b4-7c17-11ed-16c7-f9e319a3bc71
# ╟─d861201a-e25f-4872-a8e3-225bf785315f
# ╟─953adee5-1f73-4d05-b46e-2c9d11d19600
# ╟─141dbfaf-954b-4c37-90c4-dc52857eae3a
# ╠═81f5609e-5dcb-49b4-b0b9-a364f0311628
# ╠═07b9c8e5-87a4-4761-84c0-5f2ab078acdc
# ╠═e3f4b3a8-8c44-4285-8415-5ab2aa0911b2
# ╠═530f9747-c744-40cd-ab3b-62faacca487b
# ╠═91f5fd85-9316-447f-b180-19e500f1105b
# ╠═293aab72-33cd-43e4-a8e7-345fdba2cf9f
# ╠═fd2b3571-74e0-4d65-b074-9679f1406c88
# ╠═67b3bbc0-610f-4683-ac67-8e152b831dac
# ╠═5b071e4e-660f-4940-99d4-1644e42b1802
# ╠═ec3968ed-1619-45ee-b50a-0199985572c2
# ╠═e42fb0ad-1f76-42b8-9e87-aeba5fde54eb
# ╟─1e23ae08-1aea-4b96-a6c3-bd01949de664
# ╠═9e53c388-e015-4527-bd88-ca45137f1799
# ╠═005b3c0e-bec4-4f59-9313-4936c5ed8fbf
# ╟─d380f34f-b17a-480b-a4da-65ee04da3c2b
# ╠═e3d8acf1-be58-421e-933e-df97f46d8039
# ╠═3fd9a8f9-cd2c-4731-a8e4-f7aa1a44dcfc
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
