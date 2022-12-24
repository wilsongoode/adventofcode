### A Pluto.jl notebook ###
# v0.19.18

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ b1675c8a-9c54-4aab-9f8c-39ef6d5e148f
using Graphs

# ╔═╡ 868d73b7-3ef1-4e05-bb95-6cbf0d0bb1c7
using MetaGraphsNext

# ╔═╡ 641b0a44-4b0f-4d09-a3df-2bf0adc409a6
using CairoMakie

# ╔═╡ 913d68c5-bdb6-463a-bfcb-6588782f2667
using GraphMakie

# ╔═╡ 0c1da97a-b507-4da6-9502-f575fa086394
using GraphMakie.NetworkLayout

# ╔═╡ 18568678-7e88-4741-867d-1357db201867
using PlutoUI

# ╔═╡ 66b52eb5-c0dd-4af8-a007-c914f85c6159
using Combinatorics

# ╔═╡ 3ac6f6c8-95bb-446c-b346-5b540f76a693
using DataStructures

# ╔═╡ 46adcc35-b9c1-4ca1-b203-13519b668092
using OffsetArrays

# ╔═╡ 288367b6-7f13-11ed-3907-f7f3e8d727fc
md"# Advent of Code 2022 Day 16: Proboscidea Volcanium
Link to [Day 16](https://adventofcode.com/2022/day/16)"

# ╔═╡ 125b4459-a9d0-428c-8419-e898bfd78fad
example_input = """Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
Valve BB has flow rate=13; tunnels lead to valves CC, AA
Valve CC has flow rate=2; tunnels lead to valves DD, BB
Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
Valve EE has flow rate=3; tunnels lead to valves FF, DD
Valve FF has flow rate=0; tunnels lead to valves EE, GG
Valve GG has flow rate=0; tunnels lead to valves FF, HH
Valve HH has flow rate=22; tunnel leads to valve GG
Valve II has flow rate=0; tunnels lead to valves AA, JJ
Valve JJ has flow rate=21; tunnel leads to valve II"""

# ╔═╡ 31ea47e9-d2b7-4b41-bf1e-147cf337f434
my_input = """Valve OS has flow rate=0; tunnels lead to valves EE, CL
Valve EN has flow rate=0; tunnels lead to valves CL, GV
Valve RR has flow rate=24; tunnels lead to valves FS, YP
Valve VB has flow rate=20; tunnels lead to valves UU, EY, SG, ZB
Valve UU has flow rate=0; tunnels lead to valves OT, VB
Valve WH has flow rate=0; tunnels lead to valves CS, JS
Valve OF has flow rate=25; tunnel leads to valve YM
Valve TY has flow rate=0; tunnels lead to valves AA, GQ
Valve RV has flow rate=0; tunnels lead to valves BT, YX
Valve GK has flow rate=0; tunnels lead to valves GD, AA
Valve EL has flow rate=0; tunnels lead to valves EK, EE
Valve OT has flow rate=9; tunnels lead to valves YR, BJ, OX, UU, HJ
Valve DG has flow rate=11; tunnels lead to valves BN, QE
Valve YR has flow rate=0; tunnels lead to valves OT, YX
Valve GV has flow rate=0; tunnels lead to valves AA, EN
Valve BN has flow rate=0; tunnels lead to valves DG, LU
Valve FS has flow rate=0; tunnels lead to valves TI, RR
Valve DW has flow rate=0; tunnels lead to valves SS, MS
Valve DJ has flow rate=0; tunnels lead to valves KY, GD
Valve BJ has flow rate=0; tunnels lead to valves OT, BT
Valve KY has flow rate=0; tunnels lead to valves EE, DJ
Valve YP has flow rate=0; tunnels lead to valves YM, RR
Valve LU has flow rate=0; tunnels lead to valves BN, CS
Valve OX has flow rate=0; tunnels lead to valves OT, XD
Valve ZB has flow rate=0; tunnels lead to valves VB, PP
Valve CL has flow rate=10; tunnels lead to valves KQ, EN, OS, MQ
Valve XD has flow rate=0; tunnels lead to valves KR, OX
Valve YM has flow rate=0; tunnels lead to valves OF, YP
Valve EY has flow rate=0; tunnels lead to valves MS, VB
Valve KQ has flow rate=0; tunnels lead to valves CS, CL
Valve SS has flow rate=0; tunnels lead to valves AA, DW
Valve SG has flow rate=0; tunnels lead to valves VB, KR
Valve EE has flow rate=22; tunnels lead to valves XR, OS, KY, EL
Valve OI has flow rate=0; tunnels lead to valves RE, MS
Valve QE has flow rate=0; tunnels lead to valves DG, GD
Valve GD has flow rate=3; tunnels lead to valves GK, DJ, MQ, QE, JS
Valve EK has flow rate=23; tunnel leads to valve EL
Valve GQ has flow rate=0; tunnels lead to valves CS, TY
Valve CS has flow rate=7; tunnels lead to valves GQ, WH, KQ, LU
Valve MS has flow rate=4; tunnels lead to valves HJ, EY, DW, OI
Valve XR has flow rate=0; tunnels lead to valves EE, AA
Valve RE has flow rate=6; tunnels lead to valves TI, PP, OI
Valve KR has flow rate=17; tunnels lead to valves XD, SG
Valve BT has flow rate=15; tunnels lead to valves BJ, RV
Valve PP has flow rate=0; tunnels lead to valves RE, ZB
Valve TI has flow rate=0; tunnels lead to valves RE, FS
Valve HJ has flow rate=0; tunnels lead to valves OT, MS
Valve AA has flow rate=0; tunnels lead to valves GK, GV, SS, XR, TY
Valve MQ has flow rate=0; tunnels lead to valves GD, CL
Valve JS has flow rate=0; tunnels lead to valves GD, WH
Valve YX has flow rate=5; tunnels lead to valves YR, RV"""

# ╔═╡ d00bdc85-be4e-4ac2-bde8-4f9f4931463e
md"## Prompt notes

It takes `1` minute to open a valve. It takes `1` minute to traverse a tunnel.

You have `30` minutes to release as much pressure as you can from the volcano before it erupts.

The valve in the room you are starting from is labeled `AA`.

All of the valves begin closed.

If a valve has a flow rate of `0`, there is no point in opening it.

The total eventual pressure release from a valve is equal to the product of the duration it is open and the flow rate. Since `AA` is not worth opening, you could spend one minute moving to valve `BB` and another minute opening it; doing so would release pressure during the remaining `28` minutes at a flow rate of `13`, a total eventual pressure release of `28 * 13 = 364`. Then, you could spend your third minute moving to valve `CC` and your fourth minute opening it, providing an additional `26` minutes of eventual pressure release at a flow rate of `2`, or `52` total pressure released by valve `CC`.

The approach in the example releases themost pressure possible in 30 minutes with this valve layout, `1651`.
"

# ╔═╡ 693a2278-6817-443f-a5e4-59d79bcfe5d4
md"Initial thoughts are that this sounds a lot like a graph-based problem, so I'll start by adding the `Graphs` package to this notebook."

# ╔═╡ f20ac4b5-b2b3-49ee-bd09-755976a03c3f
function parse_input(input)
	lines = String.(split(input, "\n"))
	# println(length(lines))
	rx = r"Valve ([A-Z]{2}) has flow rate=(\d+); tunnels? leads? to valves? (.+)"

	graph = MetaGraph(
		Graph(), 
		Label = Symbol,
		VertexData = Int,
		EdgeData = Int,
		weight_function = identity,
		default_weight = 1
	)

	for line in lines
		(valve, flow_rate, tunnels_to) = match(rx, line).captures
		# Format the values
		valve = Symbol(valve)
		flow_rate = parse(Int, flow_rate)
		tunnels_to = Symbol.(split(tunnels_to, ", "))
		
		# println("valve: $valve, flow: $flow_rate")
		# println("\ttunnels to: $tunnels_to")

		# Add valve to the graph
		graph[valve] = flow_rate
		for other_valve in tunnels_to
			if !haskey(graph, other_valve)
				# If other_valve is not yet in the graph, add it first
				graph[other_valve] = 0
			end
			# Add an edge (tunnel) between two valves with a weight of 1
			graph[valve, other_valve] = 1
		end
	end

	graph
end

# ╔═╡ df46ee30-c693-43ec-95e0-230b84f42a5e
example_graph = parse_input(example_input)

# ╔═╡ 9a904bb6-83c7-4cfa-909c-bfc75365dd76
md"Let's visualize this graph."

# ╔═╡ 9d34ef77-63b4-4181-a01c-93009652c622
md"Defining a couple functions to label the nodes of the graph for us."

# ╔═╡ 11ec5e09-11d7-414e-8ab7-ed4964ff5468
function node_sizes(graph)
	[ 2.5 * graph[label_for(graph, vertex)] for vertex in 1:nv(graph) ]
end

# ╔═╡ f2d48e77-1ebd-49fc-9fde-234b2c82bde9
function label_string(graph, vertex_code)
	valve = label_for(graph, vertex_code)
	flow = graph[valve]

	# "$valve: $flow"
	"$valve"
end

# ╔═╡ 7a798f67-1435-467f-989f-b081a6821060
function labels(graph)
	[ label_string(graph, vertex) for vertex in 1:nv(graph) ]
end

# ╔═╡ 6ea14080-5089-496a-b215-ce0352ccf7aa
md"""
xlims: $(@bind x_lims_example RangeSlider(-10:10))	ylims: $(@bind y_lims_example RangeSlider(-10:10))
"""

# ╔═╡ bab7fb57-3101-4f0a-a15d-a6ae92385953
function my_graphplot(graph, x_lims, y_lims)
	f, ax, p = graphplot(
		graph,
		# layout = SFDP(;
		# 	C=0.2,
		# 	K=1.0
		# ),
		# layout = Stress(;),
		# layout = Shell(;),
		layout = Spring(; 
			dim = 2,
			C=2.0, 
			iterations = 400
		),
		node_size = node_sizes(graph),
		nlabels = labels(graph),
		nlabels_align = [ (:left, :bottom) for i in 1:nv(graph)],
		# nlabels_distance = 15,
		nlabels_attr = (; font = :bold),
		nlabels_color = "sienna1",

		# backgroundcolor = "blue",
		edge_color = "whitesmoke",
		node_color = "firebrick"
	)
	# xlims!(ax, (x_lims.start, x_lims.stop))
	# ylims!(ax, (y_lims.start, y_lims.stop))
	xlims!(ax, x_lims)
	ylims!(ax, y_lims)
	hidedecorations!(ax)
	hidespines!(ax)
	ax.aspect = DataAspect()
	f.scene.backgroundcolor = to_color("gray6")
	ax.backgroundcolor = "gray6"
	# println(ax.limits)
	f
end

# ╔═╡ 6f687afb-f5b1-4c70-a497-750d06e52262
my_graphplot(example_graph, 
	(x_lims_example.start, x_lims_example.stop), 
	(y_lims_example.start, y_lims_example.stop)
)

# ╔═╡ c5a0a410-b603-47b8-b67d-1da91a0e2684
md"## Part 1
Work out the steps to release the most pressure in 30 minutes. **What is the most pressure you can release?**"

# ╔═╡ ece7db54-b0dd-44dd-9a71-55f94470cecf
valve_graph = parse_input(my_input)

# ╔═╡ cc925702-5622-41b4-b15b-bc1f4b195985
valve_graph.graph

# ╔═╡ 3ee2e185-4781-44fc-83b5-26c91acb3881
my_graphplot(valve_graph, (-15, 15), (-12, 12))

# ╔═╡ 600a9bc6-be0c-4ec9-a39a-1af32f010698
md"""
### Brainstorm

- Some kind of graph search algorithm, like DFS or BFS
- Although, we know the flow rates ahead of time, so maybe there is some kind of optimization process to care about
  - Maximizing total pressure release within time
- Do you calculate every possible order of valves to visit?
  - Do you need to? We know that some of them can have a flow rate of `0` which means we can ignore those and instead focus on the distance/time aspect.
  - Could try to visit all non-zero flow rate valves and open them.
  - Could try to visit valves with highest flow rate first to maximize early pressure release. Wouldn't the best case scenario be to have the highest flow rate going as soon as possible?

I asked ChatGPT, "How do you optimize a graph traversal using a score?"

ChatGPT:
>There are several ways to optimize a graph traversal using a score. Here are a few approaches you might consider:
>1. Use a heuristic function to guide the traversal: A heuristic function is a function that estimates the cost of reaching the goal from a given position. By using a heuristic function, you can guide the traversal towards the most promising paths, rather than exploring all paths blindly.
>2. Use a priority queue to prioritize the exploration of certain paths: By using a priority queue, you can prioritize the exploration of paths with higher scores, rather than exploring all paths in a fixed order. This can help you find the optimal path more quickly.
>3. Use memoization to avoid exploring the same paths multiple times: If you are traversing a large graph, it may be helpful to use memoization to store the scores of previously explored paths. This way, you can avoid exploring the same paths multiple times and save time.
>4. Use parallelization to explore multiple paths simultaneously: If you have access to multiple processors or cores, you can parallelize the traversal of the graph by exploring multiple paths simultaneously. This can help you find the optimal path more quickly.
>It's worth noting that the most appropriate optimization approach will depend on the specific characteristics of your graph and the requirements of your application.

To me, #1 just sounds like the scoring function. I like the idea of a priority queue, it's good to know the term for it. I'm yet sure how I would incorporate memoization. Parallelization would be interesting, but I'd bet it is overkill for this problem and would lead to more complexity and headache than it is worth.

"How do you know if a problem is a good candidate for parallelization?"
>There are a few factors to consider when determining whether a problem is a good candidate for parallelization:
>1. Size of the problem: Parallelization is generally more effective for larger problems, as the overhead of parallelization is more easily compensated for by the increased speed of computation.
>2. Parallelizable operations: In order to be parallelized, a problem must have operations that can be computed independently of each other. If the operations are highly dependent on one another, it may be difficult to parallelize the problem.
>3. Amdahl's law: Amdahl's law states that the maximum speedup that can be achieved through parallelization is limited by the fraction of the computation that can be parallelized. This means that if only a small portion of the computation can be parallelized, the overall speedup may be limited.
>4. Available resources: Parallelization requires additional resources, such as multiple processors or cores, in order to be effective. If these resources are not available, parallelization may not be a feasible option.
>Ultimately, the decision to parallelize a problem will depend on the specific characteristics of the problem and the resources available to you. It may be helpful to perform some benchmarks to determine the potential speedup of parallelization for a given problem.
"""

# ╔═╡ ce631ffa-f2cc-4598-8b63-e77e69a79425
non_zero_valves = filter(v -> v.second[2] > 0, example_graph.vertex_properties)

# ╔═╡ f193ef75-f5ca-450d-a2ac-791096f5a038
non_zero_valves_idx = [ v.second[1] for v in non_zero_valves ]

# ╔═╡ ea3cf262-23c3-45c6-9c7b-4c7b342b4bd2
[ (valve_id, dijkstra_shortest_paths(example_graph, valve_id)) for valve_id in non_zero_valves_idx ]

# ╔═╡ 72c5e84d-1c02-487d-b546-5aa4698e3f2f
md"Floyd-Warshall algorithm gives all pair-wise distances, so I don't need to run Dijkstra over and over"

# ╔═╡ 8a30696f-3e8d-4141-ab15-321e305bdb7a
shortest_paths = floyd_warshall_shortest_paths(example_graph).dists

# ╔═╡ 1c6a1233-56c6-4ca9-ad97-f9ef7596888f
shortest_paths_real_input = floyd_warshall_shortest_paths(valve_graph).dists

# ╔═╡ 89ecce3c-22c1-4373-b266-7679a8d4c3ac
axes(shortest_paths)

# ╔═╡ ab1a162b-d161-4e23-b4a1-e34065f0a28b
vertices(example_graph)

# ╔═╡ db3861c5-4107-4a7b-ad38-4c701ff7116e
code_for(example_graph, :AA)

# ╔═╡ bd1e2f24-a864-4cda-aa1f-25b6a2611605
md"""
Pseudocode to find the pressure-release-maximizing path:
1. Start at AA
2. Move to and (greedily?) open the biggest valve nearby
3. Find the next best valve from current location
4. Repeat until all non-zero flow valves are open or time is exhausted.
5. Return the path taken
"""

# ╔═╡ abbbce86-3e15-429b-ae0b-f979e686a850
function non_zero_flow_valves(graph)
	non_zero_valves = filter(v -> v.second[2] > 0, graph.vertex_properties)
	non_zero_valves_idx = [ v.second[1] for v in non_zero_valves ]
end

# ╔═╡ 8c5a801a-08a4-4265-8e13-949be7e653aa
# function pressure_release_potential(valve_flow_rate, release_duration)
# 	valve_flow_rate * release_duration
# end

# ╔═╡ 2518c3fe-e02a-4b3e-b648-08ebc902a321
# function release_potential_matrix(graph, time_limit)
# 	# create a matrix with rows for nodes and columns for time steps
# 	u
# end

# ╔═╡ 87cfd6a4-3b73-4638-99c4-025d1bbd4558
# function released_pressure(graph, open_valves)
# 	sum([ graph[label_for(graph, valve)] for valve in open_valves ])
# end

# ╔═╡ 3f2a1dc0-5302-4ca7-8fbe-23b602033af2
# released_pressure(example_graph, [1, 2])

# ╔═╡ 7194d8ec-92be-4bb4-bc23-99aa4c5d4fa3
possible_permutations = collect(permutations(non_zero_valves_idx, length(non_zero_valves_idx)))

# ╔═╡ a75a3053-56a8-4952-9ff7-0f9fa481b670
non_zero_valves_in_real_input = non_zero_flow_valves(valve_graph)

# ╔═╡ e0c35d5a-7895-4025-a9e9-10969181f24b
# permutations(non_zero_valves_in_real_input, length(non_zero_valves_in_real_input))

# ╔═╡ 2fd7185a-e477-4cd8-bb10-16a8d3e7fa96
# length(non_zero_flow_valves(valve_graph)) |> factorial

# ╔═╡ 7c945144-0e28-4496-923b-60e2ef2271ec
md"WOW, that is way too many. I need to do something like Depth-First Search instead of generating that many permutations."

# ╔═╡ 64f5a862-acb5-4cd4-9337-f85f44820881
function total_pressure_released(graph, shortest_paths, time_limit, path; debug=false)
	prev_node = code_for(graph, :AA)
	released_pressure = 0
	time_elapsed = 0

	if !(path[1] in neighbors(graph, prev_node))
		# println("")
		return released_pressure, path
	end
	
	for next_node in path
		distance = shortest_paths[prev_node, next_node]
		time_elapsed += distance + 1 # traversal time plus time to open the valve
		duration = time_limit - time_elapsed

		if duration < 1 # there is no more time to release pressure
			break
		end
		
		flow_rate = graph[label_for(graph, next_node)]
		released_pressure += flow_rate * duration

		if debug
			println("($prev_node) -> ($next_node)")
			println("distance: $distance")
			println("time_elapsed: $time_elapsed")
			println("duration: $duration")
			println("flow_rate: $flow_rate")
			println("released_pressure: $released_pressure")
		end
		
		prev_node = next_node
	end
	released_pressure, path
end

# ╔═╡ 70bf7ccb-2f7d-4f0a-b7d2-19ce9226cc4b
function best_path(graph, time_limit)
	non_zero_valves = non_zero_flow_valves(graph)
	shortest_paths = floyd_warshall_shortest_paths(graph).dists
	# open_valves = Array{Int}(undef, length(non_zero_valves))
	# total_pressure_released = 0
	# possible_paths = collect(permutations(non_zero_valves, length(non_zero_valves)))
	possible_paths = permutations(non_zero_valves, length(non_zero_valves))

	# println(non_zero_valves)
	# println(length(possible_paths))

	best_score = maximum([
		total_pressure_released(graph, shortest_paths, time_limit, path)
		for path in possible_paths
	])
	# loop/recurse
	# break if all non_zero_valves are in open_valves
	# break if time_limit is reached
	# t = 0
	# while t ≤ time_limit
	# 	if all(in.(non_zero_valves, Ref(open_valves)))
	# 		break
	# 	end

	# 	# update t with the time expended
	#   # update total_pressure_released 
		
	# end

	# return total_pressure_released
	
	return best_score
end

# ╔═╡ 835ce418-425f-4fcd-8252-4ba0e00a2eea
total_pressure_released(
	example_graph, 
	shortest_paths, 
	30, 
	possible_permutations[1],
	# debug=true
)

# ╔═╡ 9e1635f8-a30e-489e-9a0c-d6262e525f7b
best_path(example_graph, 30)

# ╔═╡ 17f65edd-90b9-4c5e-a54c-c73e3dd9dfba
md"### Part 1 Answer"

# ╔═╡ 254dfc28-653b-4ed5-a16e-87037e245456
partitions(example_graph |> vertices, 2) |> length

# ╔═╡ 8977d085-8191-4756-88cf-4afc25a10af4
partitions(valve_graph |> vertices, 2) |> length

# ╔═╡ ae0b2f9e-7a33-4e14-8432-3731e2b5f2d1
example_graph.vertex_labels |> values

# ╔═╡ eac54768-0797-4e60-bc7b-37351a91198e
example_graph |> vertices

# ╔═╡ 593f8675-6567-4a29-9cb2-de25153147a7
function score(graph, chosen_valves)
	total = 0
	for (valve, time_remaining) in chosen_valves
		# total += graph[label_for(graph, valve)] * time_remaining
		total += (graph[valve] * time_remaining)
	end
	return total
end

# ╔═╡ 8b450306-d53d-4a9a-a03d-24cd48ae090a
function solutions(distance, graph, valves, time=30, current=:AA, chosen=Pair{Symbol, Int}[])
	result = Vector{Pair{Symbol, Int}}[chosen]
	# println()
	# println("result: ", result)
	# println("valves: ", valves)
	for next_valve in valves
		# println("next_valve: ", next_valve)
		new_time = time - (distance[code_for(graph, current), code_for(graph, next_valve)] + 1)
		# println("new_time: ", new_time)
		if new_time < 2
			continue
		end

		new_chosen = union(chosen, Dict(next_valve => new_time))
		# println("new_chosen: ", new_chosen)
		new_valves = filter(v -> !isequal(v, next_valve), valves)

		push!(result, 
			solutions(distance, graph, new_valves, new_time, next_valve, new_chosen)...)
	end

	return result
end

# ╔═╡ 903ab884-2349-4566-8b9a-c605d0cad73e
function part1(graph)
	# non_zero_valves = non_zero_flow_valves(graph)
	# println(non_zero_valves)
	non_zero_valves = [ 
		label_for(graph, valve) 
		for valve in non_zero_flow_valves(graph)
	]
	println(length(non_zero_valves), " non-zero valves: ", non_zero_valves)
	shortest_paths = floyd_warshall_shortest_paths(graph).dists

	map(sol -> (score(graph, sol), sol),
		solutions(shortest_paths, graph, non_zero_valves)
	)
	# best_score = #maximum(
	# 	[
	# 	score(graph, solution)
	# 	for solution in solutions(shortest_paths, graph, non_zero_valves)
	# ]
	# #)

	# return best_score
end

# ╔═╡ c59a2c51-0aac-4bb9-87cd-59d978ea477e
part1_ex_solutions = part1(example_graph)

# ╔═╡ 6eb1c5ed-b6d6-46f3-ac82-8416e3757484
maximum(part1_ex_solutions)

# ╔═╡ 90fbfa0b-a0dd-4392-9cab-8740e7ab0b56
part1_real_solutions = part1(valve_graph)

# ╔═╡ 542eaf15-c83d-47c6-bf09-e315fbb03da4
maximum(part1_real_solutions)

# ╔═╡ d5a6ff12-dac6-43fa-9057-84d404ce5255
md"This should be `1741` according to other people's code.

I don't understand why my solution isn't working for the real input. I've been working on this for several days. I'm giving up."

# ╔═╡ babcb319-d48b-4f07-b887-01584e38daa4
md"# Gabriel Wu's code:
[Link](https://julialang.zulipchat.com/#narrow/stream/357313-advent-of-code-.282022.29/topic/day.2016/near/316200770)"

# ╔═╡ b08112df-44a4-4390-b55a-f5e22af8e5b6
begin
regex = r"Valve ([A-Z]{2}) has flow rate=(\d+); tunnels? leads? to valves? (.+)"

function preprocess(input)
	input = String.(split(input, "\n")) # Adding this to make it work
    input = sort(input)
    mapping = Dict{String, Int}()
    n = length(input)
    valves = zeros(Int, n)
    adj = fill(100000000, n, n)
    foreach(enumerate(input)) do (i, line)
        u, _, _ = match(regex, line).captures
        mapping[u] = i
        adj[i, i] = 0
    end

    foreach(input) do line
        u, rate, vs = match(regex, line).captures
        u = mapping[u]
        valves[u] = parse(Int, rate)
        for v in split(vs, ", ")
            v = mapping[v]
            adj[u, v] = 1
        end
    end

    for k in 1:n
        for i in 1:n
            for j in 1:n
                adj[i, j] = min(adj[i, j], adj[i, k] + adj[k, j])
            end
        end
    end

    valid = [i for i in 1:n if valves[i] > 0 || mapping["AA"] == i]
    m = length(valid)
    adj2 = [adj[valid[i], valid[j]] for i in 1:m, j in 1:m]
    valves2 = [valves[i] for i in valid]
    return valves2, adj2
end
end

# ╔═╡ 774918ba-8546-4074-94e1-ec65416724e7
function solver_pq(valves, adj, T)
    m = size(adj)[1]
    msk = (1 << (m - 1)) - 1
    best = OffsetArray(zeros(Int, 0:msk), 0:msk)
    pq = PriorityQueue()
    enqueue!(pq, (1, 0, 0), 0)
    while !isempty(pq)
        (u, t, state), now = peek(pq)
        now = -now
        dequeue!(pq)

        for v in 2:m
            i = v - 2
            if (state & (1 << i)) > 0
                continue
            end

            if t + adj[u, v] + 1 < T
                t1 = t + adj[u, v] + 1
                nxt = now + (T - t1) * valves[v]
                nxt_state = state | (1 << i)
                best[nxt_state] = max(best[nxt_state], nxt)
                nxt_key = (v, t1, nxt_state)
                if -get(pq, nxt_key, 1) < nxt
                    if haskey(pq, nxt_key)
                        delete!(pq, nxt_key)
                    end
                    enqueue!(pq, nxt_key, -nxt)
                end
            end
        end
    end
    return best
end

# ╔═╡ 9789b7aa-f4fc-4040-8df5-4cc1404a6fe8
function part_one(input, solver)
    valves, adj = preprocess(input)
	# println(valves)
	# println(adj)
    best = solver(valves, adj, 30)
    return maximum(best) #, best
end

# ╔═╡ 025b5912-8009-4f5a-b030-0fe9a27dca40
part_one(example_input, solver_pq)

# ╔═╡ 030a170c-054a-4be0-b10a-7e77e7eb99a3
part_one(my_input, solver_pq)

# ╔═╡ bf67213c-cc20-43f8-abfd-10b43b405d66
function solver_dp(valves, adj, T)
    m = length(valves)
    msk = (1 << (m - 1)) - 1
    dp = OffsetArray(fill(-1, 0:msk, m, T + 1), 0:msk, 1:m, 0:T)
    dp[0, 1, 0] = 0
    for t in 0:T - 1
        for u in 1:m
            for state in 0:msk
                now = dp[state, u, t]
                if now == -1
                    continue
                end

                for v in 2:m
                    i = v - 2
                    if (state & (1 << i)) > 0
                        continue
                    end

                    nxt = state | (1 << i)
                    t1 = t + adj[u, v] + 1
                    if t1 < T
                        dp[nxt, v, t1] = max(dp[nxt, v, t1], now + (T - t1) * valves[v])
                    end
                end
            end
        end
    end

    best = OffsetArray([maximum(dp[state, :, :]) for state in 0:msk], 0:msk)
    return best
end

# ╔═╡ 602b8918-3280-4d52-8873-934eb6028d87
part_one(my_input, solver_dp)

# ╔═╡ c5648e33-1451-4a6f-baa5-3e4d566f9547
function part_two(input, solver)
    valves, adj = preprocess(input)
    best = solver(valves, adj, 26)
    m = length(valves)
    msk = (1 << (m - 1)) - 1
    for i in 0:msk
        j = (i - 1) & i
        while j > 0
            best[i] = max(best[i], best[j])
            j = (j - 1) & i
        end
    end
    return maximum(best[i] + best[msk⊻i] for i in 0:msk)
end

# ╔═╡ bbaaefeb-a4fc-4698-a1c7-95b615a18f4d
part_two(my_input, solver_dp)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CairoMakie = "13f3f980-e62b-5c42-98c6-ff1f3baf88f0"
Combinatorics = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
DataStructures = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
GraphMakie = "1ecd5474-83a3-4783-bb4f-06765db800d2"
Graphs = "86223c79-3864-5bf0-83f7-82e725a168b6"
MetaGraphsNext = "fa8bd995-216d-47f1-8a91-f3b68fbeb377"
OffsetArrays = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
CairoMakie = "~0.10.0"
Combinatorics = "~1.0.2"
DataStructures = "~0.18.13"
GraphMakie = "~0.5.0"
Graphs = "~1.7.4"
MetaGraphsNext = "~0.4.0"
OffsetArrays = "~1.12.8"
PlutoUI = "~0.7.49"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.3"
manifest_format = "2.0"
project_hash = "1d853f8f03ecad9f2ac495aeb52bf6b42090182d"

[[deps.AbstractFFTs]]
deps = ["ChainRulesCore", "LinearAlgebra"]
git-tree-sha1 = "69f7020bd72f069c219b5e8c236c1fa90d2cb409"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.2.1"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.AbstractTrees]]
git-tree-sha1 = "52b3b436f8f73133d7bc3a6c71ee7ed6ab2ab754"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.3"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "195c5505521008abea5aee4f96930717958eac6f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.4.0"

[[deps.Animations]]
deps = ["Colors"]
git-tree-sha1 = "e81c509d2c8e49592413bfb0bb3b08150056c79d"
uuid = "27a7e980-b3e6-11e9-2bcd-0b925532e340"
version = "0.4.1"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.ArnoldiMethod]]
deps = ["LinearAlgebra", "Random", "StaticArrays"]
git-tree-sha1 = "62e51b39331de8911e4a7ff6f5aaf38a5f4cc0ae"
uuid = "ec485272-7323-5ecc-a04f-4719b315124d"
version = "0.2.0"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Automa]]
deps = ["Printf", "ScanByte", "TranscodingStreams"]
git-tree-sha1 = "d50976f217489ce799e366d9561d56a98a30d7fe"
uuid = "67c07d97-cdcb-5c2c-af73-a7f9c32a568b"
version = "0.8.2"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "66771c8d21c8ff5e3a93379480a2307ac36863f7"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.1"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "1dd4d9f5beebac0c03446918741b1a03dc5e5788"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.6"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.CEnum]]
git-tree-sha1 = "eb4cb44a499229b3b8426dcfb5dd85333951ff90"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.2"

