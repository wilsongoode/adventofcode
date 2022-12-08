### A Pluto.jl notebook ###
# v0.19.16

using Markdown
using InteractiveUtils

# ╔═╡ 89dba7c2-7742-11ed-327d-4b78d395082b
md"# Advent of Code Day 5: Supply Stacks
Link to [Day 5](https://adventofcode.com/2022/day/5)"

# ╔═╡ 6759b5b9-3ba7-4bdb-a999-67ad12af611e
input = """        [C] [B] [H]                
[W]     [D] [J] [Q] [B]            
[P] [F] [Z] [F] [B] [L]            
[G] [Z] [N] [P] [J] [S] [V]        
[Z] [C] [H] [Z] [G] [T] [Z]     [C]
[V] [B] [M] [M] [C] [Q] [C] [G] [H]
[S] [V] [L] [D] [F] [F] [G] [L] [F]
[B] [J] [V] [L] [V] [G] [L] [N] [J]
 1   2   3   4   5   6   7   8   9 

move 5 from 4 to 7
move 8 from 5 to 9
move 6 from 2 to 8
move 7 from 7 to 9
move 1 from 7 to 4
move 2 from 7 to 4
move 9 from 8 to 4
move 16 from 9 to 7
move 1 from 3 to 8
move 15 from 4 to 5
move 3 from 9 to 5
move 2 from 3 to 5
move 1 from 8 to 7
move 3 from 1 to 7
move 5 from 3 to 5
move 13 from 7 to 2
move 5 from 7 to 1
move 7 from 2 to 6
move 2 from 7 to 8
move 3 from 6 to 5
move 2 from 8 to 2
move 2 from 6 to 1
move 11 from 1 to 7
move 2 from 2 to 9
move 8 from 6 to 5
move 2 from 9 to 6
move 3 from 6 to 4
move 1 from 4 to 7
move 22 from 5 to 6
move 13 from 6 to 9
move 5 from 2 to 7
move 6 from 5 to 8
move 13 from 7 to 2
move 2 from 4 to 6
move 5 from 6 to 3
move 2 from 7 to 5
move 3 from 3 to 6
move 2 from 6 to 2
move 8 from 2 to 4
move 2 from 4 to 7
move 2 from 2 to 9
move 5 from 4 to 5
move 2 from 3 to 2
move 1 from 5 to 4
move 6 from 5 to 9
move 1 from 7 to 3
move 1 from 5 to 9
move 5 from 5 to 1
move 1 from 6 to 8
move 1 from 5 to 8
move 4 from 6 to 9
move 8 from 8 to 9
move 1 from 3 to 6
move 4 from 1 to 7
move 3 from 6 to 4
move 7 from 2 to 6
move 27 from 9 to 8
move 3 from 4 to 7
move 6 from 8 to 1
move 1 from 4 to 6
move 1 from 2 to 7
move 7 from 6 to 3
move 1 from 4 to 3
move 4 from 1 to 6
move 1 from 9 to 2
move 1 from 2 to 4
move 1 from 4 to 5
move 3 from 9 to 4
move 5 from 7 to 8
move 2 from 5 to 6
move 4 from 6 to 9
move 10 from 8 to 3
move 2 from 4 to 7
move 3 from 1 to 7
move 2 from 9 to 6
move 6 from 3 to 1
move 7 from 3 to 4
move 2 from 1 to 9
move 4 from 1 to 9
move 1 from 3 to 6
move 1 from 3 to 8
move 2 from 9 to 5
move 2 from 5 to 3
move 3 from 3 to 1
move 1 from 4 to 6
move 5 from 7 to 6
move 2 from 3 to 4
move 2 from 8 to 1
move 9 from 4 to 7
move 4 from 9 to 3
move 2 from 8 to 3
move 1 from 1 to 4
move 1 from 6 to 2
move 1 from 2 to 9
move 6 from 3 to 5
move 2 from 1 to 3
move 1 from 3 to 2
move 1 from 2 to 9
move 8 from 6 to 8
move 2 from 6 to 3
move 1 from 1 to 2
move 7 from 7 to 9
move 13 from 8 to 6
move 1 from 2 to 8
move 6 from 9 to 3
move 1 from 1 to 6
move 2 from 8 to 5
move 5 from 3 to 4
move 2 from 8 to 1
move 8 from 5 to 2
move 4 from 3 to 2
move 5 from 8 to 4
move 2 from 9 to 4
move 4 from 4 to 7
move 10 from 2 to 6
move 1 from 2 to 9
move 24 from 6 to 1
move 17 from 1 to 8
move 1 from 9 to 2
move 2 from 4 to 9
move 10 from 7 to 4
move 1 from 2 to 5
move 5 from 9 to 1
move 1 from 7 to 6
move 12 from 8 to 6
move 1 from 7 to 5
move 2 from 5 to 6
move 16 from 6 to 8
move 12 from 1 to 6
move 2 from 1 to 7
move 9 from 6 to 2
move 2 from 4 to 1
move 1 from 1 to 5
move 7 from 4 to 6
move 13 from 8 to 2
move 5 from 8 to 2
move 2 from 7 to 3
move 2 from 4 to 9
move 1 from 5 to 4
move 3 from 9 to 8
move 2 from 4 to 2
move 2 from 3 to 8
move 1 from 1 to 5
move 1 from 4 to 8
move 6 from 2 to 7
move 1 from 5 to 8
move 1 from 6 to 2
move 7 from 6 to 8
move 1 from 6 to 2
move 24 from 2 to 1
move 10 from 8 to 3
move 4 from 8 to 2
move 4 from 7 to 1
move 5 from 2 to 9
move 1 from 6 to 2
move 10 from 3 to 1
move 2 from 7 to 3
move 2 from 3 to 7
move 2 from 7 to 9
move 35 from 1 to 5
move 28 from 5 to 6
move 2 from 2 to 7
move 19 from 6 to 4
move 3 from 1 to 2
move 3 from 2 to 5
move 23 from 4 to 7
move 2 from 6 to 8
move 4 from 7 to 6
move 3 from 5 to 6
move 13 from 7 to 4
move 2 from 5 to 6
move 2 from 9 to 4
move 5 from 6 to 3
move 6 from 4 to 5
move 1 from 4 to 8
move 4 from 4 to 6
move 5 from 9 to 7
move 2 from 8 to 7
move 5 from 3 to 2
move 4 from 5 to 2
move 5 from 2 to 9
move 4 from 8 to 4
move 1 from 9 to 8
move 2 from 2 to 6
move 4 from 4 to 2
move 3 from 2 to 3
move 3 from 5 to 1
move 2 from 3 to 2
move 3 from 1 to 4
move 1 from 9 to 4
move 5 from 4 to 9
move 2 from 4 to 3
move 5 from 6 to 8
move 1 from 9 to 7
move 2 from 6 to 3
move 1 from 4 to 5
move 1 from 9 to 4
move 6 from 8 to 6
move 2 from 3 to 6
move 2 from 9 to 4
move 2 from 3 to 9
move 1 from 3 to 1
move 17 from 6 to 4
move 1 from 1 to 8
move 1 from 6 to 5
move 1 from 9 to 2
move 11 from 4 to 6
move 9 from 4 to 5
move 7 from 9 to 4
move 2 from 5 to 2
move 1 from 4 to 9
move 5 from 2 to 1
move 1 from 2 to 9
move 4 from 4 to 9
move 4 from 1 to 5
move 1 from 1 to 7
move 1 from 8 to 9
move 8 from 7 to 8
move 4 from 7 to 4
move 9 from 5 to 2
move 2 from 4 to 1
move 11 from 6 to 8
move 2 from 4 to 3
move 2 from 4 to 8
move 1 from 1 to 4
move 3 from 2 to 8
move 1 from 1 to 3
move 3 from 3 to 9
move 8 from 9 to 6
move 1 from 4 to 8
move 2 from 9 to 3
move 5 from 6 to 9
move 7 from 5 to 6
move 2 from 3 to 4
move 5 from 7 to 9
move 2 from 4 to 5
move 2 from 2 to 3
move 10 from 9 to 5
move 2 from 6 to 3
move 6 from 2 to 7
move 10 from 5 to 3
move 6 from 7 to 1
move 2 from 1 to 7
move 4 from 3 to 9
move 3 from 8 to 2
move 2 from 7 to 5
move 19 from 8 to 7
move 4 from 5 to 9
move 4 from 9 to 8
move 1 from 2 to 5
move 3 from 6 to 8
move 1 from 5 to 9
move 5 from 9 to 7
move 6 from 3 to 8
move 1 from 3 to 8
move 2 from 3 to 2
move 23 from 7 to 6
move 10 from 8 to 4
move 4 from 4 to 9
move 4 from 2 to 6
move 1 from 3 to 8
move 4 from 8 to 4
move 31 from 6 to 4
move 9 from 4 to 5
move 8 from 5 to 3
move 1 from 6 to 7
move 2 from 5 to 7
move 4 from 9 to 2
move 21 from 4 to 8
move 4 from 2 to 9
move 3 from 3 to 9
move 2 from 7 to 9
move 11 from 4 to 9
move 1 from 8 to 5
move 1 from 5 to 9
move 9 from 9 to 3
move 3 from 1 to 5
move 2 from 5 to 8
move 11 from 3 to 6
move 4 from 6 to 3
move 2 from 8 to 3
move 10 from 9 to 6
move 22 from 8 to 9
move 1 from 1 to 8
move 4 from 6 to 3
move 2 from 7 to 6
move 3 from 8 to 3
move 14 from 3 to 2
move 1 from 3 to 4
move 1 from 2 to 4
move 2 from 9 to 1
move 1 from 5 to 7
move 1 from 3 to 2
move 14 from 6 to 5
move 13 from 5 to 2
move 1 from 5 to 6
move 1 from 7 to 9
move 8 from 9 to 4
move 2 from 6 to 7
move 23 from 2 to 4
move 2 from 1 to 4
move 2 from 2 to 5
move 1 from 5 to 1
move 1 from 7 to 2
move 1 from 5 to 9
move 16 from 9 to 5
move 1 from 2 to 4
move 13 from 5 to 3
move 1 from 1 to 4
move 1 from 7 to 1
move 1 from 5 to 3
move 2 from 5 to 7
move 2 from 7 to 1
move 9 from 3 to 2
move 2 from 1 to 7
move 1 from 1 to 9
move 19 from 4 to 2
move 1 from 9 to 7
move 1 from 7 to 8
move 23 from 2 to 8
move 2 from 7 to 2
move 12 from 4 to 5
move 12 from 5 to 1
move 5 from 2 to 9
move 2 from 2 to 7
move 5 from 8 to 1
move 3 from 9 to 4
move 1 from 2 to 8
move 1 from 2 to 4
move 4 from 8 to 1
move 2 from 3 to 1
move 2 from 7 to 5
move 1 from 4 to 9
move 8 from 4 to 7
move 13 from 8 to 6
move 1 from 3 to 1
move 13 from 6 to 7
move 13 from 7 to 6
move 7 from 1 to 4
move 5 from 7 to 3
move 3 from 4 to 3
move 13 from 6 to 1
move 3 from 8 to 6
move 8 from 3 to 8
move 12 from 1 to 8
move 1 from 3 to 5
move 6 from 1 to 7
move 3 from 6 to 8
move 1 from 3 to 8
move 1 from 9 to 2
move 3 from 5 to 6
move 1 from 7 to 3
move 8 from 7 to 1
move 2 from 6 to 2
move 3 from 4 to 3
move 2 from 9 to 2
move 6 from 8 to 9
move 5 from 2 to 5
move 2 from 3 to 4
move 5 from 5 to 4
move 1 from 3 to 9
move 8 from 4 to 5
move 1 from 6 to 8
move 2 from 1 to 4
move 1 from 1 to 4
move 3 from 1 to 5
move 3 from 1 to 6
move 7 from 1 to 9
move 2 from 6 to 9
move 1 from 3 to 5
move 17 from 8 to 7
move 17 from 7 to 6
move 5 from 5 to 2
move 5 from 2 to 1
move 13 from 6 to 2
move 1 from 1 to 4
move 5 from 5 to 1
move 1 from 1 to 5
move 10 from 9 to 1
move 13 from 1 to 8
move 13 from 8 to 4
move 5 from 6 to 7
move 8 from 1 to 7
move 1 from 1 to 3
move 12 from 2 to 6
move 1 from 3 to 8
move 6 from 6 to 2
move 2 from 5 to 1
move 5 from 2 to 5
move 2 from 5 to 9
move 12 from 4 to 2
move 1 from 6 to 2
move 15 from 2 to 1
move 1 from 8 to 6
move 2 from 7 to 3
move 2 from 4 to 2
move 1 from 2 to 9
move 1 from 2 to 6
move 7 from 7 to 3
move 1 from 4 to 1
move 17 from 1 to 2
move 3 from 6 to 4
move 1 from 3 to 8
move 3 from 9 to 6
move 4 from 6 to 3
move 13 from 2 to 9
move 3 from 2 to 8
move 2 from 5 to 1
move 6 from 8 to 2
move 1 from 6 to 2
move 3 from 2 to 7
move 3 from 1 to 6
move 2 from 9 to 8
move 6 from 9 to 8
move 8 from 9 to 3
move 7 from 7 to 4
move 20 from 3 to 7
move 4 from 6 to 8
move 1 from 8 to 6
move 2 from 6 to 4
move 3 from 2 to 1
move 2 from 9 to 6
move 9 from 8 to 6
move 3 from 1 to 9
move 9 from 4 to 8
move 1 from 5 to 6
move 3 from 4 to 2
move 1 from 5 to 3
move 8 from 6 to 4
move 4 from 9 to 3
move 10 from 8 to 6
move 5 from 2 to 3
move 3 from 6 to 4
move 10 from 3 to 1
move 11 from 4 to 1
move 1 from 8 to 2
move 2 from 4 to 2
move 1 from 4 to 9
move 10 from 6 to 3
move 21 from 1 to 5
move 2 from 2 to 7
move 1 from 9 to 6
move 1 from 6 to 3
move 1 from 6 to 7
move 11 from 5 to 6
move 1 from 2 to 8
move 1 from 5 to 9
move 11 from 6 to 3
move 1 from 8 to 4
move 1 from 4 to 1
move 3 from 5 to 7
move 1 from 1 to 5
move 5 from 5 to 8
move 23 from 7 to 9
move 5 from 8 to 4
move 1 from 5 to 2
move 12 from 3 to 4
move 6 from 3 to 6
move 1 from 5 to 2
move 8 from 9 to 2
move 1 from 7 to 8
move 2 from 7 to 9
move 4 from 3 to 5
move 1 from 5 to 9
move 1 from 6 to 5
move 4 from 6 to 5
move 3 from 2 to 1
move 3 from 1 to 3
move 8 from 9 to 1
move 4 from 2 to 9
move 1 from 9 to 7
move 14 from 4 to 8
move 3 from 3 to 4
move 1 from 5 to 8
move 2 from 8 to 6
move 2 from 6 to 7
move 4 from 4 to 3
move 12 from 9 to 1
move 1 from 3 to 2
move 6 from 8 to 2
move 1 from 7 to 1
move 5 from 2 to 3
move 21 from 1 to 3
move 5 from 5 to 4
move 1 from 8 to 5
move 2 from 2 to 7
move 1 from 6 to 1
move 2 from 9 to 2
move 1 from 2 to 9
move 1 from 1 to 5
move 4 from 3 to 5
move 7 from 8 to 1
move 6 from 1 to 9
move 1 from 2 to 5
move 6 from 9 to 7
move 8 from 3 to 4
move 2 from 4 to 8
move 1 from 1 to 6
move 10 from 3 to 9
move 12 from 4 to 2
move 1 from 8 to 1"""

# ╔═╡ 7047f79a-7957-463c-a3db-0a1bf2cd7597
md"Crates are in stacks. Instructions are the rearrangement procedure for a crane operator. Even though some steps say to move multiple crates from one stack to another, the crane can only move one crate at a time, so they happen in sequence from top to bottom."

# ╔═╡ 03220cd6-525d-47ed-87c4-f5173393f4b1
stack_str, procedure_str = String.(split(input, "\n\n"))

# ╔═╡ e1e1f643-e54c-4fc2-b3df-9fe9bfa25acb
print(stack_str)

# ╔═╡ 1c976daf-8822-4294-bd70-593bfcd7606a
stack_split = String.(split(stack_str, "\n"))

# ╔═╡ 513eb4b2-fd3d-40f8-9ad3-4b8f49247cf3
stack_indices = [ findfirst(c, last(stack_split)) for c in '1':'9' ]

# ╔═╡ b0bebb73-5eda-4782-9518-f7030944e247
begin
	stacks = []
	
	for i in stack_indices
		stack = [ row[i] for row in reverse(stack_split)[2:end] ]
		filter!(x -> x != ' ', stack)
		push!(stacks, stack)
	end
	stacks
end

# ╔═╡ 457aa561-35ad-4760-a813-67d793b89671
function move_one!(stacks, from::Int, to::Int)
	push!(stacks[to], pop!(stacks[from]))
end

# ╔═╡ 6d88f9f3-4795-49b8-a6f6-69f31087fef5
function move_n!(stacks, n::Int, from::Int, to::Int)
	for _ in 1:n
		move_one!(stacks, from, to)
	end
end

# ╔═╡ 9ab5424e-8f88-47b4-af31-c2460f2e4548
procedure = split(procedure_str, "\n")

# ╔═╡ 09d998b9-5724-4bac-9535-7f8121966a16
function parse_step(procedure_step)
	parse.(Int, match(r"move (\d+) from (\d) to (\d)", procedure_step).captures)
end

# ╔═╡ 8435328d-9742-4253-bd00-ea905e81ba0b
parse_step(procedure[500])

# ╔═╡ 938a5036-0d29-4acf-9238-b14830d61698
function run_procedure(stacks, procedure)
	stacks_copy = deepcopy(stacks)
	for procedure_step in procedure
		move_n!(stacks_copy, parse_step(procedure_step)...)
	end
	stacks_copy
end

# ╔═╡ f2a7de6a-0133-4eff-b68c-9d1b465e57e5
md"## Part 1
After the rearrangement procedure completes, what crate ends up on top of each stack?"

# ╔═╡ f1b6b9b0-edcb-4fab-9fc5-1bdc037b58d9
procedure_result = run_procedure(stacks, procedure)

# ╔═╡ 34a9d905-9249-427f-9a7a-74a168647bc3
join(last.(procedure_result))

# ╔═╡ b9e0843b-d391-4c2c-9ca8-23636d82b21d
md"# Part 2

Now you have a crane that can move multiple crates at once, meaning they stay in the same order rather than being reversed."

# ╔═╡ 9b44273b-406c-46bb-9e72-aa230a97fc1d
function move_n_together!(stacks, n::Int, from::Int, to::Int)
	append!(stacks[to], splice!(stacks[from], lastindex(stacks[from]) - n+1:lastindex(stacks[from])))
end

# ╔═╡ 803e6c67-f72d-4ecc-a8c4-fde1194b574f
function run_new_procedure(stacks, procedure)
	stacks_copy = deepcopy(stacks)
	for procedure_step in procedure
		move_n_together!(stacks_copy, parse_step(procedure_step)...)
	end
	stacks_copy
end

# ╔═╡ b607a3c2-949f-4ccc-a8d2-f638f408beb3
new_procedure_result = run_new_procedure(stacks, procedure)

# ╔═╡ d01f82d5-cc3b-433a-b722-23bf3c8771eb
join(last.(new_procedure_result))

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.3"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╟─89dba7c2-7742-11ed-327d-4b78d395082b
# ╟─6759b5b9-3ba7-4bdb-a999-67ad12af611e
# ╟─7047f79a-7957-463c-a3db-0a1bf2cd7597
# ╠═03220cd6-525d-47ed-87c4-f5173393f4b1
# ╠═e1e1f643-e54c-4fc2-b3df-9fe9bfa25acb
# ╠═1c976daf-8822-4294-bd70-593bfcd7606a
# ╠═513eb4b2-fd3d-40f8-9ad3-4b8f49247cf3
# ╠═b0bebb73-5eda-4782-9518-f7030944e247
# ╠═6d88f9f3-4795-49b8-a6f6-69f31087fef5
# ╠═457aa561-35ad-4760-a813-67d793b89671
# ╠═9ab5424e-8f88-47b4-af31-c2460f2e4548
# ╠═09d998b9-5724-4bac-9535-7f8121966a16
# ╠═8435328d-9742-4253-bd00-ea905e81ba0b
# ╠═938a5036-0d29-4acf-9238-b14830d61698
# ╟─f2a7de6a-0133-4eff-b68c-9d1b465e57e5
# ╠═f1b6b9b0-edcb-4fab-9fc5-1bdc037b58d9
# ╠═34a9d905-9249-427f-9a7a-74a168647bc3
# ╟─b9e0843b-d391-4c2c-9ca8-23636d82b21d
# ╠═9b44273b-406c-46bb-9e72-aa230a97fc1d
# ╠═803e6c67-f72d-4ecc-a8c4-fde1194b574f
# ╠═b607a3c2-949f-4ccc-a8d2-f638f408beb3
# ╠═d01f82d5-cc3b-433a-b722-23bf3c8771eb
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
