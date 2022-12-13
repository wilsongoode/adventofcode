### A Pluto.jl notebook ###
# v0.19.16

using Markdown
using InteractiveUtils

# ╔═╡ abcaef38-7a89-11ed-0775-cbfb4dd26892
md"# Advent of Code Day 10: Cathode-Ray Tube
Link to [Day 10](https://adventofcode.com/2022/day/10)

The CPU has a single register, X, which starts with the value 1. It supports only two instructions:

- `addx V` takes two cycles to complete. After two cycles, the X register is increased by the value V. (V can be negative.)
- `noop` takes one cycle to complete. It has no other effect.

Maybe you can learn something by looking at the value of the X register throughout execution. For now, consider the signal strength (the cycle number multiplied by the value of the X register) during the 20th cycle and every 40 cycles after that (that is, during the 20th, 60th, 100th, 140th, 180th, and 220th cycles)."

# ╔═╡ c606da11-164b-4179-a042-a233c13e9045
input = """addx 2
addx 3
noop
noop
addx 1
addx 5
addx -1
addx 5
addx 1
noop
noop
addx 4
noop
noop
addx 5
addx -5
addx 6
addx 3
addx 1
addx 5
addx 1
noop
addx -38
addx 41
addx -22
addx -14
addx 7
noop
noop
addx 3
addx -2
addx 2
noop
addx 17
addx -12
addx 5
addx 2
addx -16
addx 17
addx 2
addx 5
addx 2
addx -30
noop
addx -6
addx 1
noop
addx 5
noop
noop
noop
addx 5
addx -12
addx 17
noop
noop
noop
noop
addx 5
addx 10
addx -9
addx 2
addx 5
addx 2
addx -5
addx 6
addx 4
noop
noop
addx -37
noop
noop
addx 17
addx -12
addx 30
addx -23
addx 2
noop
addx 3
addx -17
addx 22
noop
noop
noop
addx 5
noop
addx -10
addx 11
addx 4
noop
addx 5
addx -2
noop
addx -6
addx -29
addx 37
addx -30
addx 27
addx -2
addx -22
noop
addx 3
addx 2
noop
addx 7
addx -2
addx 2
addx 5
addx -5
addx 6
addx 2
addx 2
addx 5
addx -25
noop
addx -10
noop
addx 1
noop
addx 2
noop
noop
noop
noop
addx 7
addx 1
addx 4
addx 1
noop
addx 2
noop
addx 3
addx 5
addx -1
noop
addx 3
addx 5
addx 2
addx 1
noop
noop
noop
noop"""

# ╔═╡ 3dc66044-3779-48a4-9627-08fc81e58faf
operations = String.(split(input, "\n"))

# ╔═╡ a1c03167-7b91-4758-afe8-d73a16ba08c1
md"## Part 1
Find the signal strength during the 20th, 60th, 100th, 140th, 180th, and 220th cycles. **What is the sum of these six signal strengths?**"

# ╔═╡ e59c425a-79b8-4391-8f59-cd59d6c6061c
function signal_strength(ops)
	cycle = 1
	X = 1
	interest_cycles = [20, 60, 100, 140, 180, 220]
	output_signals = []

	for operation in ops
		if cycle in interest_cycles
			# println(cycle)
			push!(output_signals, cycle * X)
		end
		
		cycle += 1
		
		if operation != "noop"
		# else 
			if cycle in interest_cycles
				# @show cycle
				push!(output_signals, cycle * X)
			end
			V = parse(Int, split(operation)[2])
			cycle += 1
			X += V
		end
	end

	return output_signals
end	

# ╔═╡ a66bea5d-4012-4872-a7bf-b3b0c7675689
sum(signal_strength(operations))

# ╔═╡ 56edff07-8998-47e0-ae34-e7b69d37becb
md"""# Part 2
It seems like the X register controls the horizontal position of a sprite. Specifically, the sprite is 3 pixels wide, and the X register sets the horizontal position of the **middle** of that sprite. (In this system, there is no such thing as "vertical position": if the sprite's horizontal position puts its pixels where the CRT is currently drawing, then those pixels will be drawn.)

You count the pixels on the CRT: 40 wide and 6 high. This CRT screen draws the top row of pixels left-to-right, then the row below that, and so on. The left-most pixel in each row is in position 0, and the right-most pixel in each row is in position 39.

If the sprite is positioned such that one of its three pixels is the pixel currently being drawn, the screen produces a lit pixel (#); otherwise, the screen leaves the pixel dark (.).

Render the image given by your program. **What eight capital letters appear on your CRT?**
"""

# ╔═╡ bddbbd75-3b02-416c-b2c5-0b1876c3a203
function draw_sprite(ops)
	cycle = 1
	X = 1
	output_Xs = []

	for operation in ops
		push!(output_Xs, X)
		
		cycle += 1
		
		if operation != "noop"
			push!(output_Xs, X)
			
			V = parse(Int, split(operation)[2])
			cycle += 1
			X += V
		end
	end

	return output_Xs
end	

# ╔═╡ 1460e38b-c910-48c6-a210-a7b91c1cc0b9
220 % 40

# ╔═╡ 938d40c8-12a3-4e3e-bb0a-75a63d532d4c
CRT = draw_sprite(operations)

# ╔═╡ 1bfc7559-ee98-428a-9fbd-890cb7682f5b
for (i, x) in enumerate(CRT)
	col = (i - 1) % 40
	pixel = col in x-1:x+1 ? "#" : " "
	col == 39 ? println(pixel) : print(pixel)
end

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
# ╟─abcaef38-7a89-11ed-0775-cbfb4dd26892
# ╟─c606da11-164b-4179-a042-a233c13e9045
# ╠═3dc66044-3779-48a4-9627-08fc81e58faf
# ╟─a1c03167-7b91-4758-afe8-d73a16ba08c1
# ╠═e59c425a-79b8-4391-8f59-cd59d6c6061c
# ╠═a66bea5d-4012-4872-a7bf-b3b0c7675689
# ╟─56edff07-8998-47e0-ae34-e7b69d37becb
# ╠═bddbbd75-3b02-416c-b2c5-0b1876c3a203
# ╠═1460e38b-c910-48c6-a210-a7b91c1cc0b9
# ╠═938d40c8-12a3-4e3e-bb0a-75a63d532d4c
# ╠═1bfc7559-ee98-428a-9fbd-890cb7682f5b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