[[deps.Cairo]]
deps = ["Cairo_jll", "Colors", "Glib_jll", "Graphics", "Libdl", "Pango_jll"]
git-tree-sha1 = "d0b3f8b4ad16cb0a2988c6788646a5e6a17b6b1b"
uuid = "159f3aea-2a34-519c-b102-8c37f9878175"
version = "1.0.5"

[[deps.CairoMakie]]
deps = ["Base64", "Cairo", "Colors", "FFTW", "FileIO", "FreeType", "GeometryBasics", "LinearAlgebra", "Makie", "SHA", "SnoopPrecompile"]
git-tree-sha1 = "a1889ac0cfd046d62404ac3e0a1cb718575ee017"
uuid = "13f3f980-e62b-5c42-98c6-ff1f3baf88f0"
version = "0.10.0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "e7ff6cadf743c098e08fca25c91103ee4303c9bb"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.6"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "38f7a08f19d8810338d4f5085211c7dfa5d5bdd8"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.4"

[[deps.ColorBrewer]]
deps = ["Colors", "JSON", "Test"]
git-tree-sha1 = "61c5334f33d91e570e1d0c3eb5465835242582c4"
uuid = "a2cac450-b92f-5266-8821-25eda20663c8"
version = "0.4.0"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Random", "SnoopPrecompile"]
git-tree-sha1 = "aa3edc8f8dea6cbfa176ee12f7c2fc82f0608ed3"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.20.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "d08c20eef1f2cbc6e60fd3612ac4340b89fea322"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.9"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "00a2cccc7f098ff3b66806862d275ca3db9e6e5a"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.5.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "fb21ddd70a051d882a1686a5a550990bbe371a95"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.4.1"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "e8119c1a33d267e16108be441a287a6981ba1630"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.14.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DensityInterface]]
deps = ["InverseFunctions", "Test"]
git-tree-sha1 = "80c3e8639e3353e5d2912fb3a1916b8455e2494b"
uuid = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
version = "0.4.0"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["ChainRulesCore", "DensityInterface", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "a7756d098cbabec6b3ac44f369f74915e8cfd70a"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.79"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e3290f2d49e661fbd94046d7e3726ffcb2d41053"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.4+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.Extents]]
git-tree-sha1 = "5e1e4c53fa39afe63a7d356e30452249365fba99"
uuid = "411431e0-e8b7-467b-b5e0-f676ba4f2910"
version = "0.1.1"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "90630efff0894f8142308e334473eba54c433549"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.5.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "7be5f99f7d15578798f338f5433b6c432ea8037b"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "9a0472ec2f5409db243160a8b030f94c380167a3"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType]]
deps = ["CEnum", "FreeType2_jll"]
git-tree-sha1 = "cabd77ab6a6fdff49bfd24af2ebe76e6e018a2b4"
uuid = "b38be410-82b0-50bf-ab77-7b57e271db43"
version = "4.0.0"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FreeTypeAbstraction]]
deps = ["ColorVectorSpace", "Colors", "FreeType", "GeometryBasics"]
git-tree-sha1 = "38a92e40157100e796690421e34a11c107205c86"
uuid = "663a7486-cb36-511b-a19d-713bb74d65c9"
version = "0.10.0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GPUArraysCore]]
deps = ["Adapt"]
git-tree-sha1 = "6872f5ec8fd1a38880f027a26739d42dcda6691f"
uuid = "46192b85-c4d5-4398-a991-12ede77f4527"
version = "0.1.2"

