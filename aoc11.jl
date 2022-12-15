### A Pluto.jl notebook ###
# v0.19.16

using Markdown
using InteractiveUtils

# ╔═╡ 73ff6280-7bee-11ed-1bbb-89d0bf3ed54b
md"# Advent of Code Day 11: Monkey in the Middle
Link to [Day 11](https://adventofcode.com/2022/day/11)"

# ╔═╡ 9fe9bad9-ea6d-4b12-8d5c-30ef33e5bfde
md"
A group of monkeys have stolen your items and are playing keep-away from you. Your worry level for each item affects what each monkey will do with it after it has inspected it.

Each monkey has several attributes:

- Starting items lists your worry level for each item the monkey is currently holding in the order they will be inspected.
- Operation shows how your worry level changes as that monkey inspects an item. (An operation like new = old * 5 means that your worry level after the monkey inspected the item is five times whatever your worry level was before inspection.)
- Test shows how the monkey uses your worry level to decide where to throw an item next.
  - If true shows what happens with an item if the Test was true.
  - If false shows what happens with an item if the Test was false."

# ╔═╡ 7d6d682d-13f5-4744-8594-e45a2a9b7196
input = """Monkey 0:
  Starting items: 63, 84, 80, 83, 84, 53, 88, 72
  Operation: new = old * 11
  Test: divisible by 13
    If true: throw to monkey 4
    If false: throw to monkey 7

Monkey 1:
  Starting items: 67, 56, 92, 88, 84
  Operation: new = old + 4
  Test: divisible by 11
    If true: throw to monkey 5
    If false: throw to monkey 3

Monkey 2:
  Starting items: 52
  Operation: new = old * old
  Test: divisible by 2
    If true: throw to monkey 3
    If false: throw to monkey 1

Monkey 3:
  Starting items: 59, 53, 60, 92, 69, 72
  Operation: new = old + 2
  Test: divisible by 5
    If true: throw to monkey 5
    If false: throw to monkey 6

Monkey 4:
  Starting items: 61, 52, 55, 61
  Operation: new = old + 3
  Test: divisible by 7
    If true: throw to monkey 7
    If false: throw to monkey 2

Monkey 5:
  Starting items: 79, 53
  Operation: new = old + 1
  Test: divisible by 3
    If true: throw to monkey 0
    If false: throw to monkey 6

Monkey 6:
  Starting items: 59, 86, 67, 95, 92, 77, 91
  Operation: new = old + 5
  Test: divisible by 19
    If true: throw to monkey 4
    If false: throw to monkey 0

Monkey 7:
  Starting items: 58, 83, 89
  Operation: new = old * 19
  Test: divisible by 17
    If true: throw to monkey 2
    If false: throw to monkey 1"""

# ╔═╡ 2b4626a1-de6e-478b-b03a-8aeaa874367e
struct Monkey
	id::Int64
	items::Vector{Int64}
	operation::Function
	# test::Function
	divide_by::Int64
	if_true::Int64
	if_false::Int64
end

# ╔═╡ 8194fc77-799b-452e-96e8-df0834323200
function parse_input_into_monkeys(input)
	output = Monkey[]
	monkey_regex = r"(?:Monkey )(\d+):\n  (?:Starting items: )(.+)\n  (?:Operation: new = )(.+)\n  (?:Test: divisible by )(\d+)\n.   (?:If true: throw to monkey )(\d+)\n.   (?:If false: throw to monkey )(\d+)"

	for input_monkey in split(input, "\n\n")
		# println(input_monkey, "\n")
		monkey_match = match(monkey_regex, input_monkey).captures
		
		monkey_id = parse(Int, monkey_match[1])
		monkey_items = parse.(Int, split(monkey_match[2], ","))
		monkey_operation = function (x)
			ex = Meta.parse(monkey_match[3])
			replace!(ex.args, :old=>x)	
			eval(ex)
		end
		# monkey_test = function (x)
		# 	if x % parse(Int, monkey_match[4]) == 0
		# 		parse(Int, monkey_match[5])
		# 	else
		# 		parse(Int, monkey_match[6])
		# 	end
		# end
		monkey_divide_by = parse(Int, monkey_match[4])
		monkey_if_true = parse(Int, monkey_match[5])
		monkey_if_false = parse(Int, monkey_match[6])
		
		push!(output, Monkey(
			monkey_id,
			monkey_items,
			monkey_operation,
			# monkey_test
			monkey_divide_by,
			monkey_if_true,
			monkey_if_false
		))
	end

	output
end

# ╔═╡ 42c55ea7-57c2-4bda-b8ca-79134894bfc6
monkeys = parse_input_into_monkeys(input)

# ╔═╡ e53781d4-baea-4e0e-ae82-9932cbb2d567
example_input = """Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1"""

# ╔═╡ f2eb9b37-9bc5-4ad4-b9f9-04a1deca0f4e
example_monkeys = parse_input_into_monkeys(example_input)

# ╔═╡ ebc625cc-0fd3-4ce1-8f19-648400041b92
md"## Part 1
Figure out which monkeys to chase by counting how many items they inspect over 20 rounds. **What is the level of monkey business after 20 rounds of stuff-slinging simian shenanigans?**

*Monkey business* = No. of items inspected by the two most active monkeys, multiplied together."

# ╔═╡ 656038f0-07cc-40ce-9005-cee3d8d5af83
function monkey_business(input_monkeys::Vector{Monkey})
	monkeys = deepcopy(input_monkeys)
	inspections = zeros(Int, length(monkeys))
	# 20 rounds
	for _ in 1:20
		for monkey in monkeys
			# println("Monkey: ", monkey.id)
			while !isempty(monkey.items)
				# println(item)
				item = popfirst!(monkey.items)
				inspections[monkey.id + 1] += 1
				worry = fld(monkey.operation(item), 3)
				# next_monkey = monkey.test(worry) + 1
				if worry % monkey.divide_by == 0
					next_monkey = monkey.if_true
				else
					next_monkey = monkey.if_false
				end
				push!(monkeys[next_monkey + 1].items, worry)
				# println("\t$item -> $worry\tthrew to $next_monkey")
			end
		end
	end
	monkeys, inspections
end

# ╔═╡ 21a54ee4-2d5c-4304-beb3-149a4ad93387
md"Testing against the example"

# ╔═╡ 40166b91-a4ca-44cf-800f-4bee0c2f96d6
ex_monkeys_out, ex_monkey_inspections = monkey_business(example_monkeys)

# ╔═╡ 6a4c4bbf-a8e7-4955-a4a6-3cbe2230ef42
*(sort(ex_monkey_inspections, rev=true)[1:2]...)

# ╔═╡ 33d5406d-6434-4987-bc94-7a8f90bb867a
md"Using my puzzle input"

# ╔═╡ b79912b4-a863-4966-addf-490ecae8eccf
monkeys_out, monkey_inspections = monkey_business(monkeys)

# ╔═╡ cb4f1bbb-1440-4fe7-9a6f-7f28ba9e3981
*(sort(monkey_inspections, rev=true)[1:2]...)

# ╔═╡ eb8489a7-0bc9-4ea1-8281-733af4b6fead
md"## Part 2
Worry levels are no longer divided by three after each item is inspected; you'll need to find another way to keep your worry levels manageable. Starting again from the initial state in your puzzle input, **what is the level of monkey business after 10000 rounds?**"

# ╔═╡ 81be4b15-1bb0-46ea-b8f6-1cb5bc0efad8
a = [ m.divide_by for m in monkeys ]

# ╔═╡ 0e505bbd-fb4e-4016-92ea-7c6d1c49d8f6
prod(a) == lcm(a)

# ╔═╡ f3af47f9-9681-4796-9f68-bf768b44d62c
function monkey_business2(input_monkeys::Vector{Monkey}, manage_worry::Integer)
	monkeys = deepcopy(input_monkeys)
	inspections = zeros(Int, length(monkeys))
	# 20 rounds
	for _ in 1:10_000
		for monkey in monkeys
			# println("Monkey: ", monkey.id)
			while !isempty(monkey.items)
				# println(item)
				item = popfirst!(monkey.items)
				inspections[monkey.id + 1] += 1
				worry = monkey.operation(item) % manage_worry
				if worry % monkey.divide_by == 0
					next_monkey = monkey.if_true
				else
					next_monkey = monkey.if_false
				end
				push!(monkeys[next_monkey + 1].items, worry)
				# println("\t$item -> $worry\tthrew to $next_monkey")
			end
		end
	end
	monkeys, inspections
end

# ╔═╡ eaceef6f-7b98-4027-bdf2-8f6c8b6d0994
md"Testing the example monkeys"

# ╔═╡ c50ac172-ed13-4b7f-957a-5e6d92ace106
ex_monkeys_out2, ex_monkey_inspections2 = monkey_business2(example_monkeys, lcm([m.divide_by for m in example_monkeys]))

# ╔═╡ 1469c1bb-0a4b-4e93-a760-bccafca02cc8
*(sort(ex_monkey_inspections2, rev=true)[1:2]...)

# ╔═╡ 94007b85-8812-462c-bd51-c7bb5a5601f8
md"Testing my monkeys"

# ╔═╡ c68cc543-6898-42cf-8fef-af2b8231527f
monkeys_out2, monkey_inspections2 = monkey_business2(monkeys, lcm([m.divide_by for m in monkeys]))

# ╔═╡ 59761ef8-7540-4fd2-90f3-07d0b524a5c8
*(sort(monkey_inspections2, rev=true)[1:2]...)

# ╔═╡ 748d298e-dce1-4f1b-875d-67900f3cd5fd
md"I was not able to figure out the trick to use the Least Common Multiple of all of the monkey divisors on my own. I found that by looking on Reddit. 

My code for 10,000 rounds is also horrendously slow ~70s."

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
# ╟─73ff6280-7bee-11ed-1bbb-89d0bf3ed54b
# ╟─9fe9bad9-ea6d-4b12-8d5c-30ef33e5bfde
# ╟─7d6d682d-13f5-4744-8594-e45a2a9b7196
# ╠═2b4626a1-de6e-478b-b03a-8aeaa874367e
# ╠═8194fc77-799b-452e-96e8-df0834323200
# ╠═42c55ea7-57c2-4bda-b8ca-79134894bfc6
# ╟─e53781d4-baea-4e0e-ae82-9932cbb2d567
# ╠═f2eb9b37-9bc5-4ad4-b9f9-04a1deca0f4e
# ╟─ebc625cc-0fd3-4ce1-8f19-648400041b92
# ╠═656038f0-07cc-40ce-9005-cee3d8d5af83
# ╟─21a54ee4-2d5c-4304-beb3-149a4ad93387
# ╠═40166b91-a4ca-44cf-800f-4bee0c2f96d6
# ╠═6a4c4bbf-a8e7-4955-a4a6-3cbe2230ef42
# ╟─33d5406d-6434-4987-bc94-7a8f90bb867a
# ╠═b79912b4-a863-4966-addf-490ecae8eccf
# ╠═cb4f1bbb-1440-4fe7-9a6f-7f28ba9e3981
# ╟─eb8489a7-0bc9-4ea1-8281-733af4b6fead
# ╠═81be4b15-1bb0-46ea-b8f6-1cb5bc0efad8
# ╠═0e505bbd-fb4e-4016-92ea-7c6d1c49d8f6
# ╠═f3af47f9-9681-4796-9f68-bf768b44d62c
# ╟─eaceef6f-7b98-4027-bdf2-8f6c8b6d0994
# ╠═c50ac172-ed13-4b7f-957a-5e6d92ace106
# ╠═1469c1bb-0a4b-4e93-a760-bccafca02cc8
# ╟─94007b85-8812-462c-bd51-c7bb5a5601f8
# ╠═c68cc543-6898-42cf-8fef-af2b8231527f
# ╠═59761ef8-7540-4fd2-90f3-07d0b524a5c8
# ╟─748d298e-dce1-4f1b-875d-67900f3cd5fd
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
