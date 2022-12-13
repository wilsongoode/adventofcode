### A Pluto.jl notebook ###
# v0.19.16

using Markdown
using InteractiveUtils

# ╔═╡ 792afeff-5fe0-4bef-9267-d0c960b1a701
using AbstractTrees

# ╔═╡ c7334d20-7772-11ed-3233-eb018d4f2a83
md"# Advent of Code 2022 Day 7: No Space Left On Device
Link to [Day 7](https://adventofcode.com/2022/day/7)"

# ╔═╡ 1a0da6cc-140c-4e8d-a83e-7cc2658a2ea8
input = raw"$ cd /
$ ls
dir bntdgzs
179593 cjw.jgc
110209 grbwdwsm.znn
dir hsswswtq
dir jdfwmhg
dir jlcbpsr
70323 qdtbvqjj
48606 qdtbvqjj.zdg
dir tvcr
dir vhjbjr
dir vvsg
270523 wpsjfqtn.ljt
$ cd bntdgzs
$ ls
297955 gcwcp
$ cd ..
$ cd hsswswtq
$ ls
dir bsjbvff
dir dpgvp
267138 grbwdwsm.znn
dir hldgfpvh
dir jdfwmhg
dir jtgdv
93274 ptsd.nzh
268335 qdtbvqjj.dlh
185530 qdtbvqjj.jrw
dir vcbqdj
dir wtrsg
$ cd bsjbvff
$ ls
dir dmnt
148799 grbwdwsm.znn
324931 hzmqrfc.lsd
211089 qdtbvqjj
$ cd dmnt
$ ls
221038 zht
$ cd ..
$ cd ..
$ cd dpgvp
$ ls
dir fzttpjtd
dir jdrbwrc
dir rwz
dir tssm
$ cd fzttpjtd
$ ls
149872 jdfwmhg
$ cd ..
$ cd jdrbwrc
$ ls
149973 hpgg.srm
dir ptsd
$ cd ptsd
$ ls
2594 twzf.pqq
$ cd ..
$ cd ..
$ cd rwz
$ ls
dir jdfwmhg
302808 zzlh
$ cd jdfwmhg
$ ls
229683 cdcrgcmh
218733 nhzt
$ cd ..
$ cd ..
$ cd tssm
$ ls
dir ptsd
37272 qfnnrqsh.qvg
215066 wnvjc.jqf
$ cd ptsd
$ ls
24102 bwtbht.dwq
224035 qdtbvqjj.dmp
$ cd ..
$ cd ..
$ cd ..
$ cd hldgfpvh
$ ls
316712 grbwdwsm.znn
328950 tqvgqjrr
$ cd ..
$ cd jdfwmhg
$ ls
130652 gcwcp
dir jdfwmhg
215427 lfw.zml
dir qdtbvqjj
4181 rgsvgssj.qsr
$ cd jdfwmhg
$ ls
dir bvm
dir hsswswtq
122279 qznt.jhl
dir sjw
dir zpfdtl
$ cd bvm
$ ls
22841 fbcgh.mrp
dir hsswswtq
dir hstg
41317 ndrt
dir nvmvghb
239316 ptsd
dir qtwvdtsp
98555 vzh
$ cd hsswswtq
$ ls
dir ddcjvjgf
127104 plwvb.pbj
dir ptsd
dir qhp
dir rjtrhgwh
$ cd ddcjvjgf
$ ls
135870 bwtbht.dwq
81968 gcwcp
182253 mrbh.wmc
275931 nsrqrts
322128 pfpcp
$ cd ..
$ cd ptsd
$ ls
214981 jsrlsc
dir wpbdrcw
$ cd wpbdrcw
$ ls
197849 mljfb.ggb
173586 ptsd
$ cd ..
$ cd ..
$ cd qhp
$ ls
293198 bnrgl
$ cd ..
$ cd rjtrhgwh
$ ls
224393 clrp.nst
$ cd ..
$ cd ..
$ cd hstg
$ ls
51671 gdsfpc
209216 hsswswtq
97203 jlnr
dir thdhg
57399 tssm
$ cd thdhg
$ ls
201896 jjp.wvw
$ cd ..
$ cd ..
$ cd nvmvghb
$ ls
210047 gfcrzgj
dir rqjbplv
dir rvwd
292931 sgwvcqfr.bpq
dir vtjd
$ cd rqjbplv
$ ls
105204 gcwcp
$ cd ..
$ cd rvwd
$ ls
66170 jdfwmhg
$ cd ..
$ cd vtjd
$ ls
dir ptsd
$ cd ptsd
$ ls
300524 bwtbht.dwq
$ cd ..
$ cd ..
$ cd ..
$ cd qtwvdtsp
$ ls
289574 wctgtq
$ cd ..
$ cd ..
$ cd hsswswtq
$ ls
24935 gcwcp
dir jzpbdcmc
26834 mljfb.ggb
182501 phnmlsjp.pjc
dir pttnl
dir qdtbvqjj
dir vst
$ cd jzpbdcmc
$ ls
297521 grbwdwsm.znn
dir qwc
dir zzswd
$ cd qwc
$ ls
81143 hsswswtq.rjw
54843 mjvvfsz.rgz
273051 pfwgtmtt.ccs
$ cd ..
$ cd zzswd
$ ls
216062 vlbwz.zmh
$ cd ..
$ cd ..
$ cd pttnl
$ ls
257733 mljfb.ggb
250887 pfwgtmtt.ccs
$ cd ..
$ cd qdtbvqjj
$ ls
34667 gcwcp
$ cd ..
$ cd vst
$ ls
70250 pfwgtmtt.ccs
dir zpcqhml
$ cd zpcqhml
$ ls
219936 jdfwmhg.zbm
$ cd ..
$ cd ..
$ cd ..
$ cd sjw
$ ls
152311 nqjtvzff
157117 pfwgtmtt.ccs
118226 ptsd.vsm
$ cd ..
$ cd zpfdtl
$ ls
189042 gcwcp
$ cd ..
$ cd ..
$ cd qdtbvqjj
$ ls
dir ftz
dir hvlffb
dir lzbb
53335 ptsd
dir qdtbvqjj
$ cd ftz
$ ls
dir fft
256058 gcwcp
497 hsswswtq.vqs
103941 hvtcz.fsg
171587 ljlnz.ffg
115101 mljfb.ggb
dir qdtbvqjj
$ cd fft
$ ls
58845 bwtbht.dwq
136040 gcwcp
256973 mljfb.ggb
$ cd ..
$ cd qdtbvqjj
$ ls
dir fgqhdh
304573 ntm.wmc
$ cd fgqhdh
$ ls
317143 gcwcp
26010 lsfpfdqz
$ cd ..
$ cd ..
$ cd ..
$ cd hvlffb
$ ls
6682 vjt.mcf
$ cd ..
$ cd lzbb
$ ls
dir bbvml
324162 bwtbht.dwq
dir fjs
dir pffntc
dir pnltt
dir ptsd
$ cd bbvml
$ ls
dir qdtbvqjj
dir qssdcrp
dir tssm
$ cd qdtbvqjj
$ ls
246275 qdtbvqjj.cgn
$ cd ..
$ cd qssdcrp
$ ls
274399 hsswswtq
$ cd ..
$ cd tssm
$ ls
dir ssqc
$ cd ssqc
$ ls
178904 njrssmlm.gcm
$ cd ..
$ cd ..
$ cd ..
$ cd fjs
$ ls
dir dmvnp
121967 fqlzlvwt
204348 grbwdwsm.znn
102733 jdfwmhg.qsl
240279 ptsd.jwm
228793 ptsd.nsh
dir ssm
$ cd dmvnp
$ ls
dir psj
dir zjw
$ cd psj
$ ls
170665 gcwcp
56058 lsfzc.dcp
40658 tfsllqqw.fgv
$ cd ..
$ cd zjw
$ ls
79989 fggsl.dmz
$ cd ..
$ cd ..
$ cd ssm
$ ls
106263 bwtbht.dwq
106259 jdfwmhg.qtb
6246 rwbnr.tqv
$ cd ..
$ cd ..
$ cd pffntc
$ ls
111475 qbmrdms.ldm
$ cd ..
$ cd pnltt
$ ls
dir nptfhlf
dir zngmf
$ cd nptfhlf
$ ls
223065 qrb.drh
205674 rdgfz
$ cd ..
$ cd zngmf
$ ls
61655 bwtbht.dwq
$ cd ..
$ cd ..
$ cd ptsd
$ ls
dir hrvrt
dir thwtl
$ cd hrvrt
$ ls
152296 pfwgtmtt.ccs
$ cd ..
$ cd thwtl
$ ls
156783 pfwgtmtt.ccs
323304 sltc
$ cd ..
$ cd ..
$ cd ..
$ cd qdtbvqjj
$ ls
320175 pfwgtmtt.ccs
$ cd ..
$ cd ..
$ cd ..
$ cd jtgdv
$ ls
81164 ptsd.tpj
$ cd ..
$ cd vcbqdj
$ ls
dir crng
330203 gvlrg
152022 qdtbvqjj.slq
294095 rthwj.zrf
dir vjsbf
$ cd crng
$ ls
dir gznrh
$ cd gznrh
$ ls
259458 ptsd
$ cd ..
$ cd ..
$ cd vjsbf
$ ls
47331 hlld.fzf
147103 jdfwmhg
$ cd ..
$ cd ..
$ cd wtrsg
$ ls
144344 dtcc
$ cd ..
$ cd ..
$ cd jdfwmhg
$ ls
323973 qdtbvqjj
$ cd ..
$ cd jlcbpsr
$ ls
dir htrdwm
dir jdfwmhg
dir pwmvbhsl
dir vwfdfmcp
$ cd htrdwm
$ ls
dir btn
105731 dlncqrbm.dgl
158267 gqqghldt
242513 hsswswtq.drj
dir jdfwmhg
212816 swsgtv.wbb
228996 tgll.rcs
$ cd btn
$ ls
50419 pfwgtmtt.ccs
$ cd ..
$ cd jdfwmhg
$ ls
dir bwc
$ cd bwc
$ ls
184634 cfwg
$ cd ..
$ cd ..
$ cd ..
$ cd jdfwmhg
$ ls
319749 hsswswtq
dir jdfwmhg
271619 jdfwmhg.znz
dir jhmmt
181217 mljfb.ggb
11297 rcpl.tgf
83423 zwscbcvm.ths
$ cd jdfwmhg
$ ls
267171 cts.hlf
$ cd ..
$ cd jhmmt
$ ls
84473 jdfwmhg
$ cd ..
$ cd ..
$ cd pwmvbhsl
$ ls
dir jsg
171725 mljfb.ggb
152612 qjr
dir vfsqw
$ cd jsg
$ ls
176951 jdfwmhg.fhn
284927 ljvvtw.wcq
153109 vnvtt
$ cd ..
$ cd vfsqw
$ ls
104559 htsrns.gws
$ cd ..
$ cd ..
$ cd vwfdfmcp
$ ls
291404 csmvbjlt.tdf
$ cd ..
$ cd ..
$ cd tvcr
$ ls
dir djtwv
dir hsswswtq
272845 mdds
dir ndshbjzn
65929 scpltww.twm
dir tssm
30516 zdpscm
dir zqdrdzv
$ cd djtwv
$ ls
271696 cwjj.hjp
$ cd ..
$ cd hsswswtq
$ ls
dir djngm
dir hcz
dir ptsd
$ cd djngm
$ ls
317775 ltwjzpjb.rcj
37776 qdtbvqjj.lzf
$ cd ..
$ cd hcz
$ ls
217741 pgdmr
128868 qdtbvqjj
306138 zbmrplsn
$ cd ..
$ cd ptsd
$ ls
304048 ftm
120236 mdcwvvng
$ cd ..
$ cd ..
$ cd ndshbjzn
$ ls
206408 pfwgtmtt.ccs
$ cd ..
$ cd tssm
$ ls
dir mlcnsf
dir nbgjm
204079 pdljvb
185465 rqgdmbjf.rhr
dir sfnlb
$ cd mlcnsf
$ ls
249868 fqrncwd
29146 zdz.jth
$ cd ..
$ cd nbgjm
$ ls
113314 mljfb.ggb
$ cd ..
$ cd sfnlb
$ ls
234917 tjp
$ cd ..
$ cd ..
$ cd zqdrdzv
$ ls
40790 vtdnhzm
$ cd ..
$ cd ..
$ cd vhjbjr
$ ls
dir glv
dir mvns
dir qbrnh
$ cd glv
$ ls
288849 bgvqll.sfj
259105 jdfwmhg
dir qcjlshcv
$ cd qcjlshcv
$ ls
dir nwqqjcmh
$ cd nwqqjcmh
$ ls
137244 grbwdwsm.znn
312904 mzh
dir qdtbvqjj
$ cd qdtbvqjj
$ ls
dir nlqbq
$ cd nlqbq
$ ls
307636 ptsd.vtr
$ cd ..
$ cd ..
$ cd ..
$ cd ..
$ cd ..
$ cd mvns
$ ls
dir gzqlmrdh
dir qjhtlh
dir tssm
dir vthg
$ cd gzqlmrdh
$ ls
274950 mlzdqwm
$ cd ..
$ cd qjhtlh
$ ls
157835 ptsd.lqm
300380 wst.trp
$ cd ..
$ cd tssm
$ ls
15772 gcwcp
$ cd ..
$ cd vthg
$ ls
dir gdndtlnc
$ cd gdndtlnc
$ ls
3175 hsswswtq.bds
320462 mljfb.ggb
305508 mzvtzvqc
dir qdtbvqjj
154575 tssm.vgb
$ cd qdtbvqjj
$ ls
236889 drnnvh
$ cd ..
$ cd ..
$ cd ..
$ cd ..
$ cd qbrnh
$ ls
dir hsswswtq
4623 hsswswtq.rnf
266326 jrmq.ztg
295980 tssm.vzb
dir wnbfzd
dir zjzhncs
dir zttlggt
$ cd hsswswtq
$ ls
48277 gsqjdbhv
$ cd ..
$ cd wnbfzd
$ ls
97133 mljfb.ggb
$ cd ..
$ cd zjzhncs
$ ls
298303 gcwcp
dir ggr
113206 grbwdwsm.znn
$ cd ggr
$ ls
244876 ptsd.zvb
$ cd ..
$ cd ..
$ cd zttlggt
$ ls
dir hdbwrcm
dir mbvpd
dir mtd
dir ptsd
dir tcwqp
$ cd hdbwrcm
$ ls
267323 bwtbht.dwq
$ cd ..
$ cd mbvpd
$ ls
84087 frf.smv
$ cd ..
$ cd mtd
$ ls
158543 mljfb.ggb
$ cd ..
$ cd ptsd
$ ls
112797 vtschwnb.fnp
$ cd ..
$ cd tcwqp
$ ls
90637 lbsqcj.sfn
179097 tssm.dbl
$ cd ..
$ cd ..
$ cd ..
$ cd ..
$ cd vvsg
$ ls
168715 bwtbht.dwq
dir bwv
dir hsswswtq
dir lqmnjrlb
dir mmrfrj
175244 vct.tsc
dir zwvlhs
$ cd bwv
$ ls
201509 gcwcp
62815 grbwdwsm.znn
dir gwdh
dir mfdvcn
166355 pfwgtmtt.ccs
dir ptsd
169681 qdtbvqjj.fgh
250573 wvndzgv
$ cd gwdh
$ ls
306377 sphrj.pjh
$ cd ..
$ cd mfdvcn
$ ls
27796 bvclvtrm.jlf
65045 cghr.vzg
dir hsswswtq
197145 jdqztgh.pvd
$ cd hsswswtq
$ ls
298155 bwtbht.dwq
$ cd ..
$ cd ..
$ cd ptsd
$ ls
27501 grbwdwsm.znn
231999 jdnsv
113528 rmfmb.zzw
dir tssm
dir vgjfsh
$ cd tssm
$ ls
dir dndv
226375 grbwdwsm.znn
$ cd dndv
$ ls
152739 sdjrzcv.tvs
$ cd ..
$ cd ..
$ cd vgjfsh
$ ls
211409 swtbttb.vrp
170879 vvfnf.hrp
$ cd ..
$ cd ..
$ cd ..
$ cd hsswswtq
$ ls
dir qdtbvqjj
dir tssm
86418 vhsgq
$ cd qdtbvqjj
$ ls
118588 bwtbht.dwq
$ cd ..
$ cd tssm
$ ls
113460 gml.wdg
$ cd ..
$ cd ..
$ cd lqmnjrlb
$ ls
dir tssm
$ cd tssm
$ ls
dir jdfwmhg
$ cd jdfwmhg
$ ls
64663 nswd.rwc
$ cd ..
$ cd ..
$ cd ..
$ cd mmrfrj
$ ls
319070 gltlwnlt.jzw
232039 hspr
104688 hsswswtq.jsr
dir jdfwmhg
88712 jdfwmhg.zcw
dir pfr
dir prnnpwcd
45488 qdtbvqjj
dir tssm
dir wcmwrtjn
$ cd jdfwmhg
$ ls
140910 bjjhtzct.stm
$ cd ..
$ cd pfr
$ ls
289538 qdtbvqjj
217502 vvpwf
$ cd ..
$ cd prnnpwcd
$ ls
dir qdtbvqjj
$ cd qdtbvqjj
$ ls
dir pqg
dir tssm
$ cd pqg
$ ls
222392 ptsd.ggr
$ cd ..
$ cd tssm
$ ls
158252 dcnvjj.zfd
10486 jdfwmhg.qmb
4374 qdtbvqjj.vqm
254229 vgqfw
$ cd ..
$ cd ..
$ cd ..
$ cd tssm
$ ls
dir ptsd
$ cd ptsd
$ ls
173766 fvlsgqb
35658 wtc.vvd
$ cd ..
$ cd ..
$ cd wcmwrtjn
$ ls
160089 chfhpc
76202 frgpdnd.ngw
138996 jsfsfpqg.nhf
dir mlm
dir nbdbzsn
dir ptsd
278574 vrnb
$ cd mlm
$ ls
dir gqwhhmvd
dir nrzvzgrt
dir nzplht
dir zzp
$ cd gqwhhmvd
$ ls
dir ddmvjpj
dir jdfwmhg
$ cd ddmvjpj
$ ls
273423 jdfwmhg
43605 pfwgtmtt.ccs
$ cd ..
$ cd jdfwmhg
$ ls
239406 qctw.vzb
$ cd ..
$ cd ..
$ cd nrzvzgrt
$ ls
20712 gcwcp
239372 gjgdvbwb.gcz
dir hdzhl
124814 jdfwmhg
dir jfzr
295071 qwjgwqp
221611 shrzpsj.dwh
dir tssm
dir wdlsvzvl
$ cd hdzhl
$ ls
dir gfwbd
184323 hsswswtq.mln
177147 nqgqz.tnf
4680 pfwgtmtt.ccs
$ cd gfwbd
$ ls
254870 cldm.fft
301411 tssm.cvn
$ cd ..
$ cd ..
$ cd jfzr
$ ls
dir dvvflnnw
dir jdfwmhg
216389 lwtwn.ttt
201727 pfwgtmtt.ccs
107829 prphc.ncb
5816 sdvq.jvn
$ cd dvvflnnw
$ ls
24741 brtrbwh.wwd
27700 mljfb.ggb
$ cd ..
$ cd jdfwmhg
$ ls
325218 bwtbht.dwq
63718 mvl.ngz
162645 vtd.vgp
$ cd ..
$ cd ..
$ cd tssm
$ ls
60903 pfwgtmtt.ccs
332768 qdtbvqjj.jwb
$ cd ..
$ cd wdlsvzvl
$ ls
142213 vgvd
$ cd ..
$ cd ..
$ cd nzplht
$ ls
275904 hsswswtq
157369 jdfwmhg
84363 jvcvmbm.fht
dir qbjqgg
$ cd qbjqgg
$ ls
331934 gcwcp
$ cd ..
$ cd ..
$ cd zzp
$ ls
151335 flsd.zmj
dir gwlhqlp
99086 jdfwmhg.hft
$ cd gwlhqlp
$ ls
201894 glcnpqzp.jvc
$ cd ..
$ cd ..
$ cd ..
$ cd nbdbzsn
$ ls
169929 bwtbht.dwq
$ cd ..
$ cd ptsd
$ ls
128999 bwtbht.dwq
dir jtlrn
dir pszlt
dir ptjnh
dir ptsd
2981 qdtbvqjj.qcn
dir rpb
dir tcjgpqj
dir tmddnh
dir tssm
$ cd jtlrn
$ ls
124888 grbwdwsm.znn
30046 jznz.dwf
$ cd ..
$ cd pszlt
$ ls
154368 dbblsg.mzr
$ cd ..
$ cd ptjnh
$ ls
306974 grbwdwsm.znn
82840 ptsd
$ cd ..
$ cd ptsd
$ ls
dir ftjhsb
dir jdfwmhg
304012 lqgtvmrl.qbj
96971 mljfb.ggb
$ cd ftjhsb
$ ls
56965 dhgds
$ cd ..
$ cd jdfwmhg
$ ls
dir lssbmtms
dir vmwshd
$ cd lssbmtms
$ ls
95453 gcwcp
198402 mljfb.ggb
1507 mzlmp
40526 twlqhml
$ cd ..
$ cd vmwshd
$ ls
267087 pfwgtmtt.ccs
$ cd ..
$ cd ..
$ cd ..
$ cd rpb
$ ls
dir lqbchlbp
dir ptsd
$ cd lqbchlbp
$ ls
151429 ptsd.tjz
$ cd ..
$ cd ptsd
$ ls
28900 gcwcp
55920 llt
$ cd ..
$ cd ..
$ cd tcjgpqj
$ ls
dir cvdlcvq
329232 hcmj.nvp
232764 nvtmgc.qgs
108056 ptsd.gcn
39056 qdtbvqjj
91792 tssm.wqz
$ cd cvdlcvq
$ ls
46978 grbwdwsm.znn
17760 qrdbsdpj.dhm
$ cd ..
$ cd ..
$ cd tmddnh
$ ls
238434 gggvq.tfc
$ cd ..
$ cd tssm
$ ls
dir tlllv
$ cd tlllv
$ ls
198184 trmf.qqw
$ cd ..
$ cd ..
$ cd ..
$ cd ..
$ cd ..
$ cd zwvlhs
$ ls
19923 gcwcp
129179 grbwdwsm.znn
214660 pghcvh
101270 ptsd.gzl
dir srjlz
$ cd srjlz
$ ls
221301 nrcg.pqw"

# ╔═╡ 8a8087d2-0a27-4658-9265-e5d465cfb719
begin
	cmds = String.(split(input, "\$ ", keepempty=false))
	split_input = split.(cmds, "\n", keepempty=false) .|> x -> String.(x)
end

# ╔═╡ a914522f-dd85-4467-b48b-34504d42af7a
struct FileNode
	name::String
	size::Int
	parent::Union{FileNode,Nothing}
	children::Vector{FileNode}

	# FileNode(name::String) = FileNode(name, 0, nothing, FileNode[])
	FileNode(name::String, size::Int=0, parent::Union{FileNode,Nothing}=nothing, children::Vector{FileNode}=FileNode[]) = new(name, size, parent, children)
end

# ╔═╡ 850050a4-d5e4-47aa-bdef-eb45fa48e87a
AbstractTrees.nodevalue(n::FileNode) = n.name

# ╔═╡ bc17c06e-9d3b-4d97-bdbd-c9537944bc25
AbstractTrees.children(n::FileNode) = n.children

# ╔═╡ 2f628ced-5ab8-4244-9819-e5292ce7b8b0
AbstractTrees.parent(n::FileNode) = n.parent

# ╔═╡ beec14d6-ee4a-4e64-859e-06be2744ddff
AbstractTrees.ParentLinks(n::FileNode) = StoredParents()

# ╔═╡ 447933aa-1721-4410-b54b-46abd7eccb9e
# ╠═╡ disabled = true
#=╠═╡
struct FileTree
	root::FileNode
end
  ╠═╡ =#

# ╔═╡ 7fbcffd6-231c-42fe-abbc-c5bd1ee79094
md"Construct a tree data structure to store information about the file system"

# ╔═╡ a7b4029e-88b4-4009-8afc-a31d8509f5f3
# ╠═╡ disabled = true
#=╠═╡
function parse_cmd(cmd)
	if length(cmd) == 1 & startswith(cmd[1], "cd")
		println(cmd[1][4:end])
	elseif cmd[1] == "ls"
		for c in cmd[2:end]
			println('\t', c)
		end
	end
end
		
  ╠═╡ =#

# ╔═╡ 013b8159-74bd-4924-8c34-17355e4bd54e
#=╠═╡
parse_cmd.(split_input[1:10])
  ╠═╡ =#

# ╔═╡ cfc4c332-a4fd-4525-bcd8-72ada64d4473
function parse_file_tree(root, split_input)
	current_dir = root
	for cmd in split_input
		# println("Current Directory: $(current_dir.name)")
		if startswith(cmd[1], "cd")
			change_to = cmd[1][4:end]
			# println(cmd[1][4:end])
			if change_to == ".."
				current_dir = AbstractTrees.parent(current_dir)
				# println("Changing up to $(current_dir.name)")
			else
				current_dir = current_dir.children[findfirst(n -> n.name == change_to, children(current_dir))]
				# println("Changing down to $(current_dir.name)")
			end
		elseif cmd[1] == "ls"
			for c in cmd[2:end]
				# println('\t', c)
				c_split = String.(split(c))
				if c_split[1] == "dir"
					push!(current_dir.children, FileNode(c_split[2], 0, current_dir))
					# println("Pushed dir: $(c_split[2])")
				else
					push!(current_dir.children, FileNode(c_split[2], parse(Int, c_split[1]), current_dir))
					# println("Pushed file: $(c_split[2])")
				end
			end
		end
	end
	root
end

# ╔═╡ 86f2330b-5851-47ff-9ee9-6c4a5178352d
begin
	# root = FileNode(split_input[1][1][4:end])
	tree = parse_file_tree(
		FileNode(split_input[1][1][4:end]), # root
		split_input[2:end] # all the command after `cd /`
	)
end

# ╔═╡ 0746fbee-cc2d-4d54-9e42-eb63b29c47e9
nodevalue.(tree.children)

# ╔═╡ 9556067e-cdb9-40fa-974a-7f1894cc3b0b
md"""
Directory size = size of all files inside it, plus the size of any directories inside (and their files)

Seems like a good fit for recursion.

Save the size to the directory node?
"""

# ╔═╡ 0ec129c5-e93d-4d56-8213-4ae01a6a133d
getfield.(tree.children, :size)

# ╔═╡ 9b7458eb-91d4-400f-80ac-f89d8a26ff86
function filenode_size(d::FileNode)
	if isempty(d.children)
		return d.size
	end
	
	d_total = d.size
	for child in d.children
		d_total += filenode_size(child)
	end
	return d_total
end

# ╔═╡ 5d9fb9fe-1f09-44c3-8e0c-786880beac2c
filenode_size(tree)

# ╔═╡ 3795ce30-757e-4102-b483-3dbba3e576e9
treebreadth(tree)

# ╔═╡ b5823e55-33f8-4c27-a8d4-29a2d022b7ae
treeheight(tree)

# ╔═╡ a0953c33-3ab9-4219-8839-633424626b58
nodevalues(tree)

# ╔═╡ 4c967674-f005-4178-90da-d9c1f25f06ec
tree_nodes = StatelessBFS(tree) |> collect

# ╔═╡ 7e3852d5-cc8b-4d9d-908d-89f75b7503fb
md"## Part 1
Find all of the directories with a total size of at most 100000. 

**What is the sum of the total sizes of those directories?**"

# ╔═╡ 80b617de-37a4-46b1-9794-b63fba0c43b9
directories = filter(d -> !isempty(d.children), tree_nodes)

# ╔═╡ 3aa9b81c-140b-4583-995e-10a27d3b29f2
directories_lt_100_000 = filter(d -> filenode_size(d) ≤ 100_000, directories)

# ╔═╡ a4461141-9828-46d8-a8ec-f05b73add638
sum(filenode_size, directories_lt_100_000)

# ╔═╡ 00190052-c684-4f21-b98d-7d51e49935a5
md"## Part 2
Find a directory that can be 'deleted' to free up enough space on a 70,000,000 filesystem for a 30,000,000 update file. Take into account the current disk usage.

Choose the smallest directory possible that will still free enough space for the update file. 

**What is the total size of that directory?**"

# ╔═╡ 9704916d-6cb0-4d5d-8f89-e72045cf1a13
free_space = 70_000_000 - filenode_size(tree)

# ╔═╡ 2a0928e6-8034-416d-8e7c-26fa2146d58b
need_to_free = 30_000_000 - free_space

# ╔═╡ 9f7369b5-639d-4613-8be0-884b7386b723
minimum(filenode_size, filter(d -> filenode_size(d) ≥ need_to_free, directories))

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractTrees = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"

[compat]
AbstractTrees = "~0.4.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.3"
manifest_format = "2.0"
project_hash = "ca294cf42c2e860f3e80b9bfd777d8cc25a85a25"

[[deps.AbstractTrees]]
git-tree-sha1 = "52b3b436f8f73133d7bc3a6c71ee7ed6ab2ab754"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.3"
"""

# ╔═╡ Cell order:
# ╟─c7334d20-7772-11ed-3233-eb018d4f2a83
# ╟─1a0da6cc-140c-4e8d-a83e-7cc2658a2ea8
# ╠═8a8087d2-0a27-4658-9265-e5d465cfb719
# ╠═792afeff-5fe0-4bef-9267-d0c960b1a701
# ╠═a914522f-dd85-4467-b48b-34504d42af7a
# ╠═850050a4-d5e4-47aa-bdef-eb45fa48e87a
# ╠═bc17c06e-9d3b-4d97-bdbd-c9537944bc25
# ╠═2f628ced-5ab8-4244-9819-e5292ce7b8b0
# ╠═beec14d6-ee4a-4e64-859e-06be2744ddff
# ╠═447933aa-1721-4410-b54b-46abd7eccb9e
# ╟─7fbcffd6-231c-42fe-abbc-c5bd1ee79094
# ╠═a7b4029e-88b4-4009-8afc-a31d8509f5f3
# ╠═013b8159-74bd-4924-8c34-17355e4bd54e
# ╠═cfc4c332-a4fd-4525-bcd8-72ada64d4473
# ╠═86f2330b-5851-47ff-9ee9-6c4a5178352d
# ╠═0746fbee-cc2d-4d54-9e42-eb63b29c47e9
# ╟─9556067e-cdb9-40fa-974a-7f1894cc3b0b
# ╠═0ec129c5-e93d-4d56-8213-4ae01a6a133d
# ╠═9b7458eb-91d4-400f-80ac-f89d8a26ff86
# ╠═5d9fb9fe-1f09-44c3-8e0c-786880beac2c
# ╠═3795ce30-757e-4102-b483-3dbba3e576e9
# ╠═b5823e55-33f8-4c27-a8d4-29a2d022b7ae
# ╠═a0953c33-3ab9-4219-8839-633424626b58
# ╠═4c967674-f005-4178-90da-d9c1f25f06ec
# ╟─7e3852d5-cc8b-4d9d-908d-89f75b7503fb
# ╠═80b617de-37a4-46b1-9794-b63fba0c43b9
# ╠═3aa9b81c-140b-4583-995e-10a27d3b29f2
# ╠═a4461141-9828-46d8-a8ec-f05b73add638
# ╟─00190052-c684-4f21-b98d-7d51e49935a5
# ╠═9704916d-6cb0-4d5d-8f89-e72045cf1a13
# ╠═2a0928e6-8034-416d-8e7c-26fa2146d58b
# ╠═9f7369b5-639d-4613-8be0-884b7386b723
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