[[deps.GeoInterface]]
deps = ["Extents"]
git-tree-sha1 = "fb28b5dc239d0174d7297310ef7b84a11804dfab"
uuid = "cf35fbd7-0cd7-5166-be24-54bfbe79505f"
version = "1.0.1"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "GeoInterface", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "fe9aea4ed3ec6afdfbeb5a4f39a2208909b162a6"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.5"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "d3b3624125c1474292d0d8ed0f65554ac37ddb23"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+2"

[[deps.GraphMakie]]
deps = ["GeometryBasics", "Graphs", "LinearAlgebra", "Makie", "NetworkLayout", "StaticArrays"]
git-tree-sha1 = "da596204780670d848c5bf35aff1f8580b885e09"
uuid = "1ecd5474-83a3-4783-bb4f-06765db800d2"
version = "0.5.0"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Graphs]]
deps = ["ArnoldiMethod", "Compat", "DataStructures", "Distributed", "Inflate", "LinearAlgebra", "Random", "SharedArrays", "SimpleTraits", "SparseArrays", "Statistics"]
git-tree-sha1 = "ba2d094a88b6b287bd25cfa86f301e7693ffae2f"
uuid = "86223c79-3864-5bf0-83f7-82e725a168b6"
version = "1.7.4"

[[deps.GridLayoutBase]]
deps = ["GeometryBasics", "InteractiveUtils", "Observables"]
git-tree-sha1 = "678d136003ed5bceaab05cf64519e3f956ffa4ba"
uuid = "3955a311-db13-416c-9275-1d80ed98e5e9"
version = "0.9.1"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions", "Test"]
git-tree-sha1 = "709d864e3ed6e3545230601f94e11ebc65994641"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.11"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "c54b581a83008dc7f292e205f4c409ab5caa0f04"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.10"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "b51bb8cae22c66d0f6357e3bcb6363145ef20835"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.5"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "acf614720ef026d38400b3817614c45882d75500"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.4"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "342f789fd041a55166764c351da1710db97ce0e0"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.6"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "36cbaebed194b292590cba2593da27b34763804a"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.8"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "87f7662e03a649cffa2e05bf19c303e168732d3e"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.2+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "5cd07aab533df5170988219191dfad0519391428"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.3"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d979e54b71da82f3a65b62553da4fc3d18c9004c"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2018.0.3+2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "721ec2cf720536ad005cb38f50dbba7b02419a15"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.14.7"

[[deps.IntervalSets]]
deps = ["Dates", "Random", "Statistics"]
git-tree-sha1 = "16c0cc91853084cb5f58a78bd209513900206ce6"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.4"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "49510dfcb407e572524ba94aeae2fced1f3feb0f"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.8"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.Isoband]]
deps = ["isoband_jll"]
git-tree-sha1 = "f9b6d97355599074dc867318950adaa6f9946137"
uuid = "f1662d9f-8043-43de-a69a-05efc1cc6ff4"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLD2]]
deps = ["FileIO", "MacroTools", "Mmap", "OrderedCollections", "Pkg", "Printf", "Reexport", "TranscodingStreams", "UUIDs"]
git-tree-sha1 = "ec8a9c9f0ecb1c687e34c1fda2699de4d054672a"
uuid = "033835bb-8acc-5ee8-8aae-3f567f8a3819"
version = "0.4.29"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "a77b273f1ddec645d1b7c4fd5fb98c8f90ad10a5"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.1"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b53380851c6e6664204efb2e62cd24fa5c47e4ba"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.2+0"

[[deps.KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "9816b296736292a80b9a3200eb7fbb57aaa3917a"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.5"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "946607f84feb96220f480e0422d3484c49c00239"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.19"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "2ce8695e1e699b68702c03402672a69f54b8aca9"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2022.2.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Makie]]
deps = ["Animations", "Base64", "ColorBrewer", "ColorSchemes", "ColorTypes", "Colors", "Contour", "Distributions", "DocStringExtensions", "FFMPEG", "FileIO", "FixedPointNumbers", "Formatting", "FreeType", "FreeTypeAbstraction", "GeometryBasics", "GridLayoutBase", "ImageIO", "InteractiveUtils", "IntervalSets", "Isoband", "KernelDensity", "LaTeXStrings", "LinearAlgebra", "MakieCore", "Markdown", "Match", "MathTeXEngine", "MiniQhull", "Observables", "OffsetArrays", "Packing", "PlotUtils", "PolygonOps", "Printf", "Random", "RelocatableFolders", "Serialization", "Setfield", "Showoff", "SignedDistanceFields", "SnoopPrecompile", "SparseArrays", "Statistics", "StatsBase", "StatsFuns", "StructArrays", "TriplotBase", "UnicodeFun"]
git-tree-sha1 = "7154536d78dcde1c4321b50e0e8dda90995f1f6f"
uuid = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
version = "0.19.0"

[[deps.MakieCore]]
deps = ["Observables"]
git-tree-sha1 = "5357b0696f7c245941389995e193c127190d45f8"
uuid = "20f20a25-4f0e-4fdf-b5d1-57303727442b"
version = "0.6.0"

[[deps.MappedArrays]]
git-tree-sha1 = "e8b359ef06ec72e8c030463fe02efe5527ee5142"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.1"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.Match]]
git-tree-sha1 = "1d9bc5c1a6e7ee24effb93f175c9342f9154d97f"
uuid = "7eb4fadd-790c-5f42-8a69-bfa0b872bfbf"
version = "1.2.0"

[[deps.MathTeXEngine]]
deps = ["AbstractTrees", "Automa", "DataStructures", "FreeTypeAbstraction", "GeometryBasics", "LaTeXStrings", "REPL", "RelocatableFolders", "Test", "UnicodeFun"]
git-tree-sha1 = "f04120d9adf4f49be242db0b905bea0be32198d1"
uuid = "0a4f8689-d25c-4efe-a92b-7142dfc1aa53"
version = "0.5.4"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.MetaGraphsNext]]
deps = ["Graphs", "JLD2"]
git-tree-sha1 = "46f9e8e3e27ee71026751fa015ab9c441ba7d51d"
uuid = "fa8bd995-216d-47f1-8a91-f3b68fbeb377"
version = "0.4.0"

[[deps.MiniQhull]]
deps = ["QhullMiniWrapper_jll"]
git-tree-sha1 = "9dc837d180ee49eeb7c8b77bb1c860452634b0d1"
uuid = "978d7f02-9e05-4691-894f-ae31a51d76ca"
version = "0.4.0"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "a7c3d1da1189a1c2fe843a3bfa04d18d20eb3211"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.1"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "5ae7ca23e13855b3aba94550f26146c01d259267"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.0"

[[deps.NetworkLayout]]
deps = ["GeometryBasics", "LinearAlgebra", "Random", "Requires", "SparseArrays"]
git-tree-sha1 = "cac8fc7ba64b699c678094fa630f49b80618f625"
uuid = "46757867-2c16-5918-afeb-47bfcb05e46a"
version = "0.4.4"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Observables]]
git-tree-sha1 = "6862738f9796b3edc1c09d0890afce4eca9e7e93"
uuid = "510215fc-4207-5dde-b226-833fc4488ee2"
version = "0.5.4"

[[deps.OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "f71d8950b724e9ff6110fc948dff5a329f901d64"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.12.8"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "923319661e9a22712f24596ce81c54fc0366f304"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.1.1+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6e9dba33f9f2c44e08a020b0caf6903be540004"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.19+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.40.0+0"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "cf494dca75a69712a72b80bc48f59dcf3dea63ec"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.16"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "f809158b27eba0c18c269cf2a2be6ed751d3e81d"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.3.17"

[[deps.Packing]]
deps = ["GeometryBasics"]
git-tree-sha1 = "1155f6f937fa2b94104162f01fa400e192e4272f"
uuid = "19eb6ba3-879d-56ad-ad62-d5c202156566"
version = "0.4.2"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "03a7a85b76381a3d04c7a1656039197e70eda03d"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.11"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "84a314e3926ba9ec66ac097e3635e270986b0f10"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.50.9+0"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "6466e524967496866901a78fca3f2e9ea445a559"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.2"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f6cf8e7944e50901594838951729a1861e668cb8"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.2"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "SnoopPrecompile", "Statistics"]
git-tree-sha1 = "5b7690dd212e026bbab1860016a6601cb077ab66"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.2"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eadad7b14cf046de6eb41f13c9275e5aa2711ab6"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.49"

[[deps.PolygonOps]]
git-tree-sha1 = "77b3d3605fc1cd0b42d95eba87dfcd2bf67d5ff6"
uuid = "647866c9-e3ac-4575-94e7-e3d426903924"
version = "0.1.2"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "d7a7aef8f8f2d537104f170139553b14dfe39fe9"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.7.2"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.QhullMiniWrapper_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Qhull_jll"]
git-tree-sha1 = "607cf73c03f8a9f83b36db0b86a3a9c14179621f"
uuid = "460c41e3-6112-5d7f-b78c-b6823adb3f2d"
version = "1.0.0+1"

[[deps.Qhull_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "238dd7e2cc577281976b9681702174850f8d4cbc"
uuid = "784f63db-0788-585a-bace-daefebcd302b"
version = "8.0.1001+0"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "97aa253e65b784fd13e83774cadc95b38011d734"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.6.0"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "dc84268fe0e3335a62e315a3a7cf2afa7178a734"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.3"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "90bc7a7c96410424509e4263e277e43250c05691"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "bf3188feca147ce108c76ad82c2792c57abe7b1f"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "68db32dff12bb6127bac73c209881191bf0efbb7"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.3.0+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
git-tree-sha1 = "bc12e315740f3a36a6db85fa2c0212a848bd239e"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.4.2"

[[deps.ScanByte]]
deps = ["Libdl", "SIMD"]
git-tree-sha1 = "2436b15f376005e8790e318329560dcc67188e84"
uuid = "7b38b023-a4d7-4c5e-8d43-3f3097f304eb"
version = "0.3.3"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "f94f779c94e58bf9ea243e77a37e16d9de9126bd"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SignedDistanceFields]]
deps = ["Random", "Statistics", "Test"]
git-tree-sha1 = "d263a08ec505853a5ff1c1ebde2070419e3f28e9"
uuid = "73760f76-fbc4-59ce-8f25-708e95d2df96"
version = "0.4.0"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "8fb59825be681d451c246a795117f317ecbcaa28"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.2"

[[deps.SnoopPrecompile]]
git-tree-sha1 = "f604441450a3c0569830946e5b33b78c928e1a85"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.1"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "a4ada03f999bd01b3a25dcaa30b2d929fe537e00"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.0"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "d75bda01f8c31ebb72df80a46c88b25d1c79c56d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.7"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

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

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f9af7f195fb13589dd2e2d57fdb401717d2eb1f6"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.5.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StatsFuns]]
deps = ["ChainRulesCore", "HypergeometricFunctions", "InverseFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "ab6083f09b3e617e34a956b43e9d51b824206932"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.1.1"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "GPUArraysCore", "StaticArraysCore", "Tables"]
git-tree-sha1 = "b03a3b745aa49b566f128977a7dd1be8711c5e71"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.14"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "c79322d36826aa2f4fd8ecfa96ddb47b174ac78d"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.10.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "UUIDs"]
git-tree-sha1 = "7e6b0e3e571be0b4dd4d2a9a3a83b65c04351ccc"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.6.3"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "e4bdc63f5c6d62e80eb1c0043fcc0360d5950ff7"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.10"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.TriplotBase]]
git-tree-sha1 = "4d4ed7f294cda19382ff7de4c137d24d16adc89b"
uuid = "981d1d27-644d-49a2-9326-4793e63143c3"
version = "0.1.0"

[[deps.URIs]]
git-tree-sha1 = "ac00576f90d8a259f2c9d823e91d1de3fd44d348"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "de67fa59e33ad156a590055375a30b23c40299d3"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.5"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "93c41695bc1c08c46c5899f4fe06d6ead504bb73"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.10.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.isoband_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51b5eeb3f98367157a7a12a1fb0aa5328946c03c"
uuid = "9a68df92-36a6-505f-a73e-abb412b6bfb4"
version = "0.2.3+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "d4f63314c8aa1e48cd22aa0c17ed76cd1ae48c3c"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"
"""

# ╔═╡ Cell order:
# ╟─288367b6-7f13-11ed-3907-f7f3e8d727fc
# ╟─125b4459-a9d0-428c-8419-e898bfd78fad
# ╟─31ea47e9-d2b7-4b41-bf1e-147cf337f434
# ╟─d00bdc85-be4e-4ac2-bde8-4f9f4931463e
# ╠═b1675c8a-9c54-4aab-9f8c-39ef6d5e148f
# ╠═868d73b7-3ef1-4e05-bb95-6cbf0d0bb1c7
# ╟─693a2278-6817-443f-a5e4-59d79bcfe5d4
# ╠═f20ac4b5-b2b3-49ee-bd09-755976a03c3f
# ╠═df46ee30-c693-43ec-95e0-230b84f42a5e
# ╟─9a904bb6-83c7-4cfa-909c-bfc75365dd76
# ╠═641b0a44-4b0f-4d09-a3df-2bf0adc409a6
# ╠═913d68c5-bdb6-463a-bfcb-6588782f2667
# ╠═0c1da97a-b507-4da6-9502-f575fa086394
# ╠═18568678-7e88-4741-867d-1357db201867
# ╟─9d34ef77-63b4-4181-a01c-93009652c622
# ╟─11ec5e09-11d7-414e-8ab7-ed4964ff5468
# ╟─f2d48e77-1ebd-49fc-9fde-234b2c82bde9
# ╟─7a798f67-1435-467f-989f-b081a6821060
# ╟─6f687afb-f5b1-4c70-a497-750d06e52262
# ╟─6ea14080-5089-496a-b215-ce0352ccf7aa
# ╟─bab7fb57-3101-4f0a-a15d-a6ae92385953
# ╟─c5a0a410-b603-47b8-b67d-1da91a0e2684
# ╠═ece7db54-b0dd-44dd-9a71-55f94470cecf
# ╠═cc925702-5622-41b4-b15b-bc1f4b195985
# ╠═3ee2e185-4781-44fc-83b5-26c91acb3881
# ╟─600a9bc6-be0c-4ec9-a39a-1af32f010698
# ╠═ce631ffa-f2cc-4598-8b63-e77e69a79425
# ╠═f193ef75-f5ca-450d-a2ac-791096f5a038
# ╠═ea3cf262-23c3-45c6-9c7b-4c7b342b4bd2
# ╟─72c5e84d-1c02-487d-b546-5aa4698e3f2f
# ╠═8a30696f-3e8d-4141-ab15-321e305bdb7a
# ╠═1c6a1233-56c6-4ca9-ad97-f9ef7596888f
# ╠═89ecce3c-22c1-4373-b266-7679a8d4c3ac
# ╠═ab1a162b-d161-4e23-b4a1-e34065f0a28b
# ╠═db3861c5-4107-4a7b-ad38-4c701ff7116e
# ╟─bd1e2f24-a864-4cda-aa1f-25b6a2611605
# ╠═abbbce86-3e15-429b-ae0b-f979e686a850
# ╠═8c5a801a-08a4-4265-8e13-949be7e653aa
# ╠═2518c3fe-e02a-4b3e-b648-08ebc902a321
# ╠═70bf7ccb-2f7d-4f0a-b7d2-19ce9226cc4b
# ╠═87cfd6a4-3b73-4638-99c4-025d1bbd4558
# ╠═3f2a1dc0-5302-4ca7-8fbe-23b602033af2
# ╠═66b52eb5-c0dd-4af8-a007-c914f85c6159
# ╠═7194d8ec-92be-4bb4-bc23-99aa4c5d4fa3
# ╠═a75a3053-56a8-4952-9ff7-0f9fa481b670
# ╠═e0c35d5a-7895-4025-a9e9-10969181f24b
# ╠═2fd7185a-e477-4cd8-bb10-16a8d3e7fa96
# ╟─7c945144-0e28-4496-923b-60e2ef2271ec
# ╠═64f5a862-acb5-4cd4-9337-f85f44820881
# ╠═835ce418-425f-4fcd-8252-4ba0e00a2eea
# ╠═9e1635f8-a30e-489e-9a0c-d6262e525f7b
# ╟─17f65edd-90b9-4c5e-a54c-c73e3dd9dfba
# ╠═3ac6f6c8-95bb-446c-b346-5b540f76a693
# ╠═254dfc28-653b-4ed5-a16e-87037e245456
# ╠═8977d085-8191-4756-88cf-4afc25a10af4
# ╠═ae0b2f9e-7a33-4e14-8432-3731e2b5f2d1
# ╠═eac54768-0797-4e60-bc7b-37351a91198e
# ╠═593f8675-6567-4a29-9cb2-de25153147a7
# ╠═8b450306-d53d-4a9a-a03d-24cd48ae090a
# ╠═903ab884-2349-4566-8b9a-c605d0cad73e
# ╠═c59a2c51-0aac-4bb9-87cd-59d978ea477e
# ╠═6eb1c5ed-b6d6-46f3-ac82-8416e3757484
# ╠═90fbfa0b-a0dd-4392-9cab-8740e7ab0b56
# ╠═542eaf15-c83d-47c6-bf09-e315fbb03da4
# ╟─d5a6ff12-dac6-43fa-9057-84d404ce5255
# ╟─babcb319-d48b-4f07-b887-01584e38daa4
# ╠═46adcc35-b9c1-4ca1-b203-13519b668092
# ╠═b08112df-44a4-4390-b55a-f5e22af8e5b6
# ╠═774918ba-8546-4074-94e1-ec65416724e7
# ╠═9789b7aa-f4fc-4040-8df5-4cc1404a6fe8
# ╠═025b5912-8009-4f5a-b030-0fe9a27dca40
# ╠═030a170c-054a-4be0-b10a-7e77e7eb99a3
# ╠═602b8918-3280-4d52-8873-934eb6028d87
# ╠═bf67213c-cc20-43f8-abfd-10b43b405d66
# ╠═c5648e33-1451-4a6f-baa5-3e4d566f9547
# ╠═bbaaefeb-a4fc-4698-a1c7-95b615a18f4d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
